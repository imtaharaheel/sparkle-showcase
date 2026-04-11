/**
 * Legacy product shape (used by scripts/demo-products.snapshot.json and types only).
 * Store catalog lives in Supabase `inventory_products`; the public site loads it via `src/lib/catalog.ts`.
 */
export interface ProductVariant {
  color: string;
  colorCode: string;
  storage?: string;
  price: number;
  image: string;
  inStock: boolean;
}

export interface Product {
  id: string;
  model: string;
  name: string;
  category:
    | "keyboard"
    | "mouse"
    | "headset"
    | "combo"
    | "speaker"
    | "microphone"
    | "accessory"
    | "ipad"
    | "apple-pencil"
    | "ipad-accessories"
    | "mac"
    | "laptop";
  price: number;
  description: string;
  features: string[];
  image: string;
  webLink?: string;
  featured?: boolean;
  badge?: string;
  variants?: ProductVariant[];
  storageOptions?: string[];
  colorOptions?: { name: string; code: string }[];
}

/** Empty: all storefront items come from the database. */
export const products: Product[] = [];

export const categories = [
  { id: "keyboard", name: "Keyboards", icon: "⌨️" },
  { id: "mouse", name: "Gaming Mice", icon: "🖱️" },
  { id: "headset", name: "Headsets", icon: "🎧" },
  { id: "combo", name: "Gaming Combos", icon: "🎮" },
  { id: "speaker", name: "Speakers", icon: "🔊" },
  { id: "microphone", name: "Microphones", icon: "🎤" },
  { id: "ipad", name: "iPads", icon: "📱" },
  { id: "apple-pencil", name: "Apple Pencil", icon: "✏️" },
  { id: "ipad-accessories", name: "iPad Accessories", icon: "🔌" },
  { id: "mac", name: "Mac", icon: "🖥️" },
  { id: "laptop", name: "Laptops", icon: "💻" },
] as const;

export const featuredProducts = products.filter((p) => p.featured);

export const getProductsByCategory = (category: string) => products.filter((p) => p.category === category);

export const getProductById = (id: string) => products.find((p) => p.id === id);

export { formatPrice } from "@/lib/formatPrice";
