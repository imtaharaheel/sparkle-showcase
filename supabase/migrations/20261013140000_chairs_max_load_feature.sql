-- Gaming chairs: the shop confirmed the maximum load is 136kg; show it in the key features too
-- (the specification table already says 136kg).
update public.inventory_products
set features = array_append(features, 'Maximum load 136kg')
where legacy_demo_id in ('meetion-chr-31', 'meetion-chr-32')
  and not ('Maximum load 136kg' = any (features));
