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
import { Form, FormControl, FormDescription, FormField, FormItem, FormLabel, FormMessage } from "@/components/ui/form";
import { Textarea } from "@/components/ui/textarea";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { toast } from "sonner";

const stockPresetSchema = z.enum(["out_of_stock", "low_stock", "in_stock"]);

type StockPreset = z.infer<typeof stockPresetSchema>;

const STOCK_PRESET_LABELS: Record<StockPreset, string> = {
  out_of_stock: "Out of stock",
  low_stock: "Low stock (1–4 units)",
  in_stock: "In stock (5+ units)",
};

function quantityToPreset(q: number): StockPreset {
  if (q <= 0) return "out_of_stock";
  if (q < 5) return "low_stock";
  return "in_stock";
}

function normalizeStockQuantity(preset: StockPreset, qty: number): number {
  if (preset === "out_of_stock") return 0;
  if (preset === "low_stock") {
    if (qty >= 1 && qty <= 4) return qty;
    return 3;
  }
  if (qty >= 5) return qty;
  return 10;
}

const productFormSchema = z
  .object({
    name: z.string().min(1, "Name is required"),
    description: z.string(),
    price: z.coerce.number().min(0, "Price must be 0 or more"),
    stock_preset: stockPresetSchema,
    stock_quantity: z.coerce.number().int().min(0, "Stock must be 0 or more"),
    category_id: z.string().min(1, "Category is required"),
    source_url: z
      .string()
      .refine((s) => s === "" || /^https?:\/\/.+/i.test(s), { message: "Enter a valid URL" }),
    is_online: z.boolean(),
  })
  .superRefine((data, ctx) => {
    if (data.stock_preset === "out_of_stock" && data.stock_quantity !== 0) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "Set quantity to 0 for out of stock",
        path: ["stock_quantity"],
      });
    }
    if (data.stock_preset === "low_stock" && (data.stock_quantity < 1 || data.stock_quantity > 4)) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "Low stock must be between 1 and 4",
        path: ["stock_quantity"],
      });
    }
    if (data.stock_preset === "in_stock" && data.stock_quantity < 5) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "In stock must be at least 5",
        path: ["stock_quantity"],
      });
    }
  });

type ProductFormValues = z.infer<typeof productFormSchema>;

type SortKey = "newest" | "name" | "price_asc" | "price_desc" | "stock_asc" | "stock_desc";
type VisibilityFilter = "all" | "online" | "offline";

