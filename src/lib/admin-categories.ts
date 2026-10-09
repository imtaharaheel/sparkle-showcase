import { z } from "zod";
import { getSupabase } from "@/lib/supabase";
import { CustomException } from "@/lib/errors";
import type { InventoryCategory } from "@/types/inventory";

export const categoryFormSchema = z.object({
  name: z.string().trim().min(1, "Name is required").max(80),
  icon: z.string().trim().max(8, "Use a short emoji").optional(),
  sort_order: z.coerce.number().int().min(0).max(999),
  is_visible: z.boolean(),
  /** Parent category id, or "" for a top-level category. */
  parent_id: z.string(),
});

export type CategoryFormValues = z.infer<typeof categoryFormSchema>;

export function slugFromName(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

/** Sorted by order then name, with each subcategory listed right after its parent. */
export function sortCategories(list: InventoryCategory[]): InventoryCategory[] {
  const byOrder = [...list].sort(
    (a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0) || a.name.localeCompare(b.name),
  );
  const ids = new Set(list.map((c) => c.id));
  const isChild = (c: InventoryCategory) => Boolean(c.parent_id && ids.has(c.parent_id));
  return byOrder
    .filter((c) => !isChild(c))
    .flatMap((parent) => [parent, ...byOrder.filter((c) => c.parent_id === parent.id)]);
}

/** "Laptops › Ci7 C7 U7" for subcategories, plain name otherwise. */
export function categoryLabel(category: InventoryCategory, all: InventoryCategory[]): string {
  const parent = category.parent_id ? all.find((c) => c.id === category.parent_id) : undefined;
  return parent ? `${parent.name} › ${category.name}` : category.name;
}

/** The category's own id plus the ids of its subcategories. */
export function categoryFamilyIds(categoryId: string, all: InventoryCategory[]): Set<string> {
  return new Set([categoryId, ...all.filter((c) => c.parent_id === categoryId).map((c) => c.id)]);
}

/** Product counts per category, where a parent's count includes its subcategories. */
export function countProductsByCategory(
  products: { category_id: string }[],
  categories: InventoryCategory[],
): Map<string, number> {
  const parentById = new Map(categories.map((c) => [c.id, c.parent_id ?? null]));
  const counts = new Map<string, number>();
  for (const p of products) {
    counts.set(p.category_id, (counts.get(p.category_id) ?? 0) + 1);
    const parentId = parentById.get(p.category_id);
    if (parentId) {
      counts.set(parentId, (counts.get(parentId) ?? 0) + 1);
    }
  }
  return counts;
}

export async function saveInventoryCategory(
  values: CategoryFormValues,
  editing: InventoryCategory | null,
): Promise<void> {
  const supabase = getSupabase();
  const payload = {
    name: values.name.trim(),
    icon: values.icon?.trim() || "📦",
    sort_order: values.sort_order,
    is_visible: values.is_visible,
    parent_id: values.parent_id || null,
  };

  if (editing) {
    const { error } = await supabase.from("categories").update(payload).eq("id", editing.id);
    if (error) {
      throw new CustomException(error.message, error);
    }
    return;
  }

  const slug = slugFromName(values.name);
  if (!slug) {
    throw new CustomException("Could not create a URL slug from that name.");
  }

  const { error } = await supabase.from("categories").insert({ ...payload, slug });
  if (error) {
    throw new CustomException(error.message, error);
  }
}

export async function deleteInventoryCategory(categoryId: string): Promise<void> {
  const supabase = getSupabase();

  const { count, error: countError } = await supabase
    .from("inventory_products")
    .select("id", { count: "exact", head: true })
    .eq("category_id", categoryId);

  if (countError) {
    throw new CustomException(countError.message, countError);
  }
  if ((count ?? 0) > 0) {
    throw new CustomException(
      "This category still has products. Move or delete those products first.",
    );
  }

  const { count: childCount, error: childError } = await supabase
    .from("categories")
    .select("id", { count: "exact", head: true })
    .eq("parent_id", categoryId);
  if (childError) {
    throw new CustomException(childError.message, childError);
  }
  if ((childCount ?? 0) > 0) {
    throw new CustomException("This category still has subcategories. Delete or move those first.");
  }

  const { error } = await supabase.from("categories").delete().eq("id", categoryId);
  if (error) {
    throw new CustomException(error.message, error);
  }
}
