import { products as staticProducts, categories as staticCategories, type Product } from "@/data/products";
import { CustomException } from "@/lib/errors";
import { getSupabase, isSupabaseConfigured } from "@/lib/supabase";
import type { InventoryCategory, InventoryProduct } from "@/types/inventory";
import { getPublicImageUrl } from "@/types/inventory";

export interface ProductSpecification {
  label: string;
  value: string;
}

/** Public storefront category: `id` is the slug (used in /products?category=). */
export interface StorefrontCategory {
  id: string;
  name: string;
  icon: string;
}

/** Shape shared by ProductCard, product detail, and quick quote. */
export interface StorefrontProduct {
  id: string;
  model: string;
  name: string;
  description: string;
  price: number;
  /** Resolved public URL, or "" when missing / misconfigured. */
  image: string;
  /** All gallery URLs for product detail (primary first). */
  images: string[];
  /** Category slug for filters and links. */
  category: string;
  badge?: string;
  features: string[];
  webLink?: string;
  featured?: boolean;
  /** Used for buyer sort options only. */
  stockQuantity?: number;
  specifications: ProductSpecification[];
}

const CATEGORY_ICONS: Record<string, string> = {
  keyboard: "⌨️",
  mouse: "🖱️",
  headset: "🎧",
  combo: "🎮",
  speaker: "🔊",
  microphone: "🎤",
  accessory: "🧩",
  ipad: "📱",
  "apple-pencil": "✏️",
  "ipad-accessories": "🔌",
  mac: "🖥️",
  laptop: "💻",
};

function iconForSlug(slug: string): string {
  return CATEGORY_ICONS[slug] ?? "📦";
}

function inventoryModelLabel(p: InventoryProduct): string {
  return p.name.length > 52 ? `${p.name.slice(0, 49)}…` : p.name;
}

/** Detects normal Postgres gen_random_uuid() ids so we query the right column first. */
function isDatabaseUuid(id: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(id);
}

function splitDescriptionForStorefront(
  description: string,
  fallbackModel: string,
): { model: string; description: string; webLink?: string } {
  let text = description;
  let web: string | undefined;
  const linkMatch = text.match(/\n\nOfficial product page:\s*(https?:\/\/\S+)\s*$/i);
  if (linkMatch && linkMatch.index !== undefined) {
    web = linkMatch[1];
    text = text.slice(0, linkMatch.index).trimEnd();
  }
  const lines = text.split("\n");
  const first = lines[0] ?? "";
  if (first.startsWith("Model:")) {
    const model = first.replace(/^Model:\s*/, "").trim();
    const body = lines.slice(1).join("\n").replace(/^\n+/, "").trim();
    return { model, description: body, webLink: web };
  }
  return { model: fallbackModel, description: text.trim(), webLink: web };
}

function resolveStorefrontImages(
  imagePath: string | null,
  galleryPaths: string[] | null | undefined,
): string[] {
  const paths =
    galleryPaths && galleryPaths.length > 0 ? galleryPaths : imagePath ? [imagePath] : [];
  return paths
    .map((path) => getPublicImageUrl(path))
    .filter((url): url is string => Boolean(url));
}

function inventoryToStorefront(
  p: InventoryProduct,
  cat: InventoryCategory | undefined,
): StorefrontProduct {
  const fallbackModel = inventoryModelLabel(p);
  const parsed = splitDescriptionForStorefront(p.description, fallbackModel);
  const images = resolveStorefrontImages(p.image_path, p.gallery_image_paths);
  const listingBadge = p.listing_badge?.trim();
  return {
    id: p.legacy_demo_id?.trim() || p.id,
    model: parsed.model,
    name: p.name,
    description: parsed.description,
    price: Number(p.price),
    image: images[0] ?? "",
    images,
    category: cat?.slug ?? "accessory",
    features: [],
    webLink: parsed.webLink,
    featured: Boolean(p.is_featured),
    badge: p.stock_quantity === 0 ? "Out of Stock" : listingBadge || undefined,
    stockQuantity: p.stock_quantity,
    specifications: Array.isArray(p.specifications)
      ? p.specifications.filter((row) => row?.label && row?.value)
      : [],
  };
}

function staticProductToStorefront(p: Product): StorefrontProduct {
  const images = p.image ? [p.image] : [];
  return {
    id: p.id,
    model: p.model,
    name: p.name,
    description: p.description,
    price: p.price,
    image: p.image,
    images,
    category: p.category,
    features: [...p.features],
    badge: p.badge,
    webLink: p.webLink,
    featured: p.featured,
    specifications: [],
  };
}

/** Union of demo categories (code) + DB categories so filters cover both lists. */
function mergeStorefrontCategories(dbRows: InventoryCategory[]): StorefrontCategory[] {
  const visibleRows = dbRows
    .filter((row) => row.is_visible !== false)
    .sort((a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0) || a.name.localeCompare(b.name));

  if (visibleRows.length > 0) {
    return visibleRows.map((row) => ({
      id: row.slug,
      name: row.name,
      icon: row.icon?.trim() || iconForSlug(row.slug),
    }));
  }

  const bySlug = new Map<string, StorefrontCategory>();
  for (const c of staticCategories) {
    bySlug.set(c.id, { id: c.id, name: c.name, icon: c.icon });
  }
  return [...bySlug.values()].sort((a, b) => a.name.localeCompare(b.name));
}

