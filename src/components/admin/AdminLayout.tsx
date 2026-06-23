import { Outlet, useMatch, useNavigate } from "react-router-dom";
import { LayoutGrid, Package, LogOut, Tags } from "lucide-react";
import { NavLink } from "@/components/NavLink";
import { useAdminAuth } from "@/contexts/AdminAuthContext";
import { Button } from "@/components/ui/button";
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarInset,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarProvider,
  SidebarRail,
  SidebarTrigger,
} from "@/components/ui/sidebar";
import { Separator } from "@/components/ui/separator";
import { CustomException, toCustomException } from "@/lib/errors";
import { toast } from "sonner";

export function AdminLayout() {
  const navigate = useNavigate();
  const { signOut } = useAdminAuth();
  const dashboardActive = !!useMatch({ path: "/admin", end: true });
  const productsActive = !!useMatch("/admin/products");
  const categoriesActive = !!useMatch("/admin/categories");

  const handleSignOut = async () => {
    try {
      await signOut();
      toast.success("Signed out");
      navigate("/admin/login", { replace: true });
    } catch (e) {
      const ex = toCustomException(e, "Sign out failed");
      toast.error(ex.message);
      if (!(e instanceof CustomException)) {
        console.error(e);
      }
    }
  };

  return (
    <SidebarProvider>
      <Sidebar collapsible="icon">
        <SidebarHeader className="border-b border-sidebar-border px-4 py-3">
          <span className="text-sm font-semibold tracking-tight">Inventory</span>
        </SidebarHeader>
        <SidebarContent>
          <SidebarGroup>
            <SidebarGroupLabel>Menu</SidebarGroupLabel>
            <SidebarGroupContent>
              <SidebarMenu>
                <SidebarMenuItem>
                  <SidebarMenuButton asChild isActive={dashboardActive} tooltip="Dashboard">
                    <NavLink to="/admin" end className="flex items-center gap-2" activeClassName="font-medium">
                      <LayoutGrid className="size-4" />
                      <span>Dashboard</span>
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
                <SidebarMenuItem>
                  <SidebarMenuButton asChild isActive={productsActive} tooltip="Products">
                    <NavLink to="/admin/products" className="flex items-center gap-2" activeClassName="font-medium">
                      <Package className="size-4" />
                      <span>Products</span>
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
                <SidebarMenuItem>
                  <SidebarMenuButton asChild isActive={categoriesActive} tooltip="Categories">
                    <NavLink to="/admin/categories" className="flex items-center gap-2" activeClassName="font-medium">
                      <Tags className="size-4" />
                      <span>Categories</span>
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              </SidebarMenu>
            </SidebarGroupContent>
          </SidebarGroup>
        </SidebarContent>
        <SidebarFooter className="border-t border-sidebar-border p-2">
          <Button variant="ghost" className="w-full justify-start gap-2" type="button" onClick={() => void handleSignOut()}>
            <LogOut className="size-4" />
            <span>Sign out</span>
          </Button>
        </SidebarFooter>
        <SidebarRail />
      </Sidebar>
      <SidebarInset>
        <header className="flex h-14 shrink-0 items-center gap-2 border-b px-4">
          <SidebarTrigger className="-ml-1" />
          <Separator orientation="vertical" className="mr-2 h-4" />
          <span className="text-muted-foreground text-sm">Admin</span>
        </header>
        <main className="flex-1 overflow-auto p-6">
          <Outlet />
        </main>
      </SidebarInset>
    </SidebarProvider>
  );
}
