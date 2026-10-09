-- Subcategories: a category may sit under a parent category.
alter table public.categories
  add column if not exists parent_id uuid references public.categories (id) on delete restrict;

create index if not exists categories_parent_id_idx on public.categories (parent_id);

-- Laptop subcategories by processor tier.
insert into public.categories (name, slug, is_visible, sort_order, icon, parent_id)
select v.name, v.slug, true, v.sort_order, '💻', p.id
from (
  values
    ('Ci5 C5 U5', 'laptop-ci5-c5-u5', 1),
    ('Ci7 C7 U7', 'laptop-ci7-c7-u7', 2)
) as v (name, slug, sort_order)
cross join (select id from public.categories where slug = 'laptop') as p
on conflict (slug) do update set parent_id = excluded.parent_id;

-- Move the ten HP laptops added on 2026-10-10 into Ci7 C7 U7.
update public.inventory_products
set category_id = (select id from public.categories where slug = 'laptop-ci7-c7-u7')
where category_id = (select id from public.categories where slug = 'laptop')
  and name in (
    'HP Laptop AI 15-fd2043nia',
    'HP OmniBook X Flip 16-AS0023',
    'HP OmniBook 5 Flip 14-FP0023',
    'HP OmniBook X Flip 14-KP0023',
    'HP OmniBook 5 AI 16-AF1017',
    'HP 15-FD0557',
    'HP OmniBook 3 16-BU0007',
    'HP 15-FD1310TU',
    'HP ProBook 460 G11',
    'HP Victus 15-FA2093DX'
  );
