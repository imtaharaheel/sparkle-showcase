-- Reference URL for imported or linked products (dedup key for catalog imports).
alter table public.inventory_products
  add column if not exists source_url text;

create unique index if not exists inventory_products_source_url_key
  on public.inventory_products (source_url)
  where source_url is not null;
