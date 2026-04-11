import { products as staticProducts, categories as staticCategories, type Product } from "@/data/products";
import { CustomException } from "@/lib/errors";
import { getSupabase, isSupabaseConfigured } from "@/lib/supabase";
import type { InventoryCategory, InventoryProduct } from "@/types/inventory";
import { getPublicImageUrl } from "@/types/inventory";

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
  /** Category slug for filters and links. */
  category: string;
  badge?: string;
  features: string[];
  webLink?: string;
  featured?: boolean;
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

function inventoryToStorefront(
  p: InventoryProduct,
  cat: InventoryCategory | undefined,
): StorefrontProduct {
  const url = getPublicImageUrl(p.image_path);
  return {
    id: p.id,
    model: inventoryModelLabel(p),
    name: p.name,
    description: p.description,
    price: Number(p.price),
    image: url ?? "",
    category: cat?.slug ?? "accessory",
    features: [],
    badge: p.stock_quantity === 0 ? "Out of Stock" : undefined,
  };
}

function staticProductToStorefront(p: Product): StorefrontProduct {
  return {
    id: p.id,
    model: p.model,
    name: p.name,
    description: p.description,
    price: p.price,
    image: p.image,
    category: p.category,
    features: [...p.features],
    badge: p.badge,
    webLink: p.webLink,
    featured: p.featured,
  };
}

export async function fetchCatalogCategories(): Promise<StorefrontCategory[]> {
  if (!isSupabaseConfigured()) {
    return staticCategories.map((c) => ({ id: c.id, name: c.name, icon: c.icon }));
  }
  const supabase = getSupabase();
  const { data, error } = await supabase.from("categories").select("*").order("name");
  if (error) {
    throw new CustomException(error.message, error);
  }
  const rows = (data ?? []) as InventoryCategory[];
  return rows.map((c) => ({
    id: c.slug,
    name: c.name,
    icon: iconForSlug(c.slug),
  }));
}

export async function fetchCatalogProducts(): Promise<StorefrontProduct[]> {
  if (!isSupabaseConfigured()) {
    return staticProducts.map(staticProductToStorefront);
  }
  const supabase = getSupabase();
  const { data: productRows, error: productsError } = await supabase
    .from("inventory_products")
    .select("*")
    .order("name");
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

export async function fetchCatalogProductById(id: string): Promise<StorefrontProduct | null> {
  if (!isSupabaseConfigured()) {
    const p = staticProducts.find((x) => x.id === id);
    return p ? staticProductToStorefront(p) : null;
  }
  const supabase = getSupabase();
  const { data: row, error } = await supabase
    .from("inventory_products")
    .select("*")
    .eq("id", id)
    .maybeSingle();
  if (error) {
    throw new CustomException(error.message, error);
  }
  if (!row) {
    return null;
  }
  const inv = row as InventoryProduct;
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
  if (!isSupabaseConfigured()) {
    return staticProducts
      .filter((p) => p.featured)
      .slice(0, limit)
      .map(staticProductToStorefront);
  }
  const supabase = getSupabase();
  const { data: productRows, error: productsError } = await supabase
    .from("inventory_products")
    .select("*")
    .order("updated_at", { ascending: false })
    .limit(limit);
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
