import { useEffect } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { useMutation } from "@tanstack/react-query";
import {
  categoryFormSchema,
  saveInventoryCategory,
  type CategoryFormValues,
} from "@/lib/admin-categories";
import { toCustomException } from "@/lib/errors";
import type { InventoryCategory } from "@/types/inventory";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Switch } from "@/components/ui/switch";
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

interface CategoryFormDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  editing: InventoryCategory | null;
  categoryCount: number;
  onSaved: () => void;
}

export function CategoryFormDialog({
  open,
  onOpenChange,
  editing,
  categoryCount,
  onSaved,
}: CategoryFormDialogProps) {
  const form = useForm<CategoryFormValues>({
    resolver: zodResolver(categoryFormSchema),
    defaultValues: {
      name: "",
      icon: "📦",
      sort_order: 0,
      is_visible: true,
    },
  });

  useEffect(() => {
    if (!open) return;
    if (editing) {
      form.reset({
        name: editing.name,
        icon: editing.icon ?? "📦",
        sort_order: editing.sort_order ?? 0,
        is_visible: editing.is_visible !== false,
      });
      return;
    }
    form.reset({
      name: "",
      icon: "📦",
      sort_order: (categoryCount + 1) * 10,
      is_visible: true,
    });
  }, [open, editing, categoryCount, form]);

  const saveMutation = useMutation({
    mutationFn: (values: CategoryFormValues) => saveInventoryCategory(values, editing),
    onSuccess: () => {
      toast.success(editing ? "Category updated" : "Category added");
      onSaved();
      onOpenChange(false);
    },
    onError: (error) => {
      toast.error(toCustomException(error, "Could not save category").message);
    },
  });

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader>
          <DialogTitle>{editing ? "Edit category" : "Add category"}</DialogTitle>
          <DialogDescription>
            Visible categories appear in the shop filters and when you add products.
          </DialogDescription>
        </DialogHeader>

        <Form {...form}>
          <form className="space-y-4" onSubmit={form.handleSubmit((v) => saveMutation.mutate(v))}>
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
                    <p className="text-muted-foreground text-sm">Hide to remove from the shop.</p>
                  </div>
                  <FormControl>
                    <Switch checked={field.value} onCheckedChange={field.onChange} />
                  </FormControl>
                </FormItem>
              )}
            />

            <DialogFooter>
              <Button type="button" variant="outline" onClick={() => onOpenChange(false)}>
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
  );
}
