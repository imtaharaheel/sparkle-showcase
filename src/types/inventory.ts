export interface InventoryCategory {
  id: string;
  name: string;
  slug: string;
  created_at: string;
  /** When false, hidden from shop filters and admin category dropdowns. */
  is_visible?: boolean;
  /** Lower numbers appear first in dropdowns. */
  sort_order?: number;
  /** Emoji shown next to the category name on the shop. */
  icon?: string;
}

export interface InventoryProduct {
  id: string;
  name: string;
  description: string;
  price: number;
  stock_quantity: number;
  category_id: string;
  image_path: string | null;
  /** Additional local paths for product detail gallery (includes primary when set). */
  gallery_image_paths?: string[] | null;
  created_at: string;
  updated_at: string;
  /** Stable id for URLs when migrating from the old demo catalog (e.g. mk14-black). */
  legacy_demo_id?: string | null;
  is_featured?: boolean;
  listing_badge?: string | null;
  /** Original supplier or reference page (e.g. Paklap product URL). */
  source_url?: string | null;
  /** When false, product is hidden from the public website. */
  is_online?: boolean;
}

export type StockStatusLabel = "In Stock" | "Low Stock" | "Out of Stock";

export function getStockStatus(quantity: number): StockStatusLabel {
  if (quantity === 0) return "Out of Stock";
  if (quantity < 5) return "Low Stock";
  return "In Stock";
}

export function getPublicImageUrl(imagePath: string | null): string | null {
  if (!imagePath) return null;
  if (imagePath.startsWith("http://") || imagePath.startsWith("https://")) {
    return imagePath;
  }
  if (imagePath.startsWith("/")) {
    const base = import.meta.env.BASE_URL.replace(/\/$/, "");
    return base ? `${base}${imagePath}` : imagePath;
  }
  const urlBase = import.meta.env.VITE_SUPABASE_URL;
  if (!urlBase) return null;
  const encoded = imagePath.split("/").map(encodeURIComponent).join("/");
  return `${urlBase}/storage/v1/object/public/product-images/${encoded}`;
}
