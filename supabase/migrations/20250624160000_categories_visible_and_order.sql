-- Control which categories appear in shop/admin dropdowns and their order.
alter table public.categories
  add column if not exists is_visible boolean not null default true,
  add column if not exists sort_order integer not null default 0,
  add column if not exists icon text not null default '📦';

insert into public.categories (name, slug, is_visible, sort_order, icon)
values ('Apple Products', 'apple-products', true, 3, '🍎')
on conflict (slug) do update set
  name = excluded.name,
  is_visible = true,
  sort_order = 3,
  icon = '🍎';

update public.categories
set name = 'Accessory', is_visible = true, sort_order = 1, icon = '🧩'
where slug = 'accessory';

update public.categories
set name = 'Laptops', is_visible = true, sort_order = 2, icon = '💻'
where slug = 'laptop';

update public.categories
set is_visible = false
where slug not in ('accessory', 'laptop', 'apple-products');
