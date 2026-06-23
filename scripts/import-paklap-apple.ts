/**
 * Scrapes Paklap Apple Products listing, downloads galleries, specs, writes Supabase migration.
 * Run: npm run import:paklap-apple
 */
import * as fs from "node:fs";
import * as path from "node:path";
import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { fileURLToPath } from "node:url";
import { CustomException } from "../src/lib/errors";
import {
  parseGalleryFromDetailHtml,
  toFullSizePaklapImageUrl,
  type PaklapLaptop,
} from "./import-paklap-laptops";
import { parseSpecsFromDetailHtml } from "./paklap-parse";

const execFileAsync = promisify(execFile);
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const IMAGE_DIR = path.join(__dirname, "../public/products/apple");
const MIGRATION_PATH = path.join(
  __dirname,
  "../supabase/migrations/20250624230000_paklap_apple_products.sql",
);
const SNAPSHOT_PATH = path.join(__dirname, "paklap-apple.snapshot.json");

const BASE_URL = "https://www.paklap.pk/apple-products.html";
const USER_AGENT =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";
const DEFAULT_STOCK = 5;
const MAX_PAGES = 10;

export interface PaklapAppleProduct extends PaklapLaptop {
  specifications: { label: string; value: string }[];
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

async function fetchHtml(url: string, label: string): Promise<string> {
  const curlBin = process.platform === "win32" ? "curl.exe" : "curl";
  const { stdout } = await execFileAsync(
    curlBin,
    ["-sL", url, "-H", `User-Agent: ${USER_AGENT}`, "-H", "Accept: text/html,application/xhtml+xml"],
    { maxBuffer: 16 * 1024 * 1024 },
  );
  const html = String(stdout);
  if (html.includes("cf-error-details") || html.includes("you have been blocked")) {
    throw new CustomException(`Blocked by Cloudflare when fetching ${label}: ${url}`);
  }
  return html;
}

function parseListingProducts(html: string): (Omit<PaklapAppleProduct, "localImagePath" | "localGalleryPaths" | "imageUrls" | "specifications"> & {
  listingImageUrl: string;
})[] {
  const blocks = html.split('class="item product product-item"').slice(1);
  const products: (Omit<PaklapAppleProduct, "localImagePath" | "localGalleryPaths" | "imageUrls" | "specifications"> & {
    listingImageUrl: string;
  })[] = [];

  for (const block of blocks) {
    const linkMatch = block.match(/class="product-item-link"\s+href="([^"]+)"[^>]*>([\s\S]*?)<\/a>/i);
    if (!linkMatch) continue;

    const sourceUrl = linkMatch[1].trim();
    const name = decodeHtml(linkMatch[2]);

    const finalPriceMatch = block.match(/data-price-amount="(\d+)"\s+data-price-type="finalPrice"/i);
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
      importKey: importKeyFromUrl(sourceUrl),
      listingImageUrl: imageUrl,
    });
  }

  return products;
}

async function scrapeAllListings(): Promise<
  (Omit<PaklapAppleProduct, "localImagePath" | "localGalleryPaths" | "imageUrls" | "specifications"> & {
    listingImageUrl: string;
  })[]
