/**
 * Downloads Apple product images and writes a Supabase migration seed.
 * Run: npm run import:apple-products
 */
import * as fs from "node:fs";
import * as path from "node:path";
import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { fileURLToPath } from "node:url";
import { APPLE_PRODUCTS, type AppleProductSeed } from "./apple-products-data";
import { CustomException } from "../src/lib/errors";

const execFileAsync = promisify(execFile);
const __dirname = path.dirname(fileURLToPath(import.meta.url));
const IMAGE_DIR = path.join(__dirname, "../public/products/apple");
const MIGRATION_PATH = path.join(
  __dirname,
  "../supabase/migrations/20250624210000_seed_apple_products.sql",
);

const USER_AGENT =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";

function escSql(s: string): string {
  return s.replace(/'/g, "''");
}

function buildDescription(p: AppleProductSeed): string {
  return `Model: ${p.shortModel}\n\n${p.description}\n\nOfficial product page: ${p.sourceUrl}`;
}

async function downloadImage(url: string, diskPath: string): Promise<void> {
  const curlBin = process.platform === "win32" ? "curl.exe" : "curl";
  await execFileAsync(curlBin, [
    "-sL",
    url,
    "-H",
    `User-Agent: ${USER_AGENT}`,
    "-o",
    diskPath,
  ]);
  const stat = fs.statSync(diskPath);
  if (stat.size < 1000) {
    throw new CustomException(`Download too small for ${url} — got ${stat.size} bytes`);
  }
}

function sqlForProduct(p: AppleProductSeed, imagePath: string): string {
  const description = buildDescription(p);
  const specsJson = escSql(JSON.stringify(p.specifications));
  const variantsSql = p.variants
    ? `'${escSql(JSON.stringify(p.variants))}'::jsonb`
    : "null";

  return `
insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  '${escSql(p.name)}',
  '${escSql(description)}',
  ${p.basePrice.toFixed(2)},
  ${p.stockQuantity},
  (select id from public.categories where slug = 'apple-products' limit 1),
  '${escSql(imagePath)}',
  '${escSql(p.sourceUrl)}',
  true,
  '${specsJson}'::jsonb,
  ${variantsSql},
  '${escSql(p.legacyId)}'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = '${escSql(p.legacyId)}'
);`;
}

function buildMigration(products: { seed: AppleProductSeed; imagePath: string }[]): string {
  const blocks = products.map(({ seed, imagePath }) => sqlForProduct(seed, imagePath));
  return `-- Apple Products catalog seed (Wi-Fi iPads, MacBook Neo, AirPods).
-- Idempotent: skips rows that already exist for the same legacy_demo_id.

${blocks.join("\n")}
`;
}

async function main(): Promise<void> {
  fs.mkdirSync(IMAGE_DIR, { recursive: true });

  const prepared: { seed: AppleProductSeed; imagePath: string }[] = [];

  for (const seed of APPLE_PRODUCTS) {
    const diskPath = path.join(IMAGE_DIR, seed.imageFile);
    const webPath = `/products/apple/${seed.imageFile}`;
    process.stdout.write(`Downloading ${seed.name}…\n`);
    try {
      await downloadImage(seed.imageUrl, diskPath);
    } catch (error) {
      throw new CustomException(
        `Could not download image for ${seed.name}: ${error instanceof Error ? error.message : String(error)}`,
        error,
      );
    }
    prepared.push({ seed, imagePath: webPath });
  }

  const sql = buildMigration(prepared);
  fs.writeFileSync(MIGRATION_PATH, sql, "utf8");
  console.log(`Wrote migration: ${MIGRATION_PATH}`);
  console.log(`Saved ${prepared.length} images to public/products/apple/`);
}

main().catch((err) => {
  console.error(err instanceof CustomException ? err.message : err);
  process.exit(1);
});
