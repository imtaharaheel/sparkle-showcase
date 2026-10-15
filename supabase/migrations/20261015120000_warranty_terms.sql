-- Warranty terms set by the shop (2026-10-15):
--   Meetion and Apple: no warranty.   Laptops (HP, Dell, Lenovo): 1-year international warranty.

-- Meetion: the "Warranty: ..." line in the description
update public.inventory_products
set description = regexp_replace(description, 'Warranty:[^\n]*', 'Warranty: No warranty', 'g')
where brand = 'Meetion' and description ~ 'Warranty:';

-- Apple: the warranty row in the specifications table
update public.inventory_products p
set specifications = (
  select jsonb_agg(case when e->>'label' ilike 'warranty%'
                        then jsonb_build_object('label', 'Warranty', 'value', 'No warranty') else e end order by ord)
  from jsonb_array_elements(p.specifications) with ordinality as t(e, ord)
)
where brand = 'Apple' and specifications::text ilike '%warrant%';

-- Laptops: add (or correct) a warranty row
update public.inventory_products p
set specifications = coalesce((
  select jsonb_agg(e order by ord)
  from jsonb_array_elements(p.specifications) with ordinality as t(e, ord)
  where e->>'label' not ilike 'warranty%'
), '[]'::jsonb) || jsonb_build_array(jsonb_build_object('label', 'Warranty', 'value', '1-year international warranty'))
where brand in ('HP', 'Dell', 'Lenovo');
