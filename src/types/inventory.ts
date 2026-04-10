export interface InventoryCategory {
  id: string;
  name: string;
  slug: string;
  created_at: string;
}

export interface InventoryProduct {
  id: string;
  name: string;
  description: string;
  price: number;
  stock_quantity: number;
  category_id: string;
  image_path: string | null;
  created_at: string;
  updated_at: string;
}

export type StockStatusLabel = "In Stock" | "Low Stock" | "Out of Stock";

export function getStockStatus(quantity: number): StockStatusLabel {
  if (quantity === 0) return "Out of Stock";
  if (quantity < 5) return "Low Stock";
  return "In Stock";
}

export function getPublicImageUrl(imagePath: string | null): string | null {
  if (!imagePath) return null;
  const base = import.meta.env.VITE_SUPABASE_URL;
  if (!base) return null;
  const encoded = imagePath.split("/").map(encodeURIComponent).join("/");
  return `${base}/storage/v1/object/public/product-images/${encoded}`;
}
