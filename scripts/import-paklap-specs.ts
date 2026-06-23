/**
 * Fetches Paklap laptop technical specs and writes a Supabase migration.
 * Run: npm run import:paklap-specs
 */
import * as fs from "node:fs";
import * as path from "node:path";
import { execFile } from "node:child_process";
import { promisify } from "node:util";
import { fileURLToPath } from "node:url";
import { CustomException } from "../src/lib/errors";
import type { PaklapLaptop } from "./import-paklap-laptops";
import { parseSpecsFromDetailHtml } from "./paklap-parse";

const execFileAsync = promisify(execFile);
const __dirname = path.dirname(fileURLToPath(import.meta.url));

const USER_AGENT =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36";

function escSql(s: string): string {
  return s.replace(/'/g, "''");
}

function sqlJsonb(value: unknown): string {
  return `'${escSql(JSON.stringify(value))}'::jsonb`;
}

async function fetchHtml(url: string): Promise<string> {
  const curlBin = process.platform === "win32" ? "curl.exe" : "curl";
  const { stdout } = await execFileAsync(
    curlBin,
    ["-sL", url, "-H", `User-Agent: ${USER_AGENT}`, "-H", "Accept: text/html,application/xhtml+xml"],
    { maxBuffer: 16 * 1024 * 1024 },
  );
  const html = String(stdout);
  if (html.includes("cf-error-details") || html.includes("you have been blocked")) {
    throw new CustomException(`Blocked by Cloudflare when fetching ${url}`);
  }
  return html;
}

function buildSpecsMigrationSql(
  items: { importKey: string; specifications: { label: string; value: string }[] }[],
): string {
  const header = `-- Paklap laptop technical specifications for product detail pages.

`;

  const updates = items.map((item) => {
    const key = escSql(item.importKey);
    const specs = sqlJsonb(item.specifications);
    return `update public.inventory_products
set specifications = ${specs}
where legacy_demo_id = '${key}';
`;
  });

  return header + updates.join("\n");
}

async function main(): Promise<void> {
  const snapshotPath = path.join(__dirname, "paklap-laptops.snapshot.json");
  if (!fs.existsSync(snapshotPath)) {
    throw new CustomException(`Snapshot not found: ${snapshotPath}`);
  }

  const laptops = JSON.parse(fs.readFileSync(snapshotPath, "utf8")) as PaklapLaptop[];
  const withSpecs: PaklapLaptop[] = [];
  let index = 0;

  for (const laptop of laptops) {
    index += 1;
    process.stdout.write(`Specs ${index}/${laptops.length}: ${laptop.importKey.slice(0, 42)}…\r`);

    const html = await fetchHtml(laptop.sourceUrl);
    const specifications = parseSpecsFromDetailHtml(html);
    withSpecs.push({ ...laptop, specifications });

    await new Promise((r) => setTimeout(r, 350));
  }

  console.log(`\nParsed specs for ${withSpecs.length} laptops`);

  fs.writeFileSync(snapshotPath, JSON.stringify(withSpecs, null, 2), "utf8");

  const migrationPath = path.join(
    __dirname,
    "../supabase/migrations/20250624190000_paklap_laptop_specifications.sql",
  );
  fs.writeFileSync(
    migrationPath,
    buildSpecsMigrationSql(
      withSpecs.map((l) => ({
        importKey: l.importKey,
        specifications: l.specifications ?? [],
      })),
    ),
    "utf8",
  );
  console.log(`Wrote migration to ${migrationPath}`);
}

main().catch((err) => {
  const ex = err instanceof CustomException ? err : new CustomException(String(err), err);
  console.error(ex.message);
  process.exit(1);
});