async function loadDbStorefrontProducts(
  ...orders: { column: string; ascending: boolean }[]
): Promise<StorefrontProduct[]> {
  const supabase = getSupabase();
  let query = supabase.from("inventory_products").select("*").eq("is_online", true);
  for (const o of orders) {
    query = query.order(o.column, { ascending: o.ascending });
  }
  const { data: productRows, error: productsError } = await query;
  if (productsError) {
    throw new CustomException(productsError.message, productsError);
  }
  const { data: catRows, error: categoriesError } = await supabase.from("categories").select("*");
  if (categoriesError) {
    throw new CustomException(categoriesError.message, categoriesError);
  }
  const catById = new Map((catRows as InventoryCategory[]).map((c) => [c.id, c]));
  return (productRows as InventoryProduct[]).map((p) =>
    inventoryToStorefront(p, catById.get(p.category_id)),
  );
}

export async function fetchCatalogCategories(): Promise<StorefrontCategory[]> {
  if (!isSupabaseConfigured()) {
    return staticCategories.map((c) => ({ id: c.id, name: c.name, icon: c.icon }));
  }
  const supabase = getSupabase();
  const { data, error } = await supabase
    .from("categories")
    .select("*")
    .order("sort_order")
    .order("name");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return mergeStorefrontCategories((data ?? []) as InventoryCategory[]);
}

export async function fetchCatalogProducts(): Promise<StorefrontProduct[]> {
  const fromStatic = staticProducts.map(staticProductToStorefront);
  if (!isSupabaseConfigured()) {
    return fromStatic;
  }
  const fromDb = await loadDbStorefrontProducts(
    { column: "created_at", ascending: false },
    { column: "id", ascending: false },
  );
  return [...fromStatic, ...fromDb];
}

export async function fetchCatalogProductById(id: string): Promise<StorefrontProduct | null> {
  const fromStatic = staticProducts.find((x) => x.id === id);
  if (fromStatic) {
    return staticProductToStorefront(fromStatic);
  }
  if (!isSupabaseConfigured()) {
    return null;
  }
  const supabase = getSupabase();

  let inv: InventoryProduct | null = null;
  if (isDatabaseUuid(id)) {
    const { data, error } = await supabase
      .from("inventory_products")
      .select("*")
      .eq("id", id)
      .eq("is_online", true)
      .maybeSingle();
    if (error) {
      throw new CustomException(error.message, error);
    }
    inv = (data as InventoryProduct) ?? null;
  }
  if (!inv) {
    const { data, error } = await supabase
      .from("inventory_products")
      .select("*")
      .eq("legacy_demo_id", id)
      .eq("is_online", true)
      .maybeSingle();
    if (error) {
      throw new CustomException(error.message, error);
    }
    inv = (data as InventoryProduct) ?? null;
  }

  if (!inv) {
    return null;
  }
  const { data: catRow, error: catError } = await supabase
    .from("categories")
    .select("*")
    .eq("id", inv.category_id)
    .maybeSingle();
  if (catError) {
    throw new CustomException(catError.message, catError);
  }
  return inventoryToStorefront(inv, catRow as InventoryCategory | null | undefined);
}

export async function fetchFeaturedCatalogProducts(limit = 8): Promise<StorefrontProduct[]> {
  const staticFeatured = staticProducts
    .filter((p) => p.featured)
    .map(staticProductToStorefront)
    .slice(0, limit);

  if (!isSupabaseConfigured()) {
    return staticFeatured;
  }

  const supabase = getSupabase();
  const { data: catRows, error: categoriesError } = await supabase.from("categories").select("*");
  if (categoriesError) {
    throw new CustomException(categoriesError.message, categoriesError);
  }
  const catById = new Map((catRows as InventoryCategory[]).map((c) => [c.id, c]));
  const toSf = (row: InventoryProduct) => inventoryToStorefront(row, catById.get(row.category_id));

  const out: StorefrontProduct[] = [...staticFeatured];
  const usedInvIds = new Set<string>();

  const { data: featRows, error: featError } = await supabase
    .from("inventory_products")
    .select("*")
    .eq("is_featured", true)
    .eq("is_online", true)
    .order("name");
  if (featError) {
    throw new CustomException(featError.message, featError);
  }
  for (const row of featRows ?? []) {
    if (out.length >= limit) break;
    const p = row as InventoryProduct;
    usedInvIds.add(p.id);
    out.push(toSf(p));
  }

  const { data: recentRows, error: recentError } = await supabase
    .from("inventory_products")
    .select("*")
    .eq("is_online", true)
    .order("updated_at", { ascending: false })
    .limit(Math.max(limit * 2, 16));
  if (recentError) {
    throw new CustomException(recentError.message, recentError);
  }
  for (const row of recentRows ?? []) {
    if (out.length >= limit) break;
    const p = row as InventoryProduct;
    if (usedInvIds.has(p.id)) continue;
    usedInvIds.add(p.id);
    out.push(toSf(p));
  }

  return out.slice(0, limit);
}
