import { useQuery } from "@tanstack/react-query";
import { Link } from "react-router-dom";
import { getSupabase } from "@/lib/supabase";
import { CustomException } from "@/lib/errors";
import type { InventoryProduct } from "@/types/inventory";
import { getStockStatus } from "@/types/inventory";
import { Info } from "lucide-react";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

async function fetchProducts(): Promise<InventoryProduct[]> {
  const supabase = getSupabase();
  const { data, error } = await supabase.from("inventory_products").select("*").order("name");
  if (error) {
    throw new CustomException(error.message, error);
  }
  return (data ?? []) as InventoryProduct[];
}

export default function AdminDashboard() {
  const { data: products = [], isLoading, isError, error } = useQuery({
    queryKey: ["inventory_products"],
    queryFn: fetchProducts,
  });

  const total = products.length;
  const lowStock = products.filter((p) => p.stock_quantity > 0 && p.stock_quantity < 5);

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
          Everything in Admin → Products is stored in your Supabase database. The public catalog reads from the same
          place, so what you add or edit here is what shoppers see (after the page refreshes).
        </AlertDescription>
      </Alert>

      <div className="grid gap-4 sm:grid-cols-2">
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
