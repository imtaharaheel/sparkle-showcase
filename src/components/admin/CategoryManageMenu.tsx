import { useState } from "react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Check, ChevronsUpDown, Pencil, Plus, Trash2 } from "lucide-react";
import { deleteInventoryCategory, sortCategories } from "@/lib/admin-categories";
import { toCustomException } from "@/lib/errors";
import type { InventoryCategory } from "@/types/inventory";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Label } from "@/components/ui/label";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
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
import { cn } from "@/lib/utils";
import { toast } from "sonner";

interface CategoryManageMenuProps {
  value: string;
  onValueChange: (value: string) => void;
  categories: InventoryCategory[];
  productCountByCategory: Map<string, number>;
  totalProductCount: number;
  className?: string;
}

export function CategoryManageMenu({
  value,
  onValueChange,
  categories,
  productCountByCategory,
  totalProductCount,
  className,
}: CategoryManageMenuProps) {
  const queryClient = useQueryClient();
  const [open, setOpen] = useState(false);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editing, setEditing] = useState<InventoryCategory | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<InventoryCategory | null>(null);

  const sorted = sortCategories(categories);
  const selectedLabel =
    value === "all"
      ? `All categories (${totalProductCount})`
      : (() => {
          const cat = categories.find((c) => c.id === value);
          if (!cat) return "Category";
          return `${cat.icon ? `${cat.icon} ` : ""}${cat.name} (${productCountByCategory.get(cat.id) ?? 0})`;
        })();

  const invalidateCategories = () => {
    void queryClient.invalidateQueries({ queryKey: ["inventory_categories"] });
    void queryClient.invalidateQueries({ queryKey: ["catalog_categories"] });
  };

  const deleteMutation = useMutation({
    mutationFn: (category: InventoryCategory) => deleteInventoryCategory(category.id),
    onSuccess: (_data, category) => {
      toast.success(`Deleted ${category.name}`);
      if (value === category.id) {
        onValueChange("all");
      }
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

  const openEdit = (category: InventoryCategory, event: React.MouseEvent) => {
    event.preventDefault();
    event.stopPropagation();
    setEditing(category);
    setDialogOpen(true);
  };

  const openDelete = (category: InventoryCategory, event: React.MouseEvent) => {
    event.preventDefault();
    event.stopPropagation();
    setDeleteTarget(category);
  };

  return (
    <>
      <div className={cn("flex flex-col gap-1.5", className)}>
        <Label className="text-xs">Category</Label>
        <Popover open={open} onOpenChange={setOpen}>
          <PopoverTrigger asChild>
            <Button
              type="button"
              variant="outline"
              role="combobox"
              aria-expanded={open}
              className="w-full justify-between font-normal sm:w-56"
            >
              <span className="truncate">{selectedLabel}</span>
              <ChevronsUpDown className="ml-2 size-4 shrink-0 opacity-50" />
            </Button>
          </PopoverTrigger>
          <PopoverContent className="w-[var(--radix-popover-trigger-width)] p-0" align="start">
            <div className="max-h-72 overflow-y-auto p-1">
              <button
                type="button"
                className={cn(
                  "hover:bg-accent flex w-full items-center gap-2 rounded-sm px-2 py-2 text-left text-sm",
                  value === "all" && "bg-accent",
                )}
                onClick={() => {
                  onValueChange("all");
                  setOpen(false);
                }}
              >
                {value === "all" ? <Check className="size-4 shrink-0" /> : <span className="size-4 shrink-0" />}
                <span>All categories ({totalProductCount})</span>
              </button>

              {sorted.map((category) => {
                const count = productCountByCategory.get(category.id) ?? 0;
                const isSelected = value === category.id;
                return (
                  <div
                    key={category.id}
                    className={cn(
                      "hover:bg-accent group flex items-center gap-1 rounded-sm pr-1",
                      isSelected && "bg-accent",
                    )}
                  >
                    <button
                      type="button"
                      className="flex min-w-0 flex-1 items-center gap-2 px-2 py-2 text-left text-sm"
                      onClick={() => {
                        onValueChange(category.id);
                        setOpen(false);
                      }}
                    >
                      {isSelected ? <Check className="size-4 shrink-0" /> : <span className="size-4 shrink-0" />}
                      <span className="truncate">
                        {category.icon ? `${category.icon} ` : ""}
                        {category.name} ({count})
                      </span>
                      {category.is_visible === false ? (
                        <Badge variant="secondary" className="ml-1 shrink-0 text-[10px]">
                          hidden
                        </Badge>
                      ) : null}
                    </button>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="size-8 shrink-0 opacity-70 group-hover:opacity-100"
                      onClick={(e) => openEdit(category, e)}
                      aria-label={`Edit ${category.name}`}
                    >
                      <Pencil className="size-3.5" />
                    </Button>
                    <Button
                      type="button"
                      variant="ghost"
                      size="icon"
                      className="text-destructive hover:text-destructive size-8 shrink-0 opacity-70 group-hover:opacity-100"
                      onClick={(e) => openDelete(category, e)}
                      aria-label={`Delete ${category.name}`}
                    >
                      <Trash2 className="size-3.5" />
                    </Button>
                  </div>
                );
              })}
            </div>

            <div className="border-t p-2">
              <Button type="button" variant="secondary" className="w-full justify-start gap-2" onClick={openCreate}>
                <Plus className="size-4" />
                Add category
              </Button>
            </div>
          </PopoverContent>
        </Popover>
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
    </>
  );
}