async function fetchProducts(): Promise<InventoryProduct[]> {
  const supabase = getSupabase();
  const { data, error } = await supabase
    .from("inventory_products")
    .select("*")
    .order("created_at", { ascending: false })
    .order("id", { ascending: false });
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryProduct[];
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

function sortCategories(list: InventoryCategory[]): InventoryCategory[] {
  return [...list].sort(
    (a, b) => (a.sort_order ?? 0) - (b.sort_order ?? 0) || a.name.localeCompare(b.name),
  );
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
  const [visibilityFilter, setVisibilityFilter] = useState<VisibilityFilter>("all");
  const [sortKey, setSortKey] = useState<SortKey>("newest");
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

  const visibleCategories = useMemo(
    () => sortCategories(categories.filter((c) => c.is_visible !== false)),
    [categories],
  );

  const productCountByCategory = useMemo(() => {
    const counts = new Map<string, number>();
    for (const p of products) {
      counts.set(p.category_id, (counts.get(p.category_id) ?? 0) + 1);
    }
    return counts;
  }, [products]);

  const totalProductCount = products.length;

  const filteredSorted = useMemo(() => {
    let list = [...products];
    const q = search.trim().toLowerCase();
    if (q) {
      list = list.filter((p) => p.name.toLowerCase().includes(q));
    }
    if (categoryFilter !== "all") {
      list = list.filter((p) => p.category_id === categoryFilter);
    }
    if (visibilityFilter === "online") {
      list = list.filter((p) => p.is_online !== false);
    } else if (visibilityFilter === "offline") {
      list = list.filter((p) => p.is_online === false);
    }
    switch (sortKey) {
      case "newest":
        list.sort((a, b) => {
          const t = new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
          return t !== 0 ? t : b.id.localeCompare(a.id);
        });
        break;
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
  }, [products, search, categoryFilter, visibilityFilter, sortKey]);

  const form = useForm<ProductFormValues>({
    resolver: zodResolver(productFormSchema),
    defaultValues: {
      name: "",
      description: "",
      price: 0,
      stock_preset: "in_stock",
      stock_quantity: 10,
      category_id: "",
      source_url: "",
      is_online: true,
    },
  });

  const stockPreset = form.watch("stock_preset");

  const openCreate = () => {
    setEditing(null);
    setImageFile(null);
    form.reset({
      name: "",
      description: "",
      price: 0,
      stock_preset: "in_stock",
      stock_quantity: 10,
      category_id: visibleCategories[0]?.id ?? categories[0]?.id ?? "",
      source_url: "",
      is_online: true,
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
      stock_preset: quantityToPreset(p.stock_quantity),
      stock_quantity: p.stock_quantity,
      category_id: p.category_id,
      source_url: p.source_url ?? "",
      is_online: p.is_online !== false,
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
      const stock_quantity = normalizeStockQuantity(values.stock_preset, values.stock_quantity);
      const supabase = getSupabase();
      let image_path = editing?.image_path ?? null;
      if (imageFile && editing?.image_path && !/^https?:\/\//i.test(editing.image_path)) {
        const { error: removeError } = await supabase.storage.from("product-images").remove([editing.image_path]);
        if (removeError) {
          throw new CustomException(removeError.message, removeError);
        }
      }
      if (imageFile) {
        image_path = await uploadImage(imageFile);
      }
      const source_url = values.source_url?.trim() || null;
      if (editing) {
        const { error } = await supabase
          .from("inventory_products")
          .update({
            name: values.name,
            description: values.description,
            price: values.price,
            stock_quantity,
            category_id: values.category_id,
            source_url,
            is_online: values.is_online,
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
          stock_quantity,
          category_id: values.category_id,
          image_path,
          source_url,
          is_online: values.is_online,
        });
        if (error) {
          throw new CustomException(error.message, error);
        }
      }
    },
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: ["inventory_products"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_products"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_featured"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_product"] });
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

  const visibilityMutation = useMutation({
    mutationFn: async ({ id, is_online }: { id: string; is_online: boolean }) => {
      const supabase = getSupabase();
      const { error } = await supabase.from("inventory_products").update({ is_online }).eq("id", id);
      if (error) {
        throw new CustomException(error.message, error);
      }
    },
    onSuccess: (_data, { is_online }) => {
      void queryClient.invalidateQueries({ queryKey: ["inventory_products"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_products"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_featured"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_product"] });
      toast.success(is_online ? "Product is now online on the website" : "Product is now hidden from the website");
    },
    onError: (e) => {
      const ex = toCustomException(e, "Could not update visibility");
      toast.error(ex.message);
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (p: InventoryProduct) => {
      const supabase = getSupabase();
      if (p.image_path && !/^https?:\/\//i.test(p.image_path)) {
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
      void queryClient.invalidateQueries({ queryKey: ["catalog_products"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_featured"] });
      void queryClient.invalidateQueries({ queryKey: ["catalog_product"] });
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
          <p className="text-muted-foreground text-sm">
            {isLoading
              ? "Loading inventory…"
              : `${totalProductCount} product${totalProductCount === 1 ? "" : "s"} uploaded`}
          </p>
        </div>
        <Button type="button" onClick={openCreate} disabled={visibleCategories.length === 0}>
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
          <Label className="text-xs">Visibility</Label>
          <Select value={visibilityFilter} onValueChange={(v) => setVisibilityFilter(v as VisibilityFilter)}>
            <SelectTrigger>
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All products</SelectItem>
              <SelectItem value="online">Online only</SelectItem>
              <SelectItem value="offline">Offline only</SelectItem>
            </SelectContent>
          </Select>
        </div>
        <div className="flex flex-col gap-1.5 sm:w-48">
          <Label className="text-xs">Category</Label>
          <Select value={categoryFilter} onValueChange={setCategoryFilter}>
            <SelectTrigger>
              <SelectValue placeholder="Category" />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">All categories ({totalProductCount})</SelectItem>
              {visibleCategories.map((c) => (
                <SelectItem key={c.id} value={c.id}>
                  {c.name} ({productCountByCategory.get(c.id) ?? 0})
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
              <SelectItem value="newest">Newest first</SelectItem>
              <SelectItem value="name">Name (A–Z)</SelectItem>
              <SelectItem value="price_asc">Price (low → high)</SelectItem>
              <SelectItem value="price_desc">Price (high → low)</SelectItem>
              <SelectItem value="stock_asc">Stock (low → high)</SelectItem>
              <SelectItem value="stock_desc">Stock (high → low)</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>

      {visibleCategories.length === 0 ? (
        <p className="text-muted-foreground text-sm">No visible categories. Add or show categories under Admin → Categories.</p>
      ) : (
        <div className="rounded-lg border bg-muted/30 p-4">
          <div className="mb-3 flex flex-wrap items-center justify-between gap-2">
            <p className="text-sm font-medium">Products by category</p>
            <Badge variant="outline" className="tabular-nums">
              {totalProductCount} total
            </Badge>
          </div>
          <div className="flex flex-wrap gap-2">
            {visibleCategories.map((c) => {
              const count = productCountByCategory.get(c.id) ?? 0;
              const active = categoryFilter === c.id;
              return (
                <button
                  key={c.id}
                  type="button"
                  onClick={() => setCategoryFilter(active ? "all" : c.id)}
                  className="focus-visible:ring-ring rounded-md focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2"
                >
                  <Badge variant={active ? "default" : "secondary"} className="tabular-nums">
                    {c.name}: {count}
                  </Badge>
                </button>
              );
            })}
          </div>
        </div>
      )}

      <div className="rounded-md border">
        {!isLoading && (
          <p className="text-muted-foreground border-b px-4 py-2 text-sm">
            Showing {filteredSorted.length} of {totalProductCount} product
            {totalProductCount === 1 ? "" : "s"}
            {categoryFilter !== "all" && categoryNameById.get(categoryFilter)
              ? ` in ${categoryNameById.get(categoryFilter)}`
              : ""}
          </p>
        )}
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
                <TableHead>Stock status</TableHead>
                <TableHead>Website</TableHead>
                <TableHead className="w-28 text-right">Actions</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {filteredSorted.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={8} className="text-muted-foreground h-24 text-center">
                    No products match your filters.
                  </TableCell>
                </TableRow>
              ) : (
                filteredSorted.map((p) => {
                  const imgUrl = getPublicImageUrl(p.image_path);
                  const online = p.is_online !== false;
                  return (
                    <TableRow key={p.id} className={!online ? "opacity-70" : undefined}>
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
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <Switch
                            checked={online}
                            disabled={visibilityMutation.isPending}
                            onCheckedChange={(checked) =>
                              visibilityMutation.mutate({ id: p.id, is_online: checked })
                            }
                            aria-label={online ? "Set product offline" : "Set product online"}
                          />
                          <Badge variant={online ? "default" : "secondary"}>
                            {online ? "Online" : "Offline"}
                          </Badge>
                        </div>
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
                name="stock_preset"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Stock availability</FormLabel>
                    <Select
                      onValueChange={(v) => {
                        const preset = v as StockPreset;
                        field.onChange(preset);
                        if (preset === "out_of_stock") {
                          form.setValue("stock_quantity", 0);
                        } else if (preset === "low_stock") {
                          const q = form.getValues("stock_quantity");
                          form.setValue("stock_quantity", q >= 1 && q <= 4 ? q : 3);
                        } else {
                          const q = form.getValues("stock_quantity");
                          form.setValue("stock_quantity", q >= 5 ? q : 10);
                        }
                      }}
                      value={field.value}
                    >
                      <FormControl>
                        <SelectTrigger>
                          <SelectValue placeholder="Select stock status" />
                        </SelectTrigger>
                      </FormControl>
                      <SelectContent>
                        {(Object.keys(STOCK_PRESET_LABELS) as StockPreset[]).map((key) => (
                          <SelectItem key={key} value={key}>
                            {STOCK_PRESET_LABELS[key]}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="stock_quantity"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Exact units in stock</FormLabel>
                    <FormControl>
                      <Input
                        type="number"
                        min={0}
                        step={1}
                        disabled={stockPreset === "out_of_stock"}
                        {...field}
                      />
                    </FormControl>
                    <p className="text-muted-foreground text-xs">
                      {stockPreset === "out_of_stock" && "Shown as out of stock on the store."}
                      {stockPreset === "low_stock" && "Use 1–4 to match the low-stock badge on the store."}
                      {stockPreset === "in_stock" && "Use 5 or more for the normal in-stock badge."}
                    </p>
                    <FormMessage />
                  </FormItem>
                )}
              />
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
                        {visibleCategories.map((c) => (
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
              <FormField
                control={form.control}
                name="is_online"
                render={({ field }) => (
                  <FormItem className="flex flex-row items-center justify-between rounded-lg border p-4">
                    <div className="space-y-0.5">
                      <FormLabel>Show on website</FormLabel>
                      <FormDescription>
                        Turn off to hide this product from shoppers. It stays in your inventory.
                      </FormDescription>
                    </div>
                    <FormControl>
                      <Switch checked={field.value} onCheckedChange={field.onChange} />
                    </FormControl>
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="source_url"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Reference link (optional)</FormLabel>
                    <FormControl>
                      <Input {...field} type="url" placeholder="https://…" />
                    </FormControl>
                    <p className="text-muted-foreground text-xs">
                      Shown on the product page as an external link. Used for imported catalog items.
                    </p>
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
