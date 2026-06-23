-- Product variants: size / storage options with per-option pricing (JSON).
alter table public.inventory_products
  add column if not exists variants jsonb;

comment on column public.inventory_products.variants is
  'Optional buyer options, e.g. {"dimensions":["size","storage"],"choices":{...},"options":[...],"defaultOptionId":"..."}';
