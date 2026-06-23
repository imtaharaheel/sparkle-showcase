import { z } from "zod";
import { getSupabase } from "@/lib/supabase";
import { CustomException } from "@/lib/errors";
import type { InventoryCategory } from "@/types/inventory";

export const categoryFormSchema = z.object({
  name: z.string().trim().min(1, "Name is required").max(80),
  icon: z.string().trim().max(8, "Use a short emoji").optional(),
  sort_order: z.coerce.number().int().min(0).max(999),
  is_visible: z.boolean(),
});

export type CategoryFormValues = z.infer<typeof categoryFormSchema>;

export function slugFromName(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

export function sortCategories(list: InventoryCategory[]): InventoryCategory[] {
  return [...list].sort(
    (a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0) || a.name.localeCompare(b.name),
  );
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

  const { error } = await supabase.from("categories").delete().eq("id", categoryId);
  if (error) {
    throw new CustomException(error.message, error);
  }
}
