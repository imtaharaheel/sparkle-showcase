import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Pencil, Plus } from "lucide-react";
import { getSupabase } from "@/lib/supabase";
import { CustomException, toCustomException } from "@/lib/errors";
import type { InventoryCategory, InventoryProduct } from "@/types/inventory";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Switch } from "@/components/ui/switch";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { toast } from "sonner";

const categoryFormSchema = z.object({
  name: z.string().trim().min(1, "Name is required").max(80),
  icon: z.string().trim().max(8, "Use a short emoji").optional(),
  sort_order: z.coerce.number().int().min(0).max(999),
  is_visible: z.boolean(),
});

type CategoryFormValues = z.infer<typeof categoryFormSchema>;

function slugFromName(name: string): string {
  return name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function sortCategories(list: InventoryCategory[]): InventoryCategory[] {
  return [...list].sort(
    (a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0) || a.name.localeCompare(b.name),
  );
}

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

  const form = useForm<CategoryFormValues>({
    resolver: zodResolver(categoryFormSchema),
    defaultValues: {
      name: "",
      icon: "📦",
      sort_order: 0,
      is_visible: true,
    },
  });

  const openCreate = () => {
    setEditing(null);
    form.reset({
      name: "",
      icon: "📦",
      sort_order: (categories.length + 1) * 10,
      is_visible: true,
    });
    setDialogOpen(true);
  };

  const openEdit = (category: InventoryCategory) => {
    setEditing(category);
    form.reset({
      name: category.name,
      icon: category.icon ?? "📦",
      sort_order: category.sort_order ?? 0,
      is_visible: category.is_visible !== false,
    });
    setDialogOpen(true);
  };

  const saveMutation = useMutation({
    mutationFn: async (values: CategoryFormValues) => {
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

      const { error } = await supabase.from("categories").insert({
        ...payload,
        slug,
      });
      if (error) {
        throw new CustomException(error.message, error);
      }
    },
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ["inventory_categories"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_categories"] });
      toast.success(editing ? "Category updated" : "Category added");
      setDialogOpen(false);
    },
    onError: (error) => {
      const ex = toCustomException(error, "Could not save category");
      toast.error(ex.message);
    },
  });

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
                <TableHead className="w-20" />
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
                    <Button type="button" variant="ghost" size="icon" onClick={() => openEdit(category)}>
                      <Pencil className="h-4 w-4" />
                      <span className="sr-only">Edit {category.name}</span>
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        )}
      </div>

      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>{editing ? "Edit category" : "Add category"}</DialogTitle>
            <DialogDescription>
              Visible categories show in the shop filters and when you add products. Lower order numbers appear first.
            </DialogDescription>
          </DialogHeader>

          <Form {...form}>
            <form
              className="space-y-4"
              onSubmit={form.handleSubmit((values) => saveMutation.mutate(values))}
            >
              <FormField
                control={form.control}
                name="name"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Name</FormLabel>
                    <FormControl>
                      <Input placeholder="e.g. Apple Products" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="icon"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Icon (emoji)</FormLabel>
                    <FormControl>
                      <Input placeholder="🍎" className="max-w-[120px]" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="sort_order"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Sort order</FormLabel>
                    <FormControl>
                      <Input type="number" min={0} className="max-w-[120px]" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <FormField
                control={form.control}
                name="is_visible"
                render={({ field }) => (
                  <FormItem className="flex items-center justify-between rounded-lg border p-4">
                    <div>
                      <FormLabel>Show in dropdowns</FormLabel>
                      <p className="text-muted-foreground text-sm">
                        Turn off to hide from the shop and product filters.
                      </p>
                    </div>
                    <FormControl>
                      <Switch checked={field.value} onCheckedChange={field.onChange} />
                    </FormControl>
                  </FormItem>
                )}
              />

              <DialogFooter>
                <Button type="button" variant="outline" onClick={() => setDialogOpen(false)}>
                  Cancel
                </Button>
                <Button type="submit" disabled={saveMutation.isPending}>
                  {saveMutation.isPending ? "Saving…" : editing ? "Save changes" : "Add category"}
                </Button>
              </DialogFooter>
            </form>
          </Form>
        </DialogContent>
      </Dialog>
    </div>
  );
}
