/**
 * Scrapes Paklap "New Laptops" listing, downloads images locally, writes a Supabase migration.
 * Run: npm run import:paklap-laptops
 */
import * as fs from "node:fs";
import * as path from "node:path";
import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { fileURLToPath } from "node:url";
import { CustomException } from "../src/lib/errors";

const execFileAsync = promisify(execFile);

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const LAPTOP_IMAGE_DIR = path.join(__dirname, "../public/products/laptops");

const BASE_URL = "https://www.paklap.pk/laptops-prices.html";
const USER_AGENT =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";
const DEFAULT_STOCK = 5;

export interface PaklapLaptop {
  name: string;
  price: number;
  sourceUrl: string;
  imageUrl: string;
  localImagePath: string;
  importKey: string;
}

function decodeHtml(text: string): string {
  return text
    .replace(/&quot;/g, '"')
    .replace(/&#x27;/g, "'")
    .replace(/&#39;/g, "'")
    .replace(/&amp;/g, "&")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&#x20;/g, " ")
    .replace(/&#(\d+);/g, (_, code) => String.fromCharCode(Number(code)))
    .replace(/\s+/g, " ")
    .trim();
}

function escSql(s: string): string {
  return s.replace(/'/g, "''");
}

function importKeyFromUrl(sourceUrl: string): string {
  const match = sourceUrl.match(/paklap\.pk\/([^/?#]+)\.html/i);
  return match?.[1] ?? sourceUrl.replace(/[^a-z0-9]+/gi, "-").toLowerCase();
}

function imageExtension(imageUrl: string): string {
  const match = imageUrl.match(/\.(jpe?g|png|webp)(\?|$)/i);
  return match ? `.${match[1].toLowerCase().replace("jpeg", "jpg")}` : ".jpg";
}

async function fetchPage(page: number): Promise<string> {
  const url = page <= 1 ? BASE_URL : `${BASE_URL}?p=${page}`;
  const curlBin = process.platform === "win32" ? "curl.exe" : "curl";
  const { stdout } = await execFileAsync(
    curlBin,
    ["-sL", url, "-H", `User-Agent: ${USER_AGENT}`, "-H", "Accept: text/html,application/xhtml+xml"],
    { maxBuffer: 12 * 1024 * 1024 },
  );
  const html = String(stdout);
  if (html.includes("cf-error-details") || html.includes("you have been blocked")) {
    throw new CustomException(`Blocked by Cloudflare when fetching ${url}`);
  }
  if (!html.includes("product-item-link")) {
    throw new CustomException(`Unexpected HTML from ${url} — layout may have changed`);
  }
  return html;
}

function parseProductsFromHtml(html: string): Omit<PaklapLaptop, "localImagePath">[] {
  const blocks = html.split('class="item product product-item"').slice(1);
  const products: Omit<PaklapLaptop, "localImagePath">[] = [];

  for (const block of blocks) {
    const linkMatch = block.match(/class="product-item-link"\s+href="([^"]+)"[^>]*>([\s\S]*?)<\/a>/i);
    if (!linkMatch) continue;

    const sourceUrl = linkMatch[1].trim();
    const name = decodeHtml(linkMatch[2]);

    const finalPriceMatch = block.match(
      /data-price-amount="(\d+)"\s+data-price-type="finalPrice"/i,
    );
    if (!finalPriceMatch) continue;
    const price = Number(finalPriceMatch[1]);

    const imageMatch = block.match(
      /class="product-image-photo"\s+src="(https:\/\/www\.paklap\.pk\/media\/[^"]+)"/i,
    );
    const imageUrl = imageMatch?.[1] ?? "";

    if (!name || !sourceUrl || !imageUrl || !Number.isFinite(price)) continue;

    products.push({
      name,
      price,
      sourceUrl,
      imageUrl,
      importKey: importKeyFromUrl(sourceUrl),
    });
  }

  return products;
}

async function downloadImage(imageUrl: string, destFile: string): Promise<void> {
  const curlBin = process.platform === "win32" ? "curl.exe" : "curl";
  await fs.promises.mkdir(path.dirname(destFile), { recursive: true });
  await execFileAsync(
    curlBin,
    ["-sL", imageUrl, "-o", destFile, "-H", `User-Agent: ${USER_AGENT}`],
    { maxBuffer: 20 * 1024 * 1024 },
  );
  const stat = await fs.promises.stat(destFile);
  if (stat.size < 500) {
    throw new CustomException(`Downloaded image too small: ${imageUrl}`);
  }
}

function buildMigrationSql(products: PaklapLaptop[]): string {
  const header = `-- Re-import Paklap new laptops with clean titles, local images, empty descriptions.
-- Removes previous Paklap rows and re-inserts by import_key.

delete from public.inventory_products
where source_url like 'https://www.paklap.pk/%';

`;

  const inserts = products.map((p) => {
    const name = escSql(p.name);
    const img = escSql(p.localImagePath);
    const key = escSql(p.importKey);
    const price = p.price.toFixed(2);
    const sourceUrl = escSql(p.sourceUrl);

    return `insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  '${name}',
  '',
  ${price},
  ${DEFAULT_STOCK},
  (select id from public.categories where slug = 'laptop' limit 1),
  '${img}',
  '${sourceUrl}',
  '${key}',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = '${key}'
);
`;
  });

  return header + inserts.join("\n");
}

async function scrapeAllLaptops(): Promise<PaklapLaptop[]> {
  const byKey = new Map<string, Omit<PaklapLaptop, "localImagePath">>();

  for (let page = 1; page <= 4; page++) {
    console.log(`Fetching page ${page}…`);
    const html = await fetchPage(page);
    const items = parseProductsFromHtml(html);
    console.log(`  Found ${items.length} products`);
    for (const item of items) {
      byKey.set(item.importKey, item);
    }
    await new Promise((r) => setTimeout(r, 400));
  }

  const scraped = [...byKey.values()].sort((a, b) => a.price - b.price);
  const withImages: PaklapLaptop[] = [];

  fs.mkdirSync(LAPTOP_IMAGE_DIR, { recursive: true });

  let index = 0;
  for (const item of scraped) {
    index += 1;
    const ext = imageExtension(item.imageUrl);
    const filename = `${item.importKey}${ext}`;
    const diskPath = path.join(LAPTOP_IMAGE_DIR, filename);
    const webPath = `/products/laptops/${filename}`;

    if (!fs.existsSync(diskPath)) {
      process.stdout.write(`Downloading image ${index}/${scraped.length}…\r`);
      await downloadImage(item.imageUrl, diskPath);
    }

    withImages.push({ ...item, localImagePath: webPath });
  }

  console.log(`\nDownloaded ${withImages.length} laptop images to public/products/laptops/`);

  return withImages;
}

async function main(): Promise<void> {
  const products = await scrapeAllLaptops();
  if (products.length === 0) {
    throw new CustomException("No laptops parsed — Paklap HTML layout may have changed.");
  }

  const snapshotPath = path.join(__dirname, "paklap-laptops.snapshot.json");
  fs.writeFileSync(snapshotPath, JSON.stringify(products, null, 2), "utf8");
  console.log(`Wrote ${products.length} laptops to ${snapshotPath}`);

  const migrationPath = path.join(
    __dirname,
    "../supabase/migrations/20250623140000_redo_paklap_laptops.sql",
  );
  fs.writeFileSync(migrationPath, buildMigrationSql(products), "utf8");
  console.log(`Wrote migration to ${migrationPath}`);
}

main().catch((err) => {
  const ex = err instanceof CustomException ? err : new CustomException(String(err), err);
  console.error(ex.message);
  process.exit(1);
});
