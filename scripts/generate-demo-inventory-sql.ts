/**
 * Writes supabase migration from scripts/demo-products.snapshot.json (archived demo list).
 * Run: npx tsx scripts/generate-demo-inventory-sql.ts
 */
import * as fs from "node:fs";
import * as path from "node:path";
import { fileURLToPath } from "node:url";
import type { Product } from "../src/data/products";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const products = JSON.parse(
  fs.readFileSync(path.join(__dirname, "demo-products.snapshot.json"), "utf8"),
) as Product[];

function escSql(s: string): string {
  return s.replace(/'/g, "''");
}

function buildDescription(p: Product): string {
  const lines: string[] = [];
  lines.push(`Model: ${p.model}`, "", p.description.trim());
  if (p.features?.length) {
    lines.push("", ...p.features.map((f) => `• ${f}`));
  }
  if (p.webLink?.trim()) {
    const link = p.webLink.startsWith("http") ? p.webLink.trim() : `https://${p.webLink.trim()}`;
    lines.push("", `Official product page: ${link}`);
  }
  return lines.join("\n");
}

function main(): void {
  const header = `-- Demo catalog migrated from former src/data/products.ts (legacy slugs preserved for URLs).
-- All rows are inserted under category "accessory" so you can fix categories in Admin.
-- Idempotent: skips rows that already have the same legacy_demo_id.

alter table public.inventory_products
  add column if not exists legacy_demo_id text;

alter table public.inventory_products
  add column if not exists is_featured boolean not null default false;

create unique index if not exists inventory_products_legacy_demo_id_key
  on public.inventory_products (legacy_demo_id)
  where legacy_demo_id is not null;

alter table public.inventory_products
  add column if not exists listing_badge text;
`;

  const inserts: string[] = [];

  for (const p of products) {
    const desc = escSql(buildDescription(p));
    const name = escSql(p.name);
    const legacy = escSql(p.id);
    const img = p.image ? escSql(p.image) : "";
    const imageSql = img ? `'${img}'` : "null";
    const featured = p.featured ? "true" : "false";
    const price = Number(p.price).toFixed(2);
    const badgeSql = p.badge ? `'${escSql(p.badge)}'` : "null";

    inserts.push(`insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  '${name}',
  '${desc}',
  ${price},
  10,
  (select id from public.categories where slug = 'accessory' limit 1),
  ${imageSql},
  '${legacy}',
  ${featured},
  ${badgeSql}
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = '${legacy}'
);
`);
  }

  const outPath = path.join(
    __dirname,
    "../supabase/migrations/20250412140000_seed_demo_catalog.sql",
  );
  fs.writeFileSync(outPath, `${header}\n${inserts.join("\n")}\n`, "utf8");
  console.log(`Wrote ${outPath} (${products.length} products)`);
}

main();
