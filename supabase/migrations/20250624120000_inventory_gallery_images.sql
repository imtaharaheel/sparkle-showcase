-- Extra product photos for detail-page galleries (primary image stays in image_path).
alter table public.inventory_products
  add column if not exists gallery_image_paths text[] not null default '{}';
