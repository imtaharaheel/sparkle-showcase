import { useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { Link } from "react-router-dom";
import { getSupabase } from "@/lib/supabase";
import { CustomException } from "@/lib/errors";
import type { InventoryCategory, InventoryProduct } from "@/types/inventory";
import { getStockStatus } from "@/types/inventory";
import { Info } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

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
  const { data, error } = await supabase.from("categories").select("*").order("name");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryCategory[];
}

const RECENT_UPLOADS_LIMIT = 15;

export default function AdminDashboard() {
  const { data: products = [], isLoading, isError, error } = useQuery({
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

  const total = products.length;
  const onlineCount = products.filter((p) => p.is_online !== false).length;
  const offlineCount = total - onlineCount;
  const lowStock = products.filter((p) => p.stock_quantity > 0 && p.stock_quantity < 5);
  const recentUploads = products.slice(0, RECENT_UPLOADS_LIMIT);

  if (isLoading) {
    return <p className="text-muted-foreground text-sm">Loading dashboard…</p>;
  }

  if (isError) {
    return (
      <p className="text-destructive text-sm">
        {error instanceof Error ? error.message : "Failed to load products"}
      </p>
    );
  }

  return (
    <div className="mx-auto flex max-w-5xl flex-col gap-8">
      <div>
        <h1 className="text-2xl font-semibold tracking-tight">Dashboard</h1>
        <p className="text-muted-foreground text-sm">Overview of your inventory.</p>
      </div>

      <Alert>
        <Info className="h-4 w-4" />
        <AlertTitle>Your product list</AlertTitle>
        <AlertDescription className="text-muted-foreground">
          Everything in Admin → Products is stored in your Supabase database. Use the <strong>Online / Offline</strong>{" "}
          switch to control what shoppers see on the public website.
        </AlertDescription>
      </Alert>

      <div className="grid gap-4 sm:grid-cols-3">
        <Card>
          <CardHeader className="pb-2">
            <CardDescription>Total products</CardDescription>
            <CardTitle className="text-3xl tabular-nums">{total}</CardTitle>
          </CardHeader>
          <CardContent>
            <Button variant="outline" size="sm" asChild>
              <Link to="/admin/products">Manage products</Link>
            </Button>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardDescription>Online on website</CardDescription>
            <CardTitle className="text-3xl tabular-nums">{onlineCount}</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground text-sm">Visible to shoppers.</p>
          </CardContent>
        </Card>
        <Card>
          <CardHeader className="pb-2">
            <CardDescription>Offline (hidden)</CardDescription>
            <CardTitle className="text-3xl tabular-nums">{offlineCount}</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground text-sm">In inventory only — not on the store.</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-4 sm:grid-cols-2">
        <Card>
          <CardHeader className="pb-2">
            <CardDescription>Low stock (1–4 units)</CardDescription>
            <CardTitle className="text-3xl tabular-nums">{lowStock.length}</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-muted-foreground text-sm">Items below 5 but not out of stock.</p>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>Recent uploads</CardTitle>
          <CardDescription>Newest products first (same order as the public catalog).</CardDescription>
        </CardHeader>
        <CardContent>
          {recentUploads.length === 0 ? (
            <p className="text-muted-foreground text-sm">No products yet. Add some under Products.</p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Name</TableHead>
                  <TableHead>Category</TableHead>
                  <TableHead>Website</TableHead>
                  <TableHead className="text-right">Added</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {recentUploads.map((p) => (
                  <TableRow key={p.id}>
                    <TableCell className="font-medium">{p.name}</TableCell>
                    <TableCell className="text-muted-foreground">
                      {categoryNameById.get(p.category_id) ?? "—"}
                    </TableCell>
                    <TableCell>
                      <Badge variant={p.is_online !== false ? "default" : "secondary"}>
                        {p.is_online !== false ? "Online" : "Offline"}
                      </Badge>
                    </TableCell>
                    <TableCell className="text-right text-muted-foreground text-sm tabular-nums">
                      {new Date(p.created_at).toLocaleString(undefined, {
                        dateStyle: "medium",
                        timeStyle: "short",
                      })}
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>

      <Card>
        <CardHeader>
          <CardTitle>Low stock items</CardTitle>
          <CardDescription>Products that need restocking soon.</CardDescription>
        </CardHeader>
        <CardContent>
          {lowStock.length === 0 ? (
            <p className="text-muted-foreground text-sm">No low stock items.</p>
          ) : (
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>Name</TableHead>
                  <TableHead className="text-right">Qty</TableHead>
                  <TableHead>Status</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {lowStock.map((p) => (
                  <TableRow key={p.id}>
                    <TableCell className="font-medium">{p.name}</TableCell>
                    <TableCell className="text-right tabular-nums">{p.stock_quantity}</TableCell>
                    <TableCell>
                      <Badge variant="secondary">{getStockStatus(p.stock_quantity)}</Badge>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
