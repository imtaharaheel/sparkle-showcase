-- iPad Air M4 (11-inch, Wi-Fi): correct the weight and add the front camera, per Apple's tech specs.
update public.inventory_products p
set specifications = (
  select jsonb_agg(x.elem order by x.ord)
  from (
    select
      case when t.e ->> 'label' = 'Weight' then jsonb_set(t.e, '{value}', '"1.02 pounds"') else t.e end as elem,
      t.ord * 10 as ord
    from jsonb_array_elements(p.specifications) with ordinality as t (e, ord)
    union all
    select
      '{"label": "Selfie Camera", "value": "12 Mega Pixel"}'::jsonb,
      (
        select t.ord * 10 + 5
        from jsonb_array_elements(p.specifications) with ordinality as t (e, ord)
        where t.e ->> 'label' = 'Main Rear Camera'
        limit 1
      )
  ) as x
)
where p.legacy_demo_id = 'apple-ipad-air-m4'
  and jsonb_typeof(p.specifications) = 'array'
  and not exists (
    select 1 from jsonb_array_elements(p.specifications) as e where e ->> 'label' = 'Selfie Camera'
  );
