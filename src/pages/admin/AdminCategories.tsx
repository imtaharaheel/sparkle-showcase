import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { Pencil, Plus, Trash2 } from "lucide-react";
import { getSupabase } from "@/lib/supabase";
import { CustomException, toCustomException } from "@/lib/errors";
import { deleteInventoryCategory, sortCategories } from "@/lib/admin-categories";
import type { InventoryCategory, InventoryProduct } from "@/types/inventory";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  AlertDialog,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { CategoryFormDialog } from "@/components/admin/CategoryFormDialog";
import { toast } from "sonner";

async function fetchCategories(): Promise<InventoryCategory[]> {
  const supabase = getSupabase();
  const { data, error } = await supabase
    .from("categories")
    .select("*")
    .order("sort_order")
    .order("name");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryCategory[];
}

async function fetchProducts(): Promise<InventoryProduct[]> {
  const supabase = getSupabase();
  const { data, error } = await supabase.from("inventory_products").select("id, category_id");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryProduct[];
}

export default function AdminCategories() {
  const queryClient = useQueryClient();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editing, setEditing] = useState<InventoryCategory | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<InventoryCategory | null>(null);

  const { data: categories = [], isLoading } = useQuery({
    queryKey: ["inventory_categories"],
    queryFn: fetchCategories,
  });

  const { data: products = [] } = useQuery({
    queryKey: ["inventory_products"],
    queryFn: fetchProducts,
  });

  const productCountByCategory = useMemo(() => {
    const counts = new Map<string, number>();
    for (const p of products) {
      counts.set(p.category_id, (counts.get(p.category_id) ?? 0) + 1);
    }
    return counts;
  }, [products]);

  const invalidateCategories = () => {
    void queryClient.invalidateQueries({ queryKey: ["inventory_categories"] });
    void queryClient.invalidateQueries({ queryKey: ["catalog_categories"] });
  };

  const deleteMutation = useMutation({
    mutationFn: (category: InventoryCategory) => deleteInventoryCategory(category.id),
    onSuccess: (_data, category) => {
      toast.success(`Deleted ${category.name}`);
      invalidateCategories();
      setDeleteTarget(null);
    },
    onError: (error) => {
      toast.error(toCustomException(error, "Could not delete category").message);
    },
  });

  const openCreate = () => {
    setEditing(null);
    setDialogOpen(true);
  };

  const openEdit = (category: InventoryCategory) => {
    setEditing(category);
    setDialogOpen(true);
  };

  const sortedCategories = sortCategories(categories);
  const visibleCount = sortedCategories.filter((c) => c.is_visible !== false).length;

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold tracking-tight">Categories</h1>
          <p className="text-muted-foreground mt-1 text-sm">
            Choose which categories appear in the shop and admin dropdowns. Only visible categories are shown to buyers.
          </p>
        </div>
        <Button type="button" onClick={openCreate}>
          <Plus className="mr-2 h-4 w-4" />
          Add category
        </Button>
      </div>

      <div className="flex flex-wrap gap-2">
        <Badge variant="outline">{visibleCount} visible in dropdowns</Badge>
        <Badge variant="secondary">{sortedCategories.length} total</Badge>
      </div>

      <div className="rounded-md border">
        {isLoading ? (
          <p className="text-muted-foreground p-6 text-sm">Loading…</p>
        ) : (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Order</TableHead>
                <TableHead>Icon</TableHead>
                <TableHead>Name</TableHead>
                <TableHead>Slug</TableHead>
                <TableHead className="text-right">Products</TableHead>
                <TableHead>Visible</TableHead>
                <TableHead className="w-24" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {sortedCategories.map((category) => (
                <TableRow key={category.id}>
                  <TableCell className="tabular-nums">{category.sort_order ?? 0}</TableCell>
                  <TableCell className="text-lg">{category.icon ?? "📦"}</TableCell>
                  <TableCell className="font-medium">{category.name}</TableCell>
                  <TableCell className="text-muted-foreground text-sm">{category.slug}</TableCell>
                  <TableCell className="text-right tabular-nums">
                    {productCountByCategory.get(category.id) ?? 0}
                  </TableCell>
                  <TableCell>
                    {category.is_visible !== false ? (
                      <Badge>Shown</Badge>
                    ) : (
                      <Badge variant="secondary">Hidden</Badge>
                    )}
                  </TableCell>
                  <TableCell>
                    <div className="flex items-center gap-1">
                      <Button type="button" variant="ghost" size="icon" onClick={() => openEdit(category)}>
                        <Pencil className="h-4 w-4" />
                        <span className="sr-only">Edit {category.name}</span>
                      </Button>
                      <Button
                        type="button"
                        variant="ghost"
                        size="icon"
                        className="text-destructive hover:text-destructive"
                        onClick={() => setDeleteTarget(category)}
                      >
                        <Trash2 className="h-4 w-4" />
                        <span className="sr-only">Delete {category.name}</span>
                      </Button>
                    </div>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        )}
      </div>

      <CategoryFormDialog
        open={dialogOpen}
        onOpenChange={setDialogOpen}
        editing={editing}
        categoryCount={categories.length}
        onSaved={invalidateCategories}
      />

      <AlertDialog open={Boolean(deleteTarget)} onOpenChange={(next) => !next && setDeleteTarget(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Delete {deleteTarget?.name}?</AlertDialogTitle>
            <AlertDialogDescription>
              {deleteTarget && (productCountByCategory.get(deleteTarget.id) ?? 0) > 0
                ? "This category still has products. Move or delete those products before removing the category."
                : "This cannot be undone. The category will be removed from your shop filters."}
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <Button
              type="button"
              variant="destructive"
              disabled={
                deleteMutation.isPending ||
                Boolean(deleteTarget && (productCountByCategory.get(deleteTarget.id) ?? 0) > 0)
              }
              onClick={() => deleteTarget && deleteMutation.mutate(deleteTarget)}
            >
              {deleteMutation.isPending ? "Deleting…" : "Delete"}
            </Button>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
