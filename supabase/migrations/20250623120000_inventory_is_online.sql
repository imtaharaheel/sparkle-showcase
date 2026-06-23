-- Online/offline visibility: offline products stay in admin but are hidden from the public store.
alter table public.inventory_products
  add column if not exists is_online boolean not null default true;

create index if not exists inventory_products_is_online_idx
  on public.inventory_products (is_online);

drop policy if exists "Public read inventory_products for catalog" on public.inventory_products;

create policy "Public read online inventory_products for catalog"
  on public.inventory_products
  for select
  to anon
  using (is_online = true);
