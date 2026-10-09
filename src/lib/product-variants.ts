export type VariantDimension = "size" | "color" | "storage";

/** Display order of the option pickers. */
export const VARIANT_DIMENSIONS: VariantDimension[] = ["size", "color", "storage"];

export interface ProductVariantOption {
  id: string;
  size?: string;
  color?: string;
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
  if (!Array.isArray(v.options) || !v.defaultOptionId) {
    return null;
  }
  const options = v.options.filter(
    (o) => o && typeof o.id === "string" && typeof o.price === "number" && o.price >= 0,
  );
  if (options.length === 0) return null;
  // A dimension counts when at least one option uses it, whatever the stored list says.
  const dimensions = VARIANT_DIMENSIONS.filter((d) => options.some((o) => Boolean(o[d])));
  return {
    dimensions,
    choices: v.choices ?? {},
    options,
    defaultOptionId: v.defaultOptionId,
  };
}

function selectionFromOption(option: ProductVariantOption): VariantSelection {
  const sel: VariantSelection = {};
  for (const dim of VARIANT_DIMENSIONS) {
    if (option[dim]) sel[dim] = option[dim];
  }
  return sel;
}

export function getDefaultSelection(variants: ProductVariants): VariantSelection {
  const def = variants.options.find((o) => o.id === variants.defaultOptionId) ?? variants.options[0];
  return selectionFromOption(def);
}

export function findVariantOption(
  variants: ProductVariants,
  selection: VariantSelection,
): ProductVariantOption | null {
  return (
    variants.options.find((o) =>
      variants.dimensions.every((dim) => Boolean(selection[dim]) && (o[dim] ?? "") === selection[dim]),
    ) ?? null
  );
}

/** Every value a dimension has across all options, in first-seen order. */
export function getAllChoicesForDimension(variants: ProductVariants, dimension: VariantDimension): string[] {
  const values = variants.options.map((o) => o[dimension]).filter((v): v is string => Boolean(v));
  return [...new Set(values)];
}

/** True when an option exists with this value and the other currently selected values. */
export function isChoiceAvailable(
  variants: ProductVariants,
  dimension: VariantDimension,
  value: string,
  selection: VariantSelection,
): boolean {
  return findVariantOption(variants, { ...selection, [dimension]: value }) !== null;
}

/**
 * Selection after picking `value`: keeps the other picks when that combination exists,
 * otherwise moves to the closest existing option that has the picked value.
 */
export function selectVariantValue(
  variants: ProductVariants,
  selection: VariantSelection,
  dimension: VariantDimension,
  value: string,
): VariantSelection {
  const next = { ...selection, [dimension]: value };
  if (findVariantOption(variants, next)) return next;
  const candidates = variants.options.filter((o) => o[dimension] === value);
  if (candidates.length === 0) return next;
  const matches = (o: ProductVariantOption) =>
    variants.dimensions.filter((dim) => dim !== dimension && o[dim] === selection[dim]).length;
  const best = candidates.reduce((a, b) => (matches(b) > matches(a) ? b : a));
  return selectionFromOption(best);
}

export function lowestVariantPrice(variants: ProductVariants | null | undefined): number | null {
  if (!variants?.options.length) return null;
  return Math.min(...variants.options.map((o) => o.price));
}

export function resolveDisplayPrice(basePrice: number, variants: ProductVariants | null | undefined): number {
  return lowestVariantPrice(variants) ?? basePrice;
}

export function formatVariantSummary(option: ProductVariantOption): string {
  return VARIANT_DIMENSIONS.map((dim) => option[dim])
    .filter(Boolean)
    .join(" · ");
}

export function formatVariantWhatsAppLine(
  productName: string,
  option: ProductVariantOption | null,
  price: number,
): string {
  const variant = option ? ` (${formatVariantSummary(option)})` : "";
  return `Hi! I'm interested in ${productName}${variant} - Rs. ${price.toLocaleString("en-PK")}. Can you provide more details?`;
}

/** Builds the stored variants object from the option rows edited in admin. */
export function buildProductVariants(options: ProductVariantOption[]): ProductVariants | null {
  if (options.length === 0) return null;
  const dimensions = VARIANT_DIMENSIONS.filter((d) => options.some((o) => Boolean(o[d])));
  const choices: ProductVariants["choices"] = {};
  for (const dim of dimensions) {
    choices[dim] = [...new Set(options.map((o) => o[dim]).filter((v): v is string => Boolean(v)))];
  }
  const cheapest = options.reduce((a, b) => (b.price < a.price ? b : a));
  return { dimensions, choices, options, defaultOptionId: cheapest.id };
}
