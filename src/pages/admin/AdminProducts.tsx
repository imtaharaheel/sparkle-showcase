import { useMemo, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { Pencil, Plus, Search, Trash2 } from "lucide-react";
import { getSupabase } from "@/lib/supabase";
import { CustomException, toCustomException } from "@/lib/errors";
import type { InventoryCategory, InventoryProduct } from "@/types/inventory";
import { getPublicImageUrl, getStockStatus } from "@/types/inventory";
import { useAdminAuth } from "@/contexts/AdminAuthContext";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
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
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { toast } from "sonner";

const productFormSchema = z.object({
  name: z.string().min(1, "Name is required"),
  description: z.string(),
  price: z.coerce.number().min(0, "Price must be 0 or more"),
  stock_quantity: z.coerce.number().int().min(0, "Stock must be 0 or more"),
  category_id: z.string().min(1, "Category is required"),
});

type ProductFormValues = z.infer<typeof productFormSchema>;

type SortKey = "name" | "price_asc" | "price_desc" | "stock_asc" | "stock_desc";

async function fetchProducts(): Promise<InventoryProduct[]> {
  const supabase = getSupabase();
  const { data, error } = await supabase.from("inventory_products").select("*");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryProduct[];
}

async function fetchCategories(): Promise<InventoryCategory[]> {
  const supabase = getSupabase();
  const { data, error } = await supabase.from("categories").select("*").order("name");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryCategory[];
}

function sanitizeFileName(name: string): string {
  return name.replace(/[^\w.-]+/g, "_");
}

function stockBadgeVariant(q: number): "default" | "secondary" | "destructive" {
  if (q === 0) return "destructive";
  if (q < 5) return "secondary";
  return "default";
}

export default function AdminProducts() {
  const queryClient = useQueryClient();
  const { user } = useAdminAuth();
  const [search, setSearch] = useState("");
  const [categoryFilter, setCategoryFilter] = useState<string>("all");
  const [sortKey, setSortKey] = useState<SortKey>("name");
  const [dialogOpen, setDialogOpen] = useState(false);
  const [editing, setEditing] = useState<InventoryProduct | null>(null);
  const [imageFile, setImageFile] = useState<File | null>(null);
  const [deleteTarget, setDeleteTarget] = useState<InventoryProduct | null>(null);

  const { data: products = [], isLoading } = useQuery({
    queryKey: ["inventory_products"],
    queryFn: fetchProducts,
  });

  const { data: categories = [] } = useQuery({
    queryKey: ["inventory_categories"],
    queryFn: fetchCategories,
  });

  const categoryNameById = useMemo(() => {
    const m = new Map<string, string>();
    for (const c of categories) {
      m.set(c.id, c.name);
    }
    return m;
  }, [categories]);

  const filteredSorted = useMemo(() => {
    let list = [...products];
    const q = search.trim().toLowerCase();
    if (q) {
      list = list.filter((p) => p.name.toLowerCase().includes(q));
    }
    if (categoryFilter !== "all") {
      list = list.filter((p) => p.category_id === categoryFilter);
    }
    switch (sortKey) {
      case "price_asc":
        list.sort((a, b) => Number(a.price) - Number(b.price));
        break;
      case "price_desc":
        list.sort((a, b) => Number(b.price) - Number(a.price));
        break;
      case "stock_asc":
        list.sort((a, b) => a.stock_quantity - b.stock_quantity);
        break;
      case "stock_desc":
        list.sort((a, b) => b.stock_quantity - a.stock_quantity);
        break;
      default:
        list.sort((a, b) => a.name.localeCompare(b.name));
    }
    return list;
  }, [products, search, categoryFilter, sortKey]);

  const form = useForm<ProductFormValues>({
    resolver: zodResolver(productFormSchema),
    defaultValues: {
      name: "",
      description: "",
      price: 0,
      stock_quantity: 0,
      category_id: "",
    },
  });

  const openCreate = () => {
    setEditing(null);
    setImageFile(null);
    form.reset({
      name: "",
      description: "",
      price: 0,
      stock_quantity: 0,
      category_id: categories[0]?.id ?? "",
    });
    setDialogOpen(true);
  };

  const openEdit = (p: InventoryProduct) => {
    setEditing(p);
    setImageFile(null);
    form.reset({
      name: p.name,
      description: p.description,
      price: Number(p.price),
      stock_quantity: p.stock_quantity,
      category_id: p.category_id,
    });
    setDialogOpen(true);
  };

  const uploadImage = async (file: File): Promise<string> => {
    if (!user) {
      throw new CustomException("You must be signed in to upload images.");
    }
    const supabase = getSupabase();
    const path = `${user.id}/${crypto.randomUUID()}-${sanitizeFileName(file.name)}`;
    const { error } = await supabase.storage.from("product-images").upload(path, file, {
      cacheControl: "3600",
      upsert: false,
    });
    if (error) {
      throw new CustomException(error.message, error);
    }
    return path;
  };

  const saveMutation = useMutation({
    mutationFn: async (values: ProductFormValues) => {
      const supabase = getSupabase();
      let image_path = editing?.image_path ?? null;
      if (imageFile && editing?.image_path) {
        const { error: removeError } = await supabase.storage.from("product-images").remove([editing.image_path]);
        if (removeError) {
          throw new CustomException(removeError.message, removeError);
        }
      }
      if (imageFile) {
        image_path = await uploadImage(imageFile);
      }
      if (editing) {
        const { error } = await supabase
          .from("inventory_products")
          .update({
            name: values.name,
            description: values.description,
            price: values.price,
            stock_quantity: values.stock_quantity,
            category_id: values.category_id,
            ...(imageFile ? { image_path } : {}),
          })
          .eq("id", editing.id);
        if (error) {
          throw new CustomException(error.message, error);
        }
      } else {
        if (!imageFile) {
          throw new CustomException("Please choose an image for new products.");
        }
        const { error } = await supabase.from("inventory_products").insert({
          name: values.name,
          description: values.description,
          price: values.price,
          stock_quantity: values.stock_quantity,
          category_id: values.category_id,
          image_path,
        });
        if (error) {
          throw new CustomException(error.message, error);
        }
      }
    },
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ["inventory_products"] });
      toast.success(editing ? "Product updated" : "Product created");
      setDialogOpen(false);
      setEditing(null);
      setImageFile(null);
    },
    onError: (e) => {
      const ex = toCustomException(e, "Save failed");
      toast.error(ex.message);
      if (!(e instanceof CustomException)) {
        console.error(e);
      }
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (p: InventoryProduct) => {
      const supabase = getSupabase();
      if (p.image_path) {
        const { error: storageError } = await supabase.storage.from("product-images").remove([p.image_path]);
        if (storageError) {
          throw new CustomException(storageError.message, storageError);
        }
      }
      const { error } = await supabase.from("inventory_products").delete().eq("id", p.id);
      if (error) {
        throw new CustomException(error.message, error);
      }
    },
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ["inventory_products"] });
      toast.success("Product deleted");
      setDeleteTarget(null);
    },
    onError: (e) => {
      const ex = toCustomException(e, "Delete failed");
      toast.error(ex.message);
      if (!(e instanceof CustomException)) {
        console.error(e);
      }
    },
  });

  const onSubmit = (values: ProductFormValues) => {
    saveMutation.mutate(values);
  };

  return (
    <div className="mx-auto flex max-w-6xl flex-col gap-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="text-2xl font-semibold tracking-tight">Products</h1>
          <p className="text-muted-foreground text-sm">Add, edit, and remove inventory items.</p>
        </div>
        <Button type="button" onClick={openCreate} disabled={categories.length === 0}>
          <Plus className="mr-2 size-4" />
          Add product
        </Button>
      </div>

      <div className="flex flex-col gap-3 sm:flex-row sm:flex-wrap sm:items-end">
        <div className="relative max-w-sm flex-1">
          <Search className="text-muted-foreground absolute left-2.5 top-2.5 size-4" />
          <Input
            placeholder="Search by name…"
            className="pl-9"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            aria-label="Search products"
          />
        </div>
        <div className="flex flex-col gap-1.5 sm:w-48">
          <Label className="text-xs">Category</Label>
          <Select value={categoryFilter} onValueChange={setCategoryFilter}>
            <SelectTrigger>
              <SelectValue placeholder="Category" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All categories</SelectItem>
              {categories.map((c) => (
                <SelectItem key={c.id} value={c.id}>
                  {c.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
        <div className="flex flex-col gap-1.5 sm:w-56">
          <Label className="text-xs">Sort by</Label>
          <Select value={sortKey} onValueChange={(v) => setSortKey(v as SortKey)}>
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="name">Name (A–Z)</SelectItem>
              <SelectItem value="price_asc">Price (low → high)</SelectItem>
              <SelectItem value="price_desc">Price (high → low)</SelectItem>
              <SelectItem value="stock_asc">Stock (low → high)</SelectItem>
              <SelectItem value="stock_desc">Stock (high → low)</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {categories.length === 0 ? (
        <p className="text-muted-foreground text-sm">No categories found. Apply database migrations.</p>
      ) : null}

      <div className="rounded-md border">
        {isLoading ? (
          <p className="text-muted-foreground p-6 text-sm">Loading…</p>
        ) : (
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead className="w-16">Image</TableHead>
                <TableHead>Name</TableHead>
                <TableHead>Category</TableHead>
                <TableHead className="text-right">Price</TableHead>
                <TableHead className="text-right">Stock</TableHead>
                <TableHead>Status</TableHead>
                <TableHead className="w-28 text-right">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {filteredSorted.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={7} className="text-muted-foreground h-24 text-center">
                    No products match your filters.
                  </TableCell>
                </TableRow>
              ) : (
                filteredSorted.map((p) => {
                  const imgUrl = getPublicImageUrl(p.image_path);
                  return (
                    <TableRow key={p.id}>
                      <TableCell>
                        <div className="bg-muted flex size-12 items-center justify-center overflow-hidden rounded-md border">
                          {imgUrl ? (
                            <img src={imgUrl} alt="" className="size-full object-cover" />
                          ) : (
                            <span className="text-muted-foreground text-xs">—</span>
                          )}
                        </div>
                      </TableCell>
                      <TableCell className="font-medium">{p.name}</TableCell>
                      <TableCell className="text-muted-foreground text-sm">
                        {categoryNameById.get(p.category_id) ?? "—"}
                      </TableCell>
                      <TableCell className="text-right tabular-nums">
                        {Number(p.price).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
                      </TableCell>
                      <TableCell className="text-right tabular-nums">{p.stock_quantity}</TableCell>
                      <TableCell>
                        <Badge variant={stockBadgeVariant(p.stock_quantity)}>{getStockStatus(p.stock_quantity)}</Badge>
                      </TableCell>
                      <TableCell className="text-right">
                        <Button type="button" variant="ghost" size="icon" onClick={() => openEdit(p)} aria-label="Edit">
                          <Pencil className="size-4" />
                        </Button>
                        <Button
                          type="button"
                          variant="ghost"
                          size="icon"
                          onClick={() => setDeleteTarget(p)}
                          aria-label="Delete"
                        >
                          <Trash2 className="size-4" />
                        </Button>
                      </TableCell>
                    </TableRow>
                  );
                })
              )}
            </TableBody>
          </Table>
        )}
      </div>

      <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
        <DialogContent className="max-h-[90vh] overflow-y-auto sm:max-w-lg">
          <DialogHeader>
            <DialogTitle>{editing ? "Edit product" : "Add product"}</DialogTitle>
            <DialogDescription>
              {editing ? "Update details and optionally replace the image." : "All fields except optional overrides are required."}
            </DialogDescription>
          </DialogHeader>
          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4">
              <FormField
                control={form.control}
                name="name"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Name</FormLabel>
                    <FormControl>
                      <Input {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="description"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Description</FormLabel>
                    <FormControl>
                      <Textarea rows={3} {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <div className="grid grid-cols-2 gap-4">
                <FormField
                  control={form.control}
                  name="price"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Price</FormLabel>
                      <FormControl>
                        <Input type="number" step="0.01" min={0} {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="stock_quantity"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Stock quantity</FormLabel>
                      <FormControl>
                        <Input type="number" min={0} step={1} {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
              </div>
              <FormField
                control={form.control}
                name="category_id"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Category</FormLabel>
                    <Select onValueChange={field.onChange} value={field.value}>
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select category" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {categories.map((c) => (
                          <SelectItem key={c.id} value={c.id}>
                            {c.name}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <div className="space-y-2">
                <Label htmlFor="product-image">Image {editing ? "(optional)" : ""}</Label>
                <Input
                  id="product-image"
                  type="file"
                  accept="image/*"
                  onChange={(e) => setImageFile(e.target.files?.[0] ?? null)}
                />
                {editing?.image_path && !imageFile ? (
                  <p className="text-muted-foreground text-xs">Current image kept unless you choose a new file.</p>
                ) : null}
              </div>
              <DialogFooter>
                <Button type="button" variant="outline" onClick={() => setDialogOpen(false)}>
                  Cancel
                </Button>
                <Button type="submit" disabled={saveMutation.isPending}>
                  {saveMutation.isPending ? "Saving…" : "Save"}
                </Button>
              </DialogFooter>
            </form>
          </Form>
        </DialogContent>
      </Dialog>

      <AlertDialog open={!!deleteTarget} onOpenChange={(open) => !open && setDeleteTarget(null)}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Delete product?</AlertDialogTitle>
            <AlertDialogDescription>
              This removes “{deleteTarget?.name}” and its image from storage. This cannot be undone.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel</AlertDialogCancel>
            <Button
              type="button"
              variant="destructive"
              disabled={deleteMutation.isPending}
              onClick={() => {
                if (deleteTarget) {
                  deleteMutation.mutate(deleteTarget);
                }
              }}
            >
              {deleteMutation.isPending ? "Deleting…" : "Delete"}
            </Button>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </div>
  );
}
