-- Allow anonymous (storefront) read access to catalog tables.
-- Inserts/updates/deletes remain restricted by existing admin policies.

grant usage on schema public to anon;

grant select on public.categories to anon;
grant select on public.inventory_products to anon;

create policy "Public read categories for catalog"
  on public.categories
  for select
  to anon
  using (true);

create policy "Public read inventory_products for catalog"
  on public.inventory_products
  for select
  to anon
  using (true);
