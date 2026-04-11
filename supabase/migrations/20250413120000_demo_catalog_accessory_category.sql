-- All rows imported from the old demo catalog carry legacy_demo_id. Move them to Accessory
-- so you can assign the right category from Admin → Products.

update public.inventory_products p
set category_id = c.id
from public.categories c
where c.slug = 'accessory'
  and p.legacy_demo_id is not null;
