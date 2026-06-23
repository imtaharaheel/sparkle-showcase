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

function stripTags(html: string): string {
  return decodeHtml(html.replace(/<[^>]+>/g, " "));
}

export interface ProductSpecification {
  label: string;
  value: string;
}

/** Parses Magento additional-attributes specs table from a Paklap product page. */
export function parseSpecsFromDetailHtml(html: string): ProductSpecification[] {
  const tableMatch = html.match(/id="product-attribute-specs-table"[\s\S]*?<\/table>/i);
  if (!tableMatch) {
    return [];
  }

  const specs: ProductSpecification[] = [];
  const rowRe = /<th[^>]*scope="row"[^>]*>([\s\S]*?)<\/th>\s*<td[^>]*>([\s\S]*?)<\/td>/gi;

  for (const match of tableMatch[0].matchAll(rowRe)) {
    const label = stripTags(match[1]);
    const value = stripTags(match[2]);
    if (!label || !value || value === "-") {
      continue;
    }
    specs.push({ label, value });
  }

  return specs;
}
