/**
 * Scrapes Paklap "New Laptops" listing and writes a Supabase seed migration.
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

const BASE_URL = "https://www.paklap.pk/laptops-prices.html";
const USER_AGENT =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";
const DEFAULT_STOCK = 5;

export interface PaklapLaptop {
  name: string;
  price: number;
  regularPrice: number | null;
  sourceUrl: string;
  imageUrl: string;
  listingBadge: string | null;
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

function parseProductsFromHtml(html: string): PaklapLaptop[] {
  const blocks = html.split('class="item product product-item"').slice(1);
  const products: PaklapLaptop[] = [];

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

    const oldPriceMatch = block.match(/data-price-amount="(\d+)"\s+data-price-type="oldPrice"/i);
    const regularPrice = oldPriceMatch ? Number(oldPriceMatch[1]) : null;

    const imageMatch = block.match(
      /class="product-image-photo"\s+src="(https:\/\/www\.paklap\.pk\/media\/[^"]+)"/i,
    );
    const imageUrl = imageMatch?.[1] ?? "";

    const hasSpecial = /class="special-price"/i.test(block);
    const listingBadge = hasSpecial ? "Special" : null;

    if (!name || !sourceUrl || !imageUrl || !Number.isFinite(price)) continue;

    products.push({
      name,
      price,
      regularPrice,
      sourceUrl,
      imageUrl,
      listingBadge,
    });
  }

  return products;
}

function buildDescription(p: PaklapLaptop): string {
  const lines = [`Model: ${p.name}`, "", p.name];
  if (p.regularPrice && p.regularPrice > p.price) {
    lines.push("", `Reference regular price: Rs. ${p.regularPrice.toLocaleString("en-PK")}`);
  }
  lines.push("", `Reference listing: ${p.sourceUrl}`);
  return lines.join("\n");
}

function buildMigrationSql(products: PaklapLaptop[]): string {
  const header = `-- Paklap "New Laptops" catalog import (${products.length} products).
-- Reference prices and images from paklap.pk — update prices manually in Admin.
-- Idempotent: skips rows that already exist with the same source_url.

`;

  const inserts = products.map((p) => {
    const desc = escSql(buildDescription(p));
    const name = escSql(p.name);
    const url = escSql(p.sourceUrl);
    const img = escSql(p.imageUrl);
    const price = p.price.toFixed(2);
    const badgeSql = p.listingBadge ? `'${escSql(p.listingBadge)}'` : "null";

    return `insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, listing_badge)
select
  '${name}',
  '${desc}',
  ${price},
  ${DEFAULT_STOCK},
  (select id from public.categories where slug = 'laptop' limit 1),
  '${img}',
  '${url}',
  ${badgeSql}
where not exists (
  select 1 from public.inventory_products x where x.source_url = '${url}'
);
`;
  });

  return header + inserts.join("\n");
}

async function scrapeAllLaptops(): Promise<PaklapLaptop[]> {
  const byUrl = new Map<string, PaklapLaptop>();

  for (let page = 1; page <= 4; page++) {
    console.log(`Fetching page ${page}…`);
    const html = await fetchPage(page);
    const items = parseProductsFromHtml(html);
    console.log(`  Found ${items.length} products`);
    for (const item of items) {
      byUrl.set(item.sourceUrl, item);
    }
    await new Promise((r) => setTimeout(r, 400));
  }

  return [...byUrl.values()].sort((a, b) => a.price - b.price);
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
    "../supabase/migrations/20250622130000_seed_paklap_laptops.sql",
  );
  fs.writeFileSync(migrationPath, buildMigrationSql(products), "utf8");
  console.log(`Wrote migration to ${migrationPath}`);
}

main().catch((err) => {
  const ex = err instanceof CustomException ? err : new CustomException(String(err), err);
  console.error(ex.message);
  process.exit(1);
});
