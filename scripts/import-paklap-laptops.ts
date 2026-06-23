/**
 * Scrapes Paklap "New Laptops" listing, downloads gallery images locally, writes a Supabase migration.
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
  imageUrls: string[];
  localImagePath: string;
  localGalleryPaths: string[];
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

/** Paklap listing pages use ~210px cached thumbnails; strip cache for the original file. */
export function toFullSizePaklapImageUrl(imageUrl: string): string {
  return imageUrl.replace(/\/media\/catalog\/product\/cache\/[^/]+\//i, "/media/catalog/product/");
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

async function fetchPage(page: number): Promise<string> {
  const url = page <= 1 ? BASE_URL : `${BASE_URL}?p=${page}`;
  const html = await fetchHtml(url, `listing page ${page}`);
  if (!html.includes("product-item-link")) {
    throw new CustomException(`Unexpected HTML from ${url} — layout may have changed`);
  }
  return html;
}

/** Reads Magento fotorama gallery JSON from a Paklap product detail page. */
export function parseGalleryFromDetailHtml(html: string): string[] {
  const marker = "[data-gallery-role=gallery-placeholder]";
  const start = html.indexOf(marker);
  if (start === -1) return [];

  const end = html.indexOf("</script>", start);
  const chunk = html.slice(start, end > start ? end + 9 : start + 25000);
  const urls: string[] = [];
  const re = /"full":"(https:\\\/\\\/www\.paklap\.pk\\\/[^"]+)"/g;

  for (const match of chunk.matchAll(re)) {
    urls.push(toFullSizePaklapImageUrl(match[1].replace(/\\\//g, "/")));
  }

  return [...new Set(urls)];
}

async function fetchGalleryUrls(sourceUrl: string, fallbackUrl: string): Promise<string[]> {
  try {
    const html = await fetchHtml(sourceUrl, "product detail");
    const gallery = parseGalleryFromDetailHtml(html);
    if (gallery.length > 0) return gallery;
  } catch {
    // Fall back to listing thumbnail when detail fetch fails.
  }
  return [toFullSizePaklapImageUrl(fallbackUrl)];
}

function parseProductsFromHtml(html: string): Omit<PaklapLaptop, "localImagePath" | "localGalleryPaths" | "imageUrls">[] {
  const blocks = html.split('class="item product product-item"').slice(1);
  const products: (Omit<PaklapLaptop, "localImagePath" | "localGalleryPaths" | "imageUrls"> & {
    listingImageUrl: string;
  })[] = [];

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
      importKey: importKeyFromUrl(sourceUrl),
      listingImageUrl: imageUrl,
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

function sqlTextArray(paths: string[]): string {
  if (paths.length === 0) return "array[]::text[]";
  return `array[${paths.map((p) => `'${escSql(p)}'`).join(", ")}]::text[]`;
}

function buildGalleryMigrationSql(products: PaklapLaptop[]): string {
  const header = `-- Set Paklap laptop gallery images (multiple photos per product).

`;

  const updates = products.map((p) => {
    const key = escSql(p.importKey);
    const primary = escSql(p.localImagePath);
    const gallery = sqlTextArray(p.localGalleryPaths);

    return `update public.inventory_products
set
  image_path = '${primary}',
  gallery_image_paths = ${gallery}
where legacy_demo_id = '${key}';
`;
  });

  return header + updates.join("\n");
}

async function downloadLaptopGalleries(
  items: (Omit<PaklapLaptop, "localImagePath" | "localGalleryPaths" | "imageUrls"> & {
    listingImageUrl?: string;
  })[],
  options: { redownload?: boolean; galleriesOnly?: boolean } = {},
): Promise<PaklapLaptop[]> {
  const withImages: PaklapLaptop[] = [];
  fs.mkdirSync(LAPTOP_IMAGE_DIR, { recursive: true });

  let index = 0;
  for (const item of items) {
    index += 1;
    process.stdout.write(`Gallery ${index}/${items.length}: ${item.importKey.slice(0, 40)}…\r`);

    let fallbackUrl = item.listingImageUrl ?? "";
    if (!fallbackUrl && options.galleriesOnly) {
      const snapshotPath = path.join(__dirname, "paklap-laptops.snapshot.json");
      const snapshot = JSON.parse(fs.readFileSync(snapshotPath, "utf8")) as PaklapLaptop[];
      const prev = snapshot.find((x) => x.importKey === item.importKey);
      fallbackUrl = prev?.imageUrls?.[0] ?? "";
    }

    const imageUrls = await fetchGalleryUrls(item.sourceUrl, fallbackUrl);

    const localGalleryPaths: string[] = [];

    for (let imageIndex = 0; imageIndex < imageUrls.length; imageIndex += 1) {
      const imageUrl = imageUrls[imageIndex];
      const ext = imageExtension(imageUrl);
      const filename = `${item.importKey}-${imageIndex + 1}${ext}`;
      const diskPath = path.join(LAPTOP_IMAGE_DIR, filename);
      const webPath = `/products/laptops/${filename}`;

      if (options.redownload || !fs.existsSync(diskPath)) {
        await downloadImage(imageUrl, diskPath);
      }

      localGalleryPaths.push(webPath);
    }

    withImages.push({
      ...item,
      imageUrls,
      localImagePath: localGalleryPaths[0] ?? "",
      localGalleryPaths,
    });

    await new Promise((r) => setTimeout(r, 350));
  }

  console.log(`\nDownloaded galleries for ${withImages.length} laptops to public/products/laptops/`);
  return withImages;
}

async function scrapeAllLaptops(): Promise<
  (Omit<PaklapLaptop, "localImagePath" | "localGalleryPaths" | "imageUrls"> & { listingImageUrl: string })[]
> {
  const byKey = new Map<
    string,
    Omit<PaklapLaptop, "localImagePath" | "localGalleryPaths" | "imageUrls"> & { listingImageUrl: string }
  >();

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

  return [...byKey.values()].sort((a, b) => a.price - b.price);
}

function loadSnapshot(): Omit<PaklapLaptop, "localImagePath" | "localGalleryPaths" | "imageUrls">[] {
  const snapshotPath = path.join(__dirname, "paklap-laptops.snapshot.json");
  if (!fs.existsSync(snapshotPath)) {
    throw new CustomException(`Snapshot not found: ${snapshotPath}. Run a full import first.`);
  }
  const raw = JSON.parse(fs.readFileSync(snapshotPath, "utf8")) as PaklapLaptop[];
  return raw.map(({ localImagePath: _, localGalleryPaths: __, imageUrls: ___, ...item }) => item);
}

async function main(): Promise<void> {
  const args = new Set(process.argv.slice(2));
  const galleriesOnly = args.has("--galleries-only");
  const redownload = args.has("--redownload");

  const scraped = galleriesOnly ? loadSnapshot() : await scrapeAllLaptops();
  if (scraped.length === 0) {
    throw new CustomException("No laptops parsed — Paklap HTML layout may have changed.");
  }

  const products = await downloadLaptopGalleries(scraped, { redownload, galleriesOnly });

  const snapshotPath = path.join(__dirname, "paklap-laptops.snapshot.json");
  fs.writeFileSync(snapshotPath, JSON.stringify(products, null, 2), "utf8");
  console.log(`Wrote ${products.length} laptops to ${snapshotPath}`);

  const migrationPath = path.join(
    __dirname,
    "../supabase/migrations/20250624140000_paklap_laptop_galleries.sql",
  );
  fs.writeFileSync(migrationPath, buildGalleryMigrationSql(products), "utf8");
  console.log(`Wrote migration to ${migrationPath}`);
}

main().catch((err) => {
  const ex = err instanceof CustomException ? err : new CustomException(String(err), err);
  console.error(ex.message);
  process.exit(1);
});