> {
  const byKey = new Map<
    string,
    Omit<PaklapAppleProduct, "localImagePath" | "localGalleryPaths" | "imageUrls" | "specifications"> & {
      listingImageUrl: string;
    }
  >();

  for (let page = 1; page <= MAX_PAGES; page += 1) {
    const url = page <= 1 ? BASE_URL : `${BASE_URL}?p=${page}`;
    console.log(`Fetching listing page ${page}…`);
    const html = await fetchHtml(url, `listing page ${page}`);
    const items = parseListingProducts(html);
    console.log(`  Found ${items.length} products`);
    if (items.length === 0) break;
    for (const item of items) {
      byKey.set(item.importKey, item);
    }
    if (!html.includes("pages-item-next")) break;
    await new Promise((r) => setTimeout(r, 400));
  }

  return [...byKey.values()].sort((a, b) => a.price - b.price);
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

async function enrichProduct(
  item: Omit<PaklapAppleProduct, "localImagePath" | "localGalleryPaths" | "imageUrls" | "specifications"> & {
    listingImageUrl: string;
  },
  options: { redownload?: boolean },
): Promise<PaklapAppleProduct> {
  const html = await fetchHtml(item.sourceUrl, item.importKey);
  const specifications = parseSpecsFromDetailHtml(html);

  let imageUrls = parseGalleryFromDetailHtml(html).map(toFullSizePaklapImageUrl);
  if (imageUrls.length === 0) {
    imageUrls = [toFullSizePaklapImageUrl(item.listingImageUrl)];
  }

  const localGalleryPaths: string[] = [];
  for (let imageIndex = 0; imageIndex < imageUrls.length; imageIndex += 1) {
    const imageUrl = imageUrls[imageIndex];
    const ext = imageExtension(imageUrl);
    const filename = `${item.importKey}-${imageIndex + 1}${ext}`;
    const diskPath = path.join(IMAGE_DIR, filename);
    const webPath = `/products/apple/${filename}`;

    if (options.redownload || !fs.existsSync(diskPath)) {
      await downloadImage(imageUrl, diskPath);
    }

    localGalleryPaths.push(webPath);
  }

  return {
    ...item,
    imageUrls,
    localImagePath: localGalleryPaths[0] ?? "",
    localGalleryPaths,
    specifications,
  };
}

function sqlTextArray(paths: string[]): string {
  if (paths.length === 0) return "array[]::text[]";
  return `array[${paths.map((p) => `'${escSql(p)}'`).join(", ")}]::text[]`;
}

function sqlJsonb(value: unknown): string {
  return `'${escSql(JSON.stringify(value))}'::jsonb`;
}

function buildMigrationSql(products: PaklapAppleProduct[]): string {
  const header = `-- Paklap Apple Products catalog (scraped from paklap.pk/apple-products.html).
-- Replaces all products in the Apple Products category.

delete from public.inventory_products
where category_id = (select id from public.categories where slug = 'apple-products' limit 1);

`;

  const inserts = products.map((p) => {
    const description = `Reference listing: ${p.sourceUrl}`;
    const gallery = sqlTextArray(p.localGalleryPaths);
    const specs = sqlJsonb(p.specifications);

    return `insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  '${escSql(p.name)}',
  '${escSql(description)}',
  ${p.price.toFixed(2)},
  ${DEFAULT_STOCK},
  (select id from public.categories where slug = 'apple-products' limit 1),
  '${escSql(p.localImagePath)}',
  ${gallery},
  '${escSql(p.sourceUrl)}',
  '${escSql(p.importKey)}',
  true,
  ${specs}
where not exists (
  select 1 from public.inventory_products where source_url = '${escSql(p.sourceUrl)}'
);
`;
  });

  return header + inserts.join("\n");
}

function loadSnapshot(): Omit<PaklapAppleProduct, "localImagePath" | "localGalleryPaths" | "imageUrls" | "specifications">[] {
  if (!fs.existsSync(SNAPSHOT_PATH)) {
    throw new CustomException(`Snapshot not found: ${SNAPSHOT_PATH}`);
  }
  const raw = JSON.parse(fs.readFileSync(SNAPSHOT_PATH, "utf8")) as PaklapAppleProduct[];
  return raw.map(({ localImagePath: _, localGalleryPaths: __, imageUrls: ___, specifications: ____, ...item }) => item);
}

async function main(): Promise<void> {
  const args = new Set(process.argv.slice(2));
  const snapshotOnly = args.has("--snapshot-only");
  const redownload = args.has("--redownload");

  const listings = snapshotOnly ? loadSnapshot() : await scrapeAllListings();
  if (listings.length === 0) {
    throw new CustomException("No Apple products parsed — Paklap HTML layout may have changed.");
  }

  console.log(`Processing ${listings.length} Apple products…`);
  fs.mkdirSync(IMAGE_DIR, { recursive: true });

  const products: PaklapAppleProduct[] = [];
  let index = 0;
  for (const item of listings) {
    index += 1;
    process.stdout.write(`Product ${index}/${listings.length}: ${item.importKey.slice(0, 45)}…\r`);
    products.push(await enrichProduct(item, { redownload }));
    await new Promise((r) => setTimeout(r, 350));
  }

  console.log(`\nEnriched ${products.length} Apple products`);

  fs.writeFileSync(SNAPSHOT_PATH, JSON.stringify(products, null, 2), "utf8");
  fs.writeFileSync(MIGRATION_PATH, buildMigrationSql(products), "utf8");
  console.log(`Wrote snapshot: ${SNAPSHOT_PATH}`);
  console.log(`Wrote migration: ${MIGRATION_PATH}`);
}

main().catch((err) => {
  const ex = err instanceof CustomException ? err : new CustomException(String(err), err);
  console.error(ex.message);
  process.exit(1);
});
