-- Structured label/value specs for product detail pages (e.g. laptop technical specs).
alter table public.inventory_products
  add column if not exists specifications jsonb not null default '[]'::jsonb;
