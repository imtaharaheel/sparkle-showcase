export type VariantDimension = "size" | "storage";

export interface ProductVariantOption {
  id: string;
  size?: string;
  storage?: string;
  price: number;
}

export interface ProductVariants {
  dimensions: VariantDimension[];
  choices: Partial<Record<VariantDimension, string[]>>;
  options: ProductVariantOption[];
  defaultOptionId: string;
}

export type VariantSelection = Partial<Record<VariantDimension, string>>;

export function parseProductVariants(raw: unknown): ProductVariants | null {
  if (!raw || typeof raw !== "object") return null;
  const v = raw as ProductVariants;
  if (!Array.isArray(v.dimensions) || !Array.isArray(v.options) || !v.defaultOptionId) {
    return null;
  }
  const options = v.options.filter(
    (o) => o && typeof o.id === "string" && typeof o.price === "number" && o.price >= 0,
  );
  if (options.length === 0) return null;
  return {
    dimensions: v.dimensions.filter((d) => d === "size" || d === "storage"),
    choices: v.choices ?? {},
    options,
    defaultOptionId: v.defaultOptionId,
  };
}

export function getDefaultSelection(variants: ProductVariants): VariantSelection {
  const def = variants.options.find((o) => o.id === variants.defaultOptionId) ?? variants.options[0];
  const sel: VariantSelection = {};
  if (def.size) sel.size = def.size;
  if (def.storage) sel.storage = def.storage;
  return sel;
}

export function findVariantOption(
  variants: ProductVariants,
  selection: VariantSelection,
): ProductVariantOption | null {
  return (
    variants.options.find((o) => {
      for (const dim of variants.dimensions) {
        const picked = selection[dim];
        if (!picked) return false;
        if (dim === "size" && o.size !== picked) return false;
        if (dim === "storage" && o.storage !== picked) return false;
      }
      return true;
    }) ?? null
  );
}

export function getChoicesForDimension(
  variants: ProductVariants,
  dimension: VariantDimension,
  selection: VariantSelection,
): string[] {
  const matching = variants.options.filter((o) => {
    for (const dim of variants.dimensions) {
      if (dim === dimension) continue;
      const picked = selection[dim];
      if (picked) {
        if (dim === "size" && o.size !== picked) return false;
        if (dim === "storage" && o.storage !== picked) return false;
      }
    }
    return true;
  });
  const values = matching
    .map((o) => (dimension === "size" ? o.size : o.storage))
    .filter((v): v is string => Boolean(v));
  return [...new Set(values)];
}

export function lowestVariantPrice(variants: ProductVariants | null | undefined): number | null {
  if (!variants?.options.length) return null;
  return Math.min(...variants.options.map((o) => o.price));
}

export function resolveDisplayPrice(basePrice: number, variants: ProductVariants | null | undefined): number {
  return lowestVariantPrice(variants) ?? basePrice;
}

export function formatVariantSummary(option: ProductVariantOption): string {
  const parts: string[] = [];
  if (option.size) parts.push(option.size);
  if (option.storage) parts.push(option.storage);
  parts.push("Wi-Fi");
  return parts.join(" · ");
}

export function formatVariantWhatsAppLine(
  productName: string,
  option: ProductVariantOption | null,
  price: number,
): string {
  const variant = option ? ` (${formatVariantSummary(option)})` : "";
  return `Hi! I'm interested in ${productName}${variant} - Rs. ${price.toLocaleString("en-PK")}. Can you provide more details?`;
}
