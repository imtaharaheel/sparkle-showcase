-- Go-live of the new shop structure (2026-10-12):
--   * brand, key features, videos and driver/software links on products
--   * PC & Gaming Accessories subcategories, PC Components, Projectors, Tripods & Creator Gear
--   * 72 Meetion products (prices: Jan 2026 price list + 12%, rounded up to the next Rs. 100)
--   * branded pictures for the Apple products

alter table public.inventory_products
  add column if not exists brand text,
  add column if not exists features text[] not null default '{}',
  add column if not exists video_urls text[] not null default '{}',
  add column if not exists resource_links jsonb not null default '[]'::jsonb;

create index if not exists inventory_products_brand_idx on public.inventory_products (brand);

-- Categories -----------------------------------------------------------------
update public.categories set name = 'PC & Gaming Accessories' where slug = 'accessory';

insert into public.categories (name, slug, is_visible, sort_order, icon)
values
  ('PC Components', 'pc-components', true, 4, '🖥️'),
  ('Projectors', 'projectors', true, 5, '📽️'),
  ('Tripods & Creator Gear', 'tripods-creator-gear', true, 6, '🎥')
on conflict (slug) do nothing;

insert into public.categories (name, slug, is_visible, sort_order, icon, parent_id)
select v.name, v.slug, true, v.sort_order, '🧩', p.id
from (
  values
    ('Keyboards', 'acc-keyboards', 1),
    ('Mice', 'acc-mice', 2),
    ('Combos & Kits', 'acc-combos', 3),
    ('Headsets', 'acc-headsets', 4),
    ('Speakers', 'acc-speakers', 5),
    ('Microphones', 'acc-microphones', 6),
    ('Mouse Pads', 'acc-mouse-pads', 7),
    ('Cooling Pads', 'acc-cooling-pads', 8),
    ('Gaming Chairs', 'acc-gaming-chairs', 9),
    ('Computer Desks', 'acc-computer-desks', 10)
) as v (name, slug, sort_order)
cross join (select id from public.categories where slug = 'accessory') as p
on conflict (slug) do update set parent_id = excluded.parent_id;

insert into public.categories (name, slug, is_visible, sort_order, icon, parent_id)
select v.name, v.slug, true, v.sort_order, '🖥️', p.id
from (
  values
    ('Power Supplies (PSU)', 'pc-power-supplies', 1),
    ('Water / Liquid Coolers', 'pc-liquid-coolers', 2),
    ('Air Coolers', 'pc-air-coolers', 3),
    ('Case Fans', 'pc-fans', 4),
    ('Computer Cases', 'pc-cases', 5),
    ('Processors', 'pc-processors', 6),
    ('Motherboards', 'pc-motherboards', 7),
    ('Graphics Cards', 'pc-graphics-cards', 8),
    ('RAM', 'pc-memory', 9),
    ('Storage (SSD / HDD)', 'pc-storage', 10)
) as v (name, slug, sort_order)
cross join (select id from public.categories where slug = 'pc-components') as p
on conflict (slug) do update set parent_id = excluded.parent_id;

-- Brands for the products already in the shop --------------------------------
update public.inventory_products set brand = 'Apple' where brand is null and name ilike 'Apple %';
update public.inventory_products set brand = 'HP' where brand is null and name ilike 'HP %';
update public.inventory_products set brand = 'Dell' where brand is null and name ilike 'Dell %';
update public.inventory_products set brand = 'Lenovo' where brand is null and name ilike 'Lenovo %';

-- Meetion products -----------------------------------------------------------
insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK14 TKL Tri-Mode Mechanical Keyboard',
  'Model: Meetion MK14

Connection: Type-C cable, 2.4G wireless and Bluetooth (tri-mode)
Warranty: 1-year limited warranty',
  11000, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk14-1.jpg',
  array['/products/meetion/mk14-1.jpg', '/products/meetion/mk14-2.jpg', '/products/meetion/mk14-3.jpg', '/products/meetion/mk14-4.jpg', '/products/meetion/mk14-5.jpg']::text[],
  'https://www.meetion.com/mt-mk14.html',
  'meetion-mk14',
  true,
  'Meetion',
  array['Wired + 2.4G + Bluetooth Tri-Mode', 'OEM Profile Keycaps', 'Hot-Swappable Switches', 'Cloud Driver', 'Silver-like Switches/Silent Switches with POM Material and Self-Lubricating', 'RGB Backlit', 'Two-Stage Adjustable stand', 'SupportMulti-System: Win/Mac/iOS/Android 9.87% Layout, TKL (Tenkeyless) Design 10. 4000mAh Battery']::text[],
  '[{"label": "Model", "value": "MT-MK14"}, {"label": "Color", "value": "White/Black"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Dimension", "value": "359.3*140.9*38.4mm"}, {"label": "Type", "value": "Mechanical"}, {"label": "No. of keys", "value": "87/88"}, {"label": "Backlight", "value": "RGB"}, {"label": "Error-free running time", "value": "More than 50 million times"}, {"label": "Battery", "value": "4000mAh"}, {"label": "Interface", "value": "Type-C"}, {"label": "Charge time", "value": "8h"}, {"label": "Wire length", "value": "180 ± 1 cm"}, {"label": "Connection", "value": "2.4G+wired+Bluetooth"}, {"label": "Compatible Systems", "value": "WinXP/Vista/ 7/8/10/11/Android/Mac OS/IOS"}]'::jsonb,
  array['https://www.youtube.com/watch?v=8bMJiH5CjuU', 'https://www.youtube.com/watch?v=VeXt0cBRxeY']::text[],
  '[{"label": "Cloud driver (online)", "url": "https://www.meetion.com/clouddriver.html"}, {"label": "Driver software page", "url": "https://www.meetion.com/mk14-gaming-keyboard-driver-software.html"}]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "mk14-black", "color": "Black", "price": 11000, "image": "/products/meetion/mk14-1.jpg"}, {"id": "mk14-white", "color": "White", "price": 11000}], "defaultOptionId": "mk14-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk14');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK12 65% Tri-Mode Mechanical Keyboard',
  'Model: Meetion MK12

Connection: Type-C cable, 2.4G wireless and Bluetooth (tri-mode)
Warranty: 1-year limited warranty',
  9800, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk12-1.jpg',
  array['/products/meetion/mk12-1.jpg', '/products/meetion/mk12-2.jpg', '/products/meetion/mk12-3.jpg', '/products/meetion/mk12-4.jpg', '/products/meetion/mk12-5.jpg']::text[],
  'https://www.meetion.com/mt-mk12.html',
  'meetion-mk12',
  true,
  'Meetion',
  array['ABS Plastic', 'Wired + 2.4G + 3 Bluetooth channels, Tri-Mode', 'OEM Height Keycaps', 'Hot-Swappable Switches', 'Cloud Driver + Local Driver', 'Silver-Like Switches, POM Material Pivot, Self-Lubricating', 'RGB Backlight', 'Two-Stage Height Feet', 'Multi-System Support: Windows/Mac/iOS/Android 65% Layout 10.2000mAh Battery']::text[],
  '[{"label": "Model", "value": "MT-MK12"}, {"label": "Color", "value": "White/Black"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Dimension", "value": "320*116.5*40mm"}, {"label": "Type", "value": "Mechanical"}, {"label": "No. of keys", "value": "68/69"}, {"label": "Backlight", "value": "RGB"}, {"label": "Error-free running time", "value": "More than 50 million times"}, {"label": "Battery", "value": "2000mAh"}, {"label": "Interface", "value": "Type-C"}, {"label": "Charge time", "value": "4h"}, {"label": "Wire length", "value": "180 ± 1 cm"}, {"label": "Connection", "value": "2.4G+wired+Bluetooth"}, {"label": "Compatible Systems", "value": "WinXP/Vista/ 7/8/10/11/Android/Mac OS/IOS"}]'::jsonb,
  array['https://www.youtube.com/watch?v=anePV4OCCbw']::text[],
  '[{"label": "Cloud driver (online)", "url": "https://www.meetion.com/clouddriver.html"}, {"label": "Driver software page", "url": "https://www.meetion.com/driver/mk12.html"}]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "mk12-black", "color": "Black", "price": 9800, "image": "/products/meetion/mk12-1.jpg"}, {"id": "mk12-white", "color": "White", "price": 9800}], "defaultOptionId": "mk12-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk12');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK009 Pro RGB Mechanical Keyboard with Knob',
  'Model: Meetion MK009 Pro

Connection: Detachable USB Type-C cable
Warranty: 1-year limited warranty',
  7700, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk009-pro-1.jpg',
  array['/products/meetion/mk009-pro-1.jpg', '/products/meetion/mk009-pro-2.jpg', '/products/meetion/mk009-pro-3.jpg', '/products/meetion/mk009-pro-4.jpg', '/products/meetion/mk009-pro-5.jpg']::text[],
  'https://www.meetion.com/mt-mk009pro.html',
  'meetion-mk009-pro',
  true,
  'Meetion',
  array['Back light: RGB Colorful', 'Switch Lifespan: 50 million keystrokes', 'No. of keys: 104/105+1 Keys', 'Interface: Type-C', 'Cable Length: 1.8±0.1m', 'Supported Systems: Win XP/Vista/7/8/10/11']::text[],
  '[{"label": "Model", "value": "MK009 Pro"}, {"label": "Brand", "value": "Meetion"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "320*116.5*40mm"}, {"label": "Type", "value": "Mechanical"}, {"label": "Weight", "value": "798±10g"}, {"label": "No. of keys", "value": "104/105+1 Keys"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Keycap Crafting", "value": "ABS Double-Shot Keycaps"}, {"label": "Switch Lifespan", "value": "50 million keystrokes"}, {"label": "Supported Systems", "value": "Win XP/Vista/7/8/10/11"}, {"label": "Switch Type", "value": "Red Switch"}, {"label": "Interface", "value": "Type-C"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  '{}'::text[],
  '[{"label": "Driver software page", "url": "https://www.meetion.com/driver/mk009pro.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk009-pro');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK009RD Rainbow Mechanical Keyboard with Knob',
  'Model: Meetion MK009RD

Connection: Detachable USB Type-C cable
Warranty: 1-year limited warranty',
  5300, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk009rd-1.jpg',
  array['/products/meetion/mk009rd-1.jpg']::text[],
  'https://www.meetion.com/mk009-rainbow-hot-swappable-mechanical-keyboard.html',
  'meetion-mk009rd',
  true,
  'Meetion',
  array['Metal top cover with volume knob', 'Double-injection keycaps with backlit characters', 'Hot-swappable red switches', 'Rainbow backlighting', 'Detachable USB Type-C cable']::text[],
  '[{"label": "Model", "value": "MK009RD"}, {"label": "Type", "value": "Mechanical keyboard"}, {"label": "Switches", "value": "Red, hot-swappable"}, {"label": "Keycaps", "value": "Double-injection, backlit characters"}, {"label": "Backlight", "value": "Rainbow"}, {"label": "Top cover", "value": "Metal, with volume knob"}, {"label": "Connection", "value": "Detachable USB Type-C cable"}, {"label": "Packaging", "value": "Colour box"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk009rd');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK008 Pro 80% RGB Mechanical Keyboard',
  'Model: Meetion MK008 Pro

Connection: Detachable USB Type-C cable
Warranty: 1-year limited warranty',
  6000, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk008-pro-1.jpg',
  array['/products/meetion/mk008-pro-1.jpg', '/products/meetion/mk008-pro-2.jpg', '/products/meetion/mk008-pro-3.jpg', '/products/meetion/mk008-pro-4.jpg', '/products/meetion/mk008-pro-5.jpg']::text[],
  'https://www.meetion.com/mt-mk008pro.html',
  'meetion-mk008-pro',
  true,
  'Meetion',
  array['Back light: RGB Colorful', 'Switch Lifespan: 50 Million keystrokes', 'No. of keys: 87/88+1 Keys', 'Interface: Type-C', 'Cable Length: 1.8±0.1m', 'Supported Systems: Win XP/Vista/7/8/10/11']::text[],
  '[{"label": "Model", "value": "MK008 Pro"}, {"label": "Brand", "value": "Meetion"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "352*125*40mm"}, {"label": "Type", "value": "Mechanical"}, {"label": "Weight", "value": "631±10g"}, {"label": "No. of keys", "value": "87/88+1 Keys"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Keycap Crafting", "value": "ABS Double-Shot Keycaps"}, {"label": "Switch Lifespan", "value": "50 Million keystrokes"}, {"label": "Supported Systems", "value": "Win XP/Vista/7/8/10/11"}, {"label": "Switch Type", "value": "Red Switch"}, {"label": "Interface", "value": "Type-C"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  '{}'::text[],
  '[{"label": "Driver software page", "url": "https://www.meetion.com/driver/mk009pro.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk008-pro');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK006 Pro 75% RGB Mechanical Keyboard',
  'Model: Meetion MK006 Pro

Connection: Detachable USB Type-C cable
Warranty: 1-year limited warranty',
  6800, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk006-pro-1.jpg',
  array['/products/meetion/mk006-pro-1.jpg', '/products/meetion/mk006-pro-2.jpg', '/products/meetion/mk006-pro-3.jpg', '/products/meetion/mk006-pro-4.jpg', '/products/meetion/mk006-pro-5.jpg']::text[],
  'https://www.meetion.com/mt-mk006pro.html',
  'meetion-mk006-pro',
  true,
  'Meetion',
  array['Back light: RGB Colorful', 'Switch Lifespan: 50 million keystrokes', 'No. of keys: 80/81+1 Keys', 'Interface: Type-C', 'Cable Length: 1.8±0.1m', 'Supported Systems: Win XP/Vista/7/8/10/11']::text[],
  '[{"label": "Model", "value": "MK006 Pro"}, {"label": "Brand", "value": "Meetion"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "315*125*40mm"}, {"label": "Type", "value": "Mechanical"}, {"label": "Weight", "value": "579±10g"}, {"label": "No. of keys", "value": "80/81+1 Keys"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Keycap Crafting", "value": "ABS Double-Shot Keycaps"}, {"label": "Switch Lifespan", "value": "50 million keystrokes"}, {"label": "Supported Systems", "value": "Win XP/Vista/7/8/10/11"}, {"label": "Switch Type", "value": "Red Switch"}, {"label": "Interface", "value": "Type-C"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  '{}'::text[],
  '[{"label": "Driver software page", "url": "https://www.meetion.com/driver/mk009pro.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk006-pro');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK005 60% Mechanical Keyboard',
  'Model: Meetion MK005

Connection: USB cable
Warranty: 1-year limited warranty',
  5400, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk005-1.jpg',
  array['/products/meetion/mk005-1.jpg', '/products/meetion/mk005-white.jpg', '/products/meetion/mk005-2.jpg', '/products/meetion/mk005-3.jpg', '/products/meetion/mk005-4.jpg', '/products/meetion/mk005-5.jpg']::text[],
  'https://www.meetion.com/mt-mk005.html',
  'meetion-mk005',
  true,
  'Meetion',
  array['No. of keys: 61/62', 'Interface: Type-C - USB Cable', 'Cable length: 1.8±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/MAC OS', 'Weight: 555±5g', 'Dimension: 292*102*38mm']::text[],
  '[{"label": "Model", "value": "MT-MK005"}, {"label": "Color", "value": "Black\\White"}, {"label": "No. of keys", "value": "61/62"}, {"label": "Dimension", "value": "292*102*38mm"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Weight", "value": "555±5g"}, {"label": "Keyboard type", "value": "Mechanical"}, {"label": "Interface", "value": "Type-C - USB Cable"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/MAC OS"}, {"label": "Cable length", "value": "1.8±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "mk005-black", "color": "Black", "price": 5400, "image": "/products/meetion/mk005-1.jpg"}, {"id": "mk005-white", "color": "White", "price": 5400, "image": "/products/meetion/mk005-white.jpg"}], "defaultOptionId": "mk005-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk005');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MK005BT 60% Bluetooth Mechanical Keyboard',
  'Model: Meetion MK005BT

Connection: USB Type-C cable and Bluetooth
Warranty: 1-year limited warranty',
  8100, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/mk005bt-1.jpg',
  array['/products/meetion/mk005bt-1.jpg', '/products/meetion/mk005bt-2.jpg']::text[],
  'https://www.meetion.com/mt-mk005bt.html',
  'meetion-mk005bt',
  true,
  'Meetion',
  array['No. of keys: 61/62', 'Interface: Type-C - USB Cable', 'Cable length: 1.8±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/MAC OS/ iOS/Android/HarmonyOS', 'Weight: 555±5g', 'Dimension: 292*102*38mm']::text[],
  '[{"label": "Model", "value": "MT-MK005BT"}, {"label": "Color", "value": "Black\\White"}, {"label": "No. of keys", "value": "61/62"}, {"label": "Dimension", "value": "292*102*38mm"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Weight", "value": "555±5g"}, {"label": "Keyboard type", "value": "Mechanical"}, {"label": "Driver software", "value": "DOWNLOAD"}, {"label": "Interface", "value": "Type-C - USB Cable"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/MAC OS/ iOS/Android/HarmonyOS"}, {"label": "Cable length", "value": "1.8±0.01m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=gLLB2rZ1g14']::text[],
  '[{"label": "Software download (rar file)", "url": "https://www.meetion.com/lifisher-m0/1687762801638-meetion-gaming-mk005bt.rar"}, {"label": "Driver software page", "url": "https://www.meetion.com/driver-mk005bt.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mk005bt');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion K9320 Rainbow Backlit Gaming Keyboard',
  'Model: Meetion K9320

Connection: USB cable
Warranty: 1-year limited warranty',
  2200, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/k9320-1.jpg',
  array['/products/meetion/k9320-1.jpg']::text[],
  'https://www.meetion.com/mt-k9320.html',
  'meetion-k9320',
  true,
  'Meetion',
  array['No. of keys: 104/105', 'Interface: USB', 'Cable length: 1.50±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 640±5g', 'Dimension: 465*171*35mm']::text[],
  '[{"label": "Model", "value": "MT-K9320"}, {"label": "Color", "value": "Black"}, {"label": "No. of keys", "value": "104/105"}, {"label": "Dimension", "value": "465*171*35mm"}, {"label": "Keyboard type", "value": "Membrane"}, {"label": "Weight", "value": "640±5g"}, {"label": "Cable length", "value": "1.50±0.01m"}, {"label": "Interface", "value": "USB"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Model", "value": "MT-K9320"}]'::jsonb,
  array['https://www.youtube.com/watch?v=9dFAK8_EhoA', 'https://www.youtube.com/watch?v=59yVWw8iKm0']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-k9320');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion C490 4-in-1 Gaming Kit',
  'Model: Meetion C490

Connection: USB cable
Warranty: 1-year limited warranty',
  5200, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/c490-1.jpg',
  array['/products/meetion/c490-1.jpg']::text[],
  'https://www.meetion.com/4-in-1-pc-gaming-kits.html',
  'meetion-c490',
  true,
  'Meetion',
  array['Resolution: 800/1600/2400', 'Maximum polling rate: 250 Hz', 'Interface: USB', 'Microphone: Omni-directional', 'Wire length: 180 cm', 'OS Compatibility: Windows XP/Vista/7/8/10/11/Mac OS']::text[],
  '[{"label": "Mouse", "value": "Keyboard"}, {"label": "Q-ty of keys", "value": "4 buttons"}, {"label": "Keyboard layout", "value": "104/105"}, {"label": "Resolution", "value": "800/1600/2400"}, {"label": "Q-ty of shortcut buttons", "value": "12"}, {"label": "Maximum frame rate", "value": "4000 fps"}, {"label": "OS Compatibility", "value": "Windows XP/Vista/7/8/10/11/Mac OS"}, {"label": "Maximal tracking speed", "value": "30 ips"}, {"label": "Error-free running time", "value": "More than 10 million times"}, {"label": "Maximum polling rate", "value": "250 Hz"}, {"label": "Interface", "value": "USB"}, {"label": "Maximum acceleration", "value": "8 g"}, {"label": "Wire length", "value": "180 cm"}, {"label": "Wire length", "value": "180 cm"}, {"label": "Dimensions(W×H×L)", "value": "approx.: 470*188.5*34.5mm"}, {"label": "Dimensions(W×H×L)", "value": "approx.: 120*60*38.5mm"}, {"label": "Headphone", "value": "Mouse pad"}, {"label": "Speaker size", "value": "Φ40 * 9H mm"}, {"label": "Dimensions", "value": "280*200*3mm"}, {"label": "Mic Sensitivity", "value": "-38±3dB(0dB=1V/Pa,1KHz)"}, {"label": "Weight", "value": "90±5g"}, {"label": "Impedance", "value": "32Ω±15%"}, {"label": "Frequency response", "value": "20Hz~20K Hz"}, {"label": "Microphone", "value": "Omni-directional"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-c490');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion C505 4-in-1 Gaming Kit',
  'Model: Meetion C505

Connection: USB cable
Warranty: 1-year limited warranty',
  7800, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/c505-1.jpg',
  array['/products/meetion/c505-1.jpg']::text[],
  'https://www.meetion.com/mt-c505.html',
  'meetion-c505',
  true,
  'Meetion',
  array['Resolution: 800/1600/2400/3200', 'Maximum polling rate: 250 Hz', 'Interface: USB', 'Speaker: Φ40mm', 'Microphone: Omni-directional', 'Wire length: 180 cm']::text[],
  '[{"label": "Mouse", "value": "Keyboard"}, {"label": "Q-ty of keys", "value": "6 buttons"}, {"label": "Keyboard layout", "value": "104/105"}, {"label": "Resolution", "value": "800/1600/2400/3200"}, {"label": "Q-ty of shortcut buttons", "value": "12"}, {"label": "Maximum frame rate", "value": "4000 fps"}, {"label": "OS Compatibility", "value": "Windows XP/Vista/7/8/10/11/Mac OS"}, {"label": "Maximal tracking speed", "value": "30 ips"}, {"label": "Error-free running time", "value": "More than 10 million times"}, {"label": "Maximum polling rate", "value": "250 Hz"}, {"label": "Interface", "value": "USB"}, {"label": "Maximum acceleration", "value": "8 g"}, {"label": "Wire length", "value": "180 cm"}, {"label": "Wire length", "value": "180 cm"}, {"label": "Dimensions(W×H×L)", "value": "approx.: 480*198*34mm"}, {"label": "Dimensions(W×H×L)", "value": "approx.: 130*69*41.5mm"}, {"label": "Headphone", "value": "Mouse pad"}, {"label": "Speaker", "value": "Φ40mm"}, {"label": "Dimensions", "value": "320*240*5mm"}, {"label": "Sensitivity", "value": "120±3db"}, {"label": "Weight", "value": "146±5g"}, {"label": "Impedance", "value": "32Ω"}, {"label": "Frequency response", "value": "10~20,000Hz"}, {"label": "Microphone", "value": "Omni-directional"}]'::jsonb,
  array['https://www.youtube.com/watch?v=oaKLhmybUDM']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-c505');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion GM23 RGB Gaming Mouse',
  'Model: Meetion GM23

Connection: USB cable
Warranty: 1-year limited warranty',
  2900, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/gm23-1.jpg',
  array['/products/meetion/gm23-1.jpg', '/products/meetion/gm23-2.jpg', '/products/meetion/gm23-3.jpg', '/products/meetion/gm23-4.jpg', '/products/meetion/gm23-5.jpg']::text[],
  'https://www.meetion.com/mt-gm23_2023.html',
  'meetion-gm23',
  true,
  'Meetion',
  array['Resolution: 12800CPI', 'Polling Rate: 125~1000 Hz/ms', 'Buttons: 5+1 Keys', 'Back light: RGB Colorful', 'Interface: USB', 'Cable Length: 1.8±0.1m']::text[],
  '[{"label": "Model", "value": "GM23_2023"}, {"label": "Color", "value": "Black/White"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "128*81*40mm"}, {"label": "Resolution", "value": "12800CPI"}, {"label": "Weight", "value": "129±5g"}, {"label": "Buttons", "value": "5+1 Keys"}, {"label": "Game Type", "value": "FPS/MMORPG/MOBA/RTS"}, {"label": "Polling Rate", "value": "125~1000 Hz/ms"}, {"label": "Frame Rate", "value": "Max.7000 fps"}, {"label": "Max. Tracking Speed", "value": "60 ips"}, {"label": "Max. Acceleration", "value": "20G"}, {"label": "Compatible systems", "value": "Win XP/Vista/7/8/10 / MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  '{}'::text[],
  '[{"label": "Software download (zip file)", "url": "https://www.meetion.com/lifisher-m0/1683542726978-meetion-combine.zip"}, {"label": "Driver software page", "url": "https://www.meetion.com/gm23mouse-driver-software.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-gm23');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion GM21 RGB Gaming Mouse',
  'Model: Meetion GM21

Connection: USB cable
Warranty: 1-year limited warranty',
  2000, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/gm21-1.jpg',
  array['/products/meetion/gm21-1.jpg']::text[],
  'https://www.meetion.com/mt-gm21.html',
  'meetion-gm21',
  true,
  'Meetion',
  array['Resolution: 12000CPI', 'Polling Rate: 125-1000 Hz / ms', 'Buttons: 6 + 1 Keys', 'Back light: RGB Colorful', 'Interface: USB', 'Cable Length: 1.8 ± 0.1m']::text[],
  '[{"label": "Model", "value": "GM21_2023"}, {"label": "Color", "value": "Black"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "127 * 65 * 49mm"}, {"label": "Resolution", "value": "12000CPI"}, {"label": "Weight", "value": "119±5g"}, {"label": "Buttons", "value": "6 + 1 Keys"}, {"label": "Game Tvpe", "value": "FPS / MMORPG / MOBA / RTS"}, {"label": "Polling Rate", "value": "125-1000 Hz / ms"}, {"label": "Frame Rate", "value": "Max 7000 fps"}, {"label": "Max Tracking Speed", "value": "60ips"}, {"label": "Max Acceleration", "value": "20G"}, {"label": "Compatible systems", "value": "Win XP / Vista / 7 / 8 / 10 / MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable Length", "value": "1.8 ± 0.1m"}]'::jsonb,
  '{}'::text[],
  '[{"label": "Software download (zip file)", "url": "https://www.meetion.com/lifisher-m0/1683542726978-meetion-combine.zip"}, {"label": "Driver software page", "url": "https://www.meetion.com/gm21p-gm21_2023-mouse-driver-software.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-gm21');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion GM19 RGB Gaming Mouse',
  'Model: Meetion GM19

Connection: USB cable
Warranty: 1-year limited warranty',
  2500, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/gm19-1.jpg',
  array['/products/meetion/gm19-1.jpg']::text[],
  'https://www.meetion.com/mt-gm19.html',
  'meetion-gm19',
  true,
  'Meetion',
  array['Resolution: 6400 DPI', 'Polling Rate: 125Hz/ms', 'Buttons: 6+1 Keys', 'Back light: RGB Colorful', 'Interface: USB', 'Cable Length: 1.8±0.1m']::text[],
  '[{"label": "Model", "value": "GM19"}, {"label": "Color", "value": "Black"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "123*67*43mm"}, {"label": "Resolution", "value": "6400 DPI"}, {"label": "Weight", "value": "160±5g"}, {"label": "Buttons", "value": "6+1 Keys"}, {"label": "Game Type", "value": "FPS/MMORPG/MOBA/RTS"}, {"label": "Polling Rate", "value": "125Hz/ms"}, {"label": "Frame Rate", "value": "3000 fps"}, {"label": "Max. Tracking Speed", "value": "32 ips"}, {"label": "Max. Acceleration", "value": "12G"}, {"label": "SPI Sampling Time", "value": "2ms"}, {"label": "Mat", "value": "Teflon Mat"}, {"label": "Interface", "value": "USB"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=LOVbB49EqX8', 'https://www.youtube.com/watch?v=je3xHIwL8Rk']::text[],
  '[{"label": "Software download (zip file)", "url": "https://www.meetion.com/lifisher-1657270219885.zip"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-gm19');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion GM015 Honeycomb RGB Gaming Mouse',
  'Model: Meetion GM015

Connection: USB cable
Warranty: 1-year limited warranty',
  2700, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/gm015-1.jpg',
  array['/products/meetion/gm015-1.jpg', '/products/meetion/gm015-2.jpg', '/products/meetion/gm015-3.jpg', '/products/meetion/gm015-4.jpg', '/products/meetion/gm015-5.jpg']::text[],
  'https://www.meetion.com/mt-gm015.html',
  'meetion-gm015',
  true,
  'Meetion',
  array['Resolution: 6400CPI', 'Polling Rate: 125-1000 Hz / ms', 'Buttons: 7 + 1 Keys', 'Back light: RGB Colorful', 'Interface: USB', 'Cable Length: 1.8 ± 0.1m']::text[],
  '[{"label": "Model", "value": "GM015"}, {"label": "Color", "value": "Black"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "123 * 66 * 42mm"}, {"label": "Resolution", "value": "6400CPI"}, {"label": "Weight", "value": "122±5g"}, {"label": "Buttons", "value": "7 + 1 Keys"}, {"label": "Game Tvpe", "value": "FPS / MMORPG / MOBA / RTS"}, {"label": "Polling Rate", "value": "125-1000 Hz / ms"}, {"label": "Frame Rate", "value": "Max 6000 fps"}, {"label": "Max Tracking Speed", "value": "30ips"}, {"label": "Max Acceleration", "value": "22 . 5G"}, {"label": "Compatible systems", "value": "Win XP / Vista / 7 / 8 / 10 / MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable Length", "value": "1.8 ± 0.1m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=bz9OG8IvY1Q', 'https://www.youtube.com/watch?v=7rqtWxDJPAQ']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-gm015');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion M930 Wired Gaming Mouse',
  'Model: Meetion M930

Connection: USB cable
Warranty: 1-year limited warranty',
  1400, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/m930-1.jpg',
  array['/products/meetion/m930-1.jpg', '/products/meetion/m930-2.jpg', '/products/meetion/m930-3.jpg', '/products/meetion/m930-4.jpg', '/products/meetion/m930-5.jpg']::text[],
  'https://www.meetion.com/mt-m930new.html',
  'meetion-m930',
  true,
  'Meetion',
  array['Resolution: 800-1200-2400-3200 dpi', 'Maximum polling rate: 250 Hz', 'Buttons: 5+1(scroll wheel)', 'Compatible systems: Win XP/Vista/7/8/10 / 11/MAC OS', 'Weight: 95±5g', 'Dimension: 126*64*40mm']::text[],
  '[{"label": "Item Name", "value": "USB Backlit Gaming Mouse"}, {"label": "Color", "value": "Black"}, {"label": "Model No", "value": "MT-M930"}, {"label": "Dimension", "value": "126*64*40mm"}, {"label": "Resolution", "value": "800-1200-2400-3200 dpi"}, {"label": "Weight", "value": "95±5g"}, {"label": "Buttons", "value": "5+1(scroll wheel)"}, {"label": "Compatible systems", "value": "Win XP/Vista/7/8/10 / 11/MAC OS"}, {"label": "Frame rate", "value": "4000FPS"}, {"label": "Max Acceleration", "value": "8G"}, {"label": "Maximal tracking speed", "value": "30 ips"}, {"label": "Maximum polling rate", "value": "250 Hz"}]'::jsonb,
  array['https://www.youtube.com/watch?v=Zj4KWbBUAYA']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-m930');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion GW38 Tri-Mode Wireless Gaming Mouse',
  'Model: Meetion GW38

Connection: Type-C cable, 2.4G wireless and Bluetooth (tri-mode)
Warranty: 1-year limited warranty',
  5100, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/gw38-1.jpg',
  array['/products/meetion/gw38-1.jpg', '/products/meetion/gw38-2.jpg', '/products/meetion/gw38-3.jpg', '/products/meetion/gw38-4.jpg', '/products/meetion/gw38-5.jpg']::text[],
  'https://www.meetion.com/mt-gw38.html',
  'meetion-gw38',
  true,
  'Meetion',
  array['Medium to large hand size', 'Wired + 2.4G + Bluetooth tri-mode, plug-and-play wired connection', 'Local driver', 'With charging dock', 'RGB LED', 'Max. 8000dpi', 'Polling Rate: 1KHz/s (2.4G), 1KHz/s (Wired), 125Hz/s (Bluetooth)', 'Sensor: PAW3104', 'Battery: 650mAh, 30 hours (with light ON) / 60 hours (with light OFF)']::text[],
  '[{"label": "Model", "value": "GW38"}, {"label": "Color", "value": "Genting White/Karst Black"}, {"label": "Back light", "value": "RGB"}, {"label": "Dimension", "value": "125*63.5*40.5mm"}, {"label": "Resolution", "value": "8000 DPI"}, {"label": "Weight", "value": "82g"}, {"label": "Buttons", "value": "6 Keys"}, {"label": "Game Type", "value": "FPS/MMORPG/MOBA/RTS"}, {"label": "Battery", "value": "650mAh"}, {"label": "Polling Rate", "value": "125-1000Hz/1ms"}, {"label": "Charge time", "value": "2 hours"}, {"label": "Connection method", "value": "2.4G+Bluetooth+Wired"}, {"label": "Battery Life", "value": "30 hours (light on) / 60 hours (light off)"}, {"label": "Max. Tracking Speed", "value": "45IPS"}, {"label": "Max. Acceleration", "value": "15G"}, {"label": "Left and right key switch", "value": "20million times micro"}, {"label": "Mat", "value": "PTFE Teflon foot pads"}, {"label": "Interface", "value": "Type-C"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=_1ghLzpWOIE', 'https://www.youtube.com/watch?v=PNvmjokQegQ']::text[],
  '[{"label": "Driver software page", "url": "https://www.meetion.com/driver/gw38.html"}]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "gw38-black", "color": "Black", "price": 5100, "image": "/products/meetion/gw38-1.jpg"}, {"id": "gw38-white", "color": "White", "price": 5100}], "defaultOptionId": "gw38-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-gw38');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion GW32 Tri-Mode Wireless Gaming Mouse',
  'Model: Meetion GW32

Connection: Type-C cable, 2.4G wireless and Bluetooth (tri-mode)
Colour: Black
Warranty: 1-year limited warranty',
  4500, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/gw32-1.jpg',
  array['/products/meetion/gw32-1.jpg', '/products/meetion/gw32-2.jpg', '/products/meetion/gw32-3.jpg', '/products/meetion/gw32-4.jpg', '/products/meetion/gw32-5.jpg']::text[],
  'https://www.meetion.com/mt-gw32.html',
  'meetion-gw32',
  true,
  'Meetion',
  array['ABS Plastic', 'Right-hand ergonomic', 'With side scroll wheel', 'With RGB LED', 'Wired + 2.4G + Bluetooth tri-mode, wired plug and play', 'Native driver', 'Max. 8000 dpi', 'Polling Rate: 1 KHz (Wired & 2.4G), 125 Hz (Bluetooth)', 'Sensor: PAW3220', 'Battery: 700mAh, 35 hours (Light ON) / 115 hours (Light OFF)']::text[],
  '[{"label": "Model", "value": "GW32"}, {"label": "Color", "value": "White/Black"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "117.7*73.4*43.7mm"}, {"label": "Resolution", "value": "400-8000 DPI"}, {"label": "Weight", "value": "98g"}, {"label": "Buttons", "value": "7 Keys"}, {"label": "Game Type", "value": "FPS/MMORPG/MOBA/RTS"}, {"label": "Battery", "value": "700mAh"}, {"label": "Polling Rate", "value": "125~1000Hz/1ms"}, {"label": "Charge time", "value": "2-3 hours"}, {"label": "Connection method", "value": "2.4G+Bluetooth+wired"}, {"label": "Max. Tracking Speed", "value": "30 IPS"}, {"label": "Max. Acceleration", "value": "10G"}, {"label": "Left and right key switch", "value": "20 million times micro"}, {"label": "Mat", "value": "PTFE Teflon foot pads"}, {"label": "Interface", "value": "Type-C"}, {"label": "Cable Length", "value": "1.8±0.1m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=lv9jccjy84g', 'https://www.youtube.com/watch?v=M60icpT39qY']::text[],
  '[{"label": "Driver software page", "url": "https://www.meetion.com/driver/gw32.html"}]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-gw32');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion M915 Backlit Wired Gaming Mouse',
  'Model: Meetion M915

Connection: USB cable
Warranty: 1-year limited warranty',
  1500, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/m915-1.jpg',
  array['/products/meetion/m915-1.jpg']::text[],
  'https://www.meetion.com/mt-m915.html',
  'meetion-m915',
  true,
  'Meetion',
  array['Resolution: 800-1200-1600-2400 dpi', 'Sensor: optical A704', 'Polling rate: 250 Hz/ms', 'Buttons: 5+1(scroll wheel)', 'Interface: USB', 'Cable length: 1.6±0.01m']::text[],
  '[{"label": "Model", "value": "M915"}, {"label": "Color", "value": "Black\\White"}, {"label": "Sensor", "value": "optical A704"}, {"label": "Dimension", "value": "135*73*42mm"}, {"label": "Resolution", "value": "800-1200-1600-2400 dpi"}, {"label": "Weight", "value": "160±5g"}, {"label": "Buttons", "value": "5+1(scroll wheel)"}, {"label": "Gaming type", "value": "FPS/MMORPG/MOBA/RTS"}, {"label": "Polling rate", "value": "250 Hz/ms"}, {"label": "Frame rate", "value": "4000 fps"}, {"label": "Acceleration", "value": "Max. 8 g"}, {"label": "Tracking Speed", "value": "Max. 30 ips"}, {"label": "Compatible system", "value": "Win XP/Vista/7/8/10, MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable length", "value": "1.6±0.01m"}, {"label": "Driver software", "value": "www.meetion.com/driver"}]'::jsonb,
  array['https://www.youtube.com/watch?v=ERnmvmPOc4I']::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "m915-black", "color": "Black", "price": 1500, "image": "/products/meetion/m915-1.jpg"}, {"id": "m915-white", "color": "White", "price": 1500}], "defaultOptionId": "m915-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-m915');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP022 Gaming Headset',
  'Model: Meetion HP022

Connection: USB plus two 3.5mm plugs
Warranty: 1-year limited warranty',
  1800, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp022-1.jpg',
  array['/products/meetion/hp022-1.jpg', '/products/meetion/hp022-2.jpg', '/products/meetion/hp022-3.jpg', '/products/meetion/hp022-4.jpg', '/products/meetion/hp022-5.jpg']::text[],
  'https://www.meetion.com/mt-hp022.html',
  'meetion-hp022',
  true,
  'Meetion',
  array['Interface: USB', 'USB cable length: 1.8m', 'Supported Systems: Windows/MacOS/Android', 'Weight: 211±5g', 'Material: PU+Fabric (cloth material)']::text[],
  '[{"label": "Model", "value": "HP022"}, {"label": "Brand", "value": "Meetion"}, {"label": "Frequency", "value": "20Hz~20,000Hz"}, {"label": "Recording frequency", "value": "50Hz~16,000Hz"}, {"label": "Headphone sensitivity", "value": "105±3db"}, {"label": "Weight", "value": "211±5g"}, {"label": "Microphone sensitivity", "value": "-38±2db"}, {"label": "Signal-to-noise ratio", "value": "60DB"}, {"label": "Material", "value": "PU+Fabric (cloth material)"}, {"label": "Interface", "value": "USB"}, {"label": "Inner diameter", "value": "50*55mm"}, {"label": "USB cable length", "value": "1.8m"}, {"label": "Depth", "value": "13mm"}, {"label": "Supported Systems", "value": "Windows/MacOS/Android"}, {"label": "Speaker driver size", "value": "40mm"}, {"label": "Headset function", "value": "Music, calls"}, {"label": "Microphone diameter", "value": "Φ6*5MM"}, {"label": "Nonlinear distortion factor", "value": "5%"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp022');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP099 7.1 Surround Gaming Headset',
  'Model: Meetion HP099

Connection: USB cable
Colour: Black
Warranty: 1-year limited warranty',
  8300, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp099-1.jpg',
  array['/products/meetion/hp099-1.jpg', '/products/meetion/hp099-2.jpg', '/products/meetion/hp099-3.jpg', '/products/meetion/hp099-4.jpg', '/products/meetion/hp099-5.jpg']::text[],
  'https://www.meetion.com/hp099.html',
  'meetion-hp099',
  true,
  'Meetion',
  array['Hi-Fi 7.1 surround sound', 'Volume control on the headset', '50mm speaker drivers', 'USB plug, 1.8m cable']::text[],
  '[{"label": "Model", "value": "MT-HP099"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Speaker", "value": "φ50mm"}, {"label": "Mic unit diameter", "value": "φ6.0±2.7mm"}, {"label": "Sensitivity", "value": "118±3db"}, {"label": "Mic Sensitivity", "value": "-38±3db"}, {"label": "Impedance", "value": "32Ω±15%"}, {"label": "Frequency response", "value": "20~20,000Hz"}, {"label": "Color", "value": "BK+Gray/BK+Orange/WH+Gray"}, {"label": "Interface", "value": "Gold-plating USB"}, {"label": "Cable length", "value": "2.20±0.01m"}, {"label": "Weight", "value": "400±5g"}]'::jsonb,
  array['https://www.youtube.com/watch?v=U6SakeN8kkw', 'https://www.youtube.com/watch?v=rS-zod5-rKc']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp099');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP021 Gaming Headset',
  'Model: Meetion HP021

Connection: USB plus two 3.5mm plugs
Colour: Black
Warranty: 1-year limited warranty',
  3100, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp021-1.jpg',
  array['/products/meetion/hp021-1.jpg', '/products/meetion/hp021-2.jpg', '/products/meetion/hp021-3.jpg', '/products/meetion/hp021-4.jpg']::text[],
  'https://www.meetion.com/mt-hp021.html',
  'meetion-hp021',
  true,
  'Meetion',
  array['Interface: φ3.5mm stereo jack plus USB', 'Speaker: 120±3db', 'Microphone: 32Ω', 'Cable length: 2.20±0.01m', 'Weight: 395±5g', 'Dimensions: 206*93*226mm']::text[],
  '[{"label": "Name", "value": "MT-HP021"}, {"label": "Model No", "value": "φ50mm"}, {"label": "Speaker", "value": "120±3db"}, {"label": "Microphone", "value": "32Ω"}, {"label": "Impedance", "value": "20~20,000Hz"}, {"label": "Frequency Response", "value": "Omni-directional"}, {"label": "Mic Unit Diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "φ3.5mm stereo jack plus USB"}, {"label": "Cable length", "value": "2.20±0.01m"}, {"label": "Dimensions", "value": "206*93*226mm"}, {"label": "Weight", "value": "395±5g"}]'::jsonb,
  array['https://www.youtube.com/watch?v=LsbuIbQvG_I', 'https://www.youtube.com/watch?v=UEJanMPwrpU']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp021');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTH013 Tri-Mode Wireless Gaming Headset',
  'Model: Meetion BTH013

Connection: Type-C cable, 2.4G wireless and Bluetooth (tri-mode)
Warranty: 1-year limited warranty',
  9000, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/bth013-1.jpg',
  array['/products/meetion/bth013-1.jpg', '/products/meetion/bth013-2.jpg', '/products/meetion/bth013-3.jpg', '/products/meetion/bth013-4.jpg', '/products/meetion/bth013-5.jpg']::text[],
  'https://www.meetion.com/mt-bth013.html',
  'meetion-bth013',
  true,
  'Meetion',
  array['Wired + 2.4G + Bluetooth 5.3, Tri-mode, plug-and-play connection', 'Detachable noise-cancelling microphone', 'Rotatable ear cups', 'Adjustable headband 5.1200mAh battery, 40 hours of working time 6.Weight: 285g 7.USB + Type-C combo receiver 8.Speaker size: 50mm 9.Frequency response: 20 Hz - 20 kHz']::text[],
  '[{"label": "Model", "value": "MT-BTH013"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Speaker", "value": "φ50mm"}, {"label": "Noise Reduction", "value": "Call noise reduction"}, {"label": "Sensitivity", "value": "118±3dB"}, {"label": "Mic Sensitivity", "value": "-38±2db"}, {"label": "Impedance", "value": "32Ω±15%"}, {"label": "Battery", "value": "1200mAh"}, {"label": "Frequency response", "value": "20~20,000Hz"}, {"label": "Charging time", "value": "2-3hours"}, {"label": "Color", "value": "Silver white/Black gray"}, {"label": "Interface", "value": "Type-C"}, {"label": "Cable length", "value": "1.20±0.01m"}, {"label": "Weight", "value": "290±10g"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-bth013');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP030 7.1 USB Gaming Headset',
  'Model: Meetion HP030

Connection: USB cable
Warranty: 1-year limited warranty',
  4100, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp030-1.jpg',
  array['/products/meetion/hp030-1.jpg']::text[],
  'https://www.meetion.com/mt-hp030.html',
  'meetion-hp030',
  true,
  'Meetion',
  array['Interface: Gold-plating USB', 'Speaker: φ50mm', 'Microphone: Omni-directional', 'Cable length: 2.20±0.01m', 'Weight: 298±5g', 'Dimension: 200*115*220mm']::text[],
  '[{"label": "Model", "value": "MT-HP030"}, {"label": "Color", "value": "Black"}, {"label": "Speaker", "value": "φ50mm"}, {"label": "Dimension", "value": "200*115*220mm"}, {"label": "Sensitivity", "value": "120±3db"}, {"label": "Weight", "value": "298±5g"}, {"label": "Impedance", "value": "32Ω"}, {"label": "Frequency response", "value": "10~20,000Hz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-56±2db"}, {"label": "Interface", "value": "Gold-plating USB"}, {"label": "Cable length", "value": "2.20±0.01m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=M_eWI_2DXUY', 'https://www.youtube.com/watch?v=PIFGG1mf37s']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp030');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP020 Gaming Headset',
  'Model: Meetion HP020

Connection: USB plus two 3.5mm plugs
Warranty: 1-year limited warranty',
  3200, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp020-1.jpg',
  array['/products/meetion/hp020-1.jpg', '/products/meetion/hp020-2.jpg', '/products/meetion/hp020-3.jpg', '/products/meetion/hp020-4.jpg', '/products/meetion/hp020-5.jpg']::text[],
  'https://www.meetion.com/mt-hp020.html',
  'meetion-hp020',
  true,
  'Meetion',
  array['Interface: φ3.5mm stereo jack plus USB', 'Speaker: φ50mm', 'Microphone: Omni-directional', 'Cable length: 290±5g', 'Weight: 290±5g', 'Dimension: 185*110*210mm']::text[],
  '[{"label": "Model", "value": "MT-HP020"}, {"label": "Color", "value": "Black"}, {"label": "Speaker", "value": "φ50mm"}, {"label": "Dimension", "value": "185*110*210mm"}, {"label": "Sensitivity", "value": "120±3db"}, {"label": "Weight", "value": "290±5g"}, {"label": "Impedance", "value": "32Ω"}, {"label": "Frequency response", "value": "10~20,000Hz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "2.4±0.01m"}, {"label": "Interface", "value": "φ3.5mm stereo jack plus USB"}, {"label": "Cable length", "value": "290±5g"}]'::jsonb,
  array['https://www.youtube.com/watch?v=cRbmn8Dqmoo', 'https://www.youtube.com/watch?v=zkGH2d5Id6s']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp020');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP010 Wired Gaming Headset',
  'Model: Meetion HP010

Connection: Two 3.5mm plugs
Warranty: 1-year limited warranty',
  2200, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp010-1.jpg',
  array['/products/meetion/hp010-1.jpg']::text[],
  'https://www.meetion.com/mt-hp010.html',
  'meetion-hp010',
  true,
  'Meetion',
  array['Interface: Audio plug 3.5mm *2', 'Speaker: φ40mm', 'Microphone: Omni-directional', 'Cable length: 2.0±0.01m', 'Weight: 264±5g', 'Dimension: 250*88*75mm']::text[],
  '[{"label": "Model", "value": "MT-HP010"}, {"label": "Color", "value": "Black"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "250*88*75mm"}, {"label": "Sensitivity", "value": "120±3db"}, {"label": "Weight", "value": "264±5g"}, {"label": "Impedance", "value": "32Ω"}, {"label": "Frequency response", "value": "10~20,000Hz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-56±2db"}, {"label": "Interface", "value": "Audio plug 3.5mm *2"}, {"label": "Cable length", "value": "2.0±0.01m"}]'::jsonb,
  array['https://www.youtube.com/watch?v=T23gCRqLbXw', 'https://www.youtube.com/watch?v=Fj7GPmTTBXc']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp010');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MC20 Gaming Microphone',
  'Model: Meetion MC20

Connection: USB Type-C cable
Warranty: 1-year limited warranty',
  5900, 5,
  (select id from public.categories where slug = 'acc-microphones'),
  '/products/meetion/mc20-1.jpg',
  array['/products/meetion/mc20-1.jpg']::text[],
  'https://www.meetion.com/mt-mc20.html',
  'meetion-mc20',
  true,
  'Meetion',
  array['Interface: USB-Type-C', 'Cable length: 1.00±0.02m', 'Weight: 480±5g', 'Dimension: 156*59*52mm']::text[],
  '[{"label": "Model", "value": "MT-MC20"}, {"label": "Color", "value": "Black"}, {"label": "Drive unit", "value": "φ6mm*5mm"}, {"label": "Dimension", "value": "156*59*52mm"}, {"label": "Sensitivity Range", "value": "-45±3dB"}, {"label": "Weight", "value": "480±5g"}, {"label": "Impedance", "value": "2.2KΩ"}, {"label": "Frequency", "value": "40Hz-18000Hz"}, {"label": "Interface", "value": "USB-Type-C"}, {"label": "Cable length", "value": "1.00±0.02m"}, {"label": "Type", "value": "Capacitive"}, {"label": "Voltage", "value": "5V"}, {"label": "Electric current", "value": "120MA"}]'::jsonb,
  array['https://www.youtube.com/watch?v=F4xl4z9P74o', 'https://www.youtube.com/watch?v=LxRfy031YvM']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mc20');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion MC13 Desktop Microphone',
  'Model: Meetion MC13

Connection: USB Type-C cable
Warranty: 1-year limited warranty',
  2600, 5,
  (select id from public.categories where slug = 'acc-microphones'),
  '/products/meetion/mc13-1.jpg',
  array['/products/meetion/mc13-1.jpg']::text[],
  'https://www.meetion.com/mt-mc13.html',
  'meetion-mc13',
  true,
  'Meetion',
  array['Interface: USB', 'Cable length: 2.20±0.02m', 'Weight: 145±5g', 'Dimension: 295*91*75mm']::text[],
  '[{"label": "Model", "value": "MT-MC13"}, {"label": "Color", "value": "Black"}, {"label": "Drive unit", "value": "φ6mm*5mm"}, {"label": "Dimension", "value": "295*91*75mm"}, {"label": "Sensitivity Range", "value": "f=1kHz, Pin=1Pa -38±3dB Omnidirectional"}, {"label": "Weight", "value": "145±5g"}, {"label": "Impedance", "value": "2.2KΩ"}, {"label": "Frequency", "value": "50Hz-10000Hz"}, {"label": "Interface", "value": "USB"}, {"label": "Cable length", "value": "2.20±0.02m"}, {"label": "Type", "value": "Capacitive"}, {"label": "Voltage", "value": "5V"}, {"label": "Electric current", "value": "120MA"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mc13');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion SP2011 2.0 Gaming Speakers',
  'Model: Meetion SP2011

Connection: 3.5mm audio, USB powered
Warranty: 1-year limited warranty',
  2100, 5,
  (select id from public.categories where slug = 'acc-speakers'),
  '/products/meetion/sp2011-1.jpg',
  array['/products/meetion/sp2011-1.jpg', '/products/meetion/sp2011-2.jpg', '/products/meetion/sp2011-3.jpg', '/products/meetion/sp2011-4.jpg', '/products/meetion/sp2011-5.jpg']::text[],
  'https://www.meetion.com/mt-sp2011.html',
  'meetion-sp2011',
  true,
  'Meetion',
  array['2.0 stereo desktop speakers', '3W × 2 output', 'Volume control', 'USB powered (5V)']::text[],
  '[{"label": "Output (RMS)", "value": "3W × 2"}, {"label": "Drivers", "value": "2-inch × 2"}, {"label": "Frequency", "value": "150Hz – 20kHz"}, {"label": "Power input", "value": "DC 5V (USB)"}, {"label": "Size", "value": "67 × 79 × 98 mm"}, {"label": "Weight", "value": "0.35kg"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-sp2011');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion SP2111 2.1 Bluetooth Gaming Speakers',
  'Model: Meetion SP2111

Connection: Bluetooth and 3.5mm audio, USB powered
Warranty: 1-year limited warranty',
  5500, 5,
  (select id from public.categories where slug = 'acc-speakers'),
  '/products/meetion/sp2111-1.jpg',
  array['/products/meetion/sp2111-1.jpg', '/products/meetion/sp2111-2.jpg', '/products/meetion/sp2111-3.jpg', '/products/meetion/sp2111-4.jpg', '/products/meetion/sp2111-5.jpg']::text[],
  'https://www.meetion.com/mt-sp2111.html',
  'meetion-sp2111',
  true,
  'Meetion',
  array['2.1 speaker system with subwoofer', '5W + 3W × 2 output', 'Bluetooth and 3.5mm input', 'Volume control', 'USB powered (5V)']::text[],
  '[{"label": "Output (RMS)", "value": "5W + 3W × 2"}, {"label": "Drivers", "value": "3-inch + 2-inch × 2"}, {"label": "Frequency", "value": "150Hz – 20kHz"}, {"label": "Power input", "value": "DC 5V (USB)"}, {"label": "Subwoofer size", "value": "110 × 131 × 158 mm"}, {"label": "Satellite size", "value": "67 × 81 × 98 mm"}, {"label": "Weight", "value": "800g"}]'::jsonb,
  array['https://www.youtube.com/watch?v=PwOuE6hVwHY', 'https://www.youtube.com/watch?v=oo5GQvlBKY0']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-sp2111');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion SP2110 2.1 Bluetooth Speakers',
  'Model: Meetion SP2110

Connection: Bluetooth and 3.5mm audio, USB powered
Warranty: 1-year limited warranty',
  4200, 5,
  (select id from public.categories where slug = 'acc-speakers'),
  '/products/meetion/sp2110-1.jpg',
  array['/products/meetion/sp2110-1.jpg', '/products/meetion/sp2110-2.jpg', '/products/meetion/sp2110-3.jpg', '/products/meetion/sp2110-4.jpg', '/products/meetion/sp2110-5.jpg']::text[],
  'https://www.meetion.com/mt-sp2110.html',
  'meetion-sp2110',
  true,
  'Meetion',
  array['2.1 speaker system with subwoofer', '5W + 3W × 2 output', 'Bluetooth and 3.5mm input', 'Volume control', 'USB powered (5V)']::text[],
  '[{"label": "Output (RMS)", "value": "5W + 3W × 2"}, {"label": "Drivers", "value": "3-inch + 2-inch × 2"}, {"label": "Frequency", "value": "150Hz – 20kHz"}, {"label": "Power input", "value": "DC 5V (USB)"}, {"label": "Subwoofer size", "value": "130 × 96 × 107 mm"}, {"label": "Satellite size", "value": "78 × 57 × 67 mm"}, {"label": "Weight", "value": "600g"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-sp2110');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion SP2010 2.0 Desktop Speakers',
  'Model: Meetion SP2010

Connection: 3.5mm audio, USB powered
Warranty: 1-year limited warranty',
  1600, 5,
  (select id from public.categories where slug = 'acc-speakers'),
  '/products/meetion/sp2010-1.jpg',
  array['/products/meetion/sp2010-1.jpg', '/products/meetion/sp2010-2.jpg', '/products/meetion/sp2010-3.jpg', '/products/meetion/sp2010-4.jpg', '/products/meetion/sp2010-5.jpg']::text[],
  'https://www.meetion.com/mt-sp2010.html',
  'meetion-sp2010',
  true,
  'Meetion',
  array['2.0 stereo desktop speakers', '3W × 2 output', '3.5mm stereo jack, USB powered', '1.6m cable']::text[],
  '[{"label": "Output", "value": "3W × 2, 4Ω"}, {"label": "Signal-to-noise ratio", "value": "≥ 65dB"}, {"label": "Interface", "value": "3.5mm stereo jack + USB"}, {"label": "Cable length", "value": "1.60m"}, {"label": "Size", "value": "78 × 70 × 78 mm"}, {"label": "Weight", "value": "295g"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-sp2010');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CP2020 Laptop Cooling Pad',
  'Model: Meetion CP2020

Connection: USB cable
Warranty: 1-year limited warranty',
  2000, 5,
  (select id from public.categories where slug = 'acc-cooling-pads'),
  '/products/meetion/cp2020-1.jpg',
  array['/products/meetion/cp2020-1.jpg']::text[],
  'https://www.meetion.com/gaming-cooling-pad.html',
  'meetion-cp2020',
  true,
  'Meetion',
  array['Interface: USB*2', 'Cable length: 60±2cm', 'Compatibility: 9-14” laptop', 'Weight: 440±5g', 'Dimension: 340*265*32mm']::text[],
  '[{"label": "Model", "value": "CP2020"}, {"label": "Color", "value": "Black"}, {"label": "Operable angle", "value": "15 degree"}, {"label": "Dimension", "value": "340*265*32mm"}, {"label": "Power", "value": "4W"}, {"label": "Weight", "value": "440±5g"}, {"label": "Voltage and current", "value": "5V-≤800mA"}, {"label": "Interface", "value": "USB*2"}, {"label": "Compatibility", "value": "9-14” laptop"}, {"label": "Cable length", "value": "60±2cm"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cp2020');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CP3030 Laptop Cooling Pad',
  'Model: Meetion CP3030

Connection: USB cable
Warranty: 1-year limited warranty',
  3500, 5,
  (select id from public.categories where slug = 'acc-cooling-pads'),
  '/products/meetion/cp3030-1.jpg',
  array['/products/meetion/cp3030-1.jpg']::text[],
  'https://www.meetion.com/gaming-cooling-pad-1.html',
  'meetion-cp3030',
  true,
  'Meetion',
  array['Interface: USB*2', 'Cable length: 60±2cm', 'Compatibility: 9-15.6” laptops', 'Weight: 740±5g', 'Dimension: 370*265*32mm']::text[],
  '[{"label": "Model", "value": "CP3030"}, {"label": "Color", "value": "Black"}, {"label": "Operable angle", "value": "6.5-40 degree"}, {"label": "Dimension", "value": "370*265*32mm"}, {"label": "Power", "value": "4W-5W"}, {"label": "Weight", "value": "740±5g"}, {"label": "Voltage and current", "value": "5V-≤800mA"}, {"label": "Interface", "value": "USB*2"}, {"label": "Compatibility", "value": "9-15.6” laptops"}, {"label": "Cable length", "value": "60±2cm"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cp3030');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CP4040 Laptop Cooling Pad',
  'Model: Meetion CP4040

Connection: USB cable
Warranty: 1-year limited warranty',
  4600, 5,
  (select id from public.categories where slug = 'acc-cooling-pads'),
  '/products/meetion/cp4040-1.jpg',
  array['/products/meetion/cp4040-1.jpg']::text[],
  'https://www.meetion.com/gaming-cooling-pad-cp4040.html',
  'meetion-cp4040',
  true,
  'Meetion',
  array['Interface: USB*2', 'Cable length: 60±2cm', 'Compatibility: 9-17” laptops', 'Weight: 740±5g', 'Dimension: 370*265*32mm']::text[],
  '[{"label": "Model", "value": "CP4040"}, {"label": "Color", "value": "Black"}, {"label": "Operable angle", "value": "6.5-45 degree"}, {"label": "Dimension", "value": "370*265*32mm"}, {"label": "Power", "value": "4W-5W"}, {"label": "Weight", "value": "740±5g"}, {"label": "Voltage and current", "value": "5V-≤1000mA"}, {"label": "Interface", "value": "USB*2"}, {"label": "Compatibility", "value": "9-17” laptops"}, {"label": "Cable length", "value": "60±2cm"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cp4040');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CP5050 Laptop Cooling Pad',
  'Model: Meetion CP5050

Connection: USB cable
Warranty: 1-year limited warranty',
  5300, 5,
  (select id from public.categories where slug = 'acc-cooling-pads'),
  '/products/meetion/cp5050-1.jpg',
  array['/products/meetion/cp5050-1.jpg']::text[],
  'https://www.meetion.com/gaming-cooling-pad-cp5050.html',
  'meetion-cp5050',
  true,
  'Meetion',
  array['Interface: USB*2', 'Cable length: 60±2cm', 'Compatibility: 9-19” laptops', 'Weight: 1150±5g', 'Dimension: 400*288*36mm']::text[],
  '[{"label": "Model", "value": "CP5050"}, {"label": "Color", "value": "Black"}, {"label": "Operable angle", "value": "6.5-45 degree"}, {"label": "Dimension", "value": "400*288*36mm"}, {"label": "Power", "value": "5W"}, {"label": "Weight", "value": "1150±5g"}, {"label": "Voltage and current", "value": "5V-≤1000mA"}, {"label": "Interface", "value": "USB*2"}, {"label": "Compatibility", "value": "9-19” laptops"}, {"label": "Cable length", "value": "60±2cm"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cp5050');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion PD015 Mini Mouse Pad',
  'Model: Meetion PD015

Warranty: 1-year limited warranty',
  400, 5,
  (select id from public.categories where slug = 'acc-mouse-pads'),
  '/products/meetion/pd015-1.jpg',
  array['/products/meetion/pd015-1.jpg', '/products/meetion/pd015-2.jpg']::text[],
  'https://www.meetion.com/soft-rubber-gaming-mouse-pad.html',
  'meetion-pd015',
  true,
  'Meetion',
  array['Soft cloth surface', 'Non-slip rubber base', 'Mini size: 250 × 190 mm', '3mm thick']::text[],
  '[{"label": "Model", "value": "MT-PD015"}, {"label": "Color", "value": "Black"}, {"label": "Materials", "value": "Rubber base and fabric surface"}, {"label": "Dimension", "value": "250*190*3mm"}, {"label": "Weight", "value": "114±5g"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-pd015');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion P100 Extended Gaming Mouse Pad',
  'Model: Meetion P100

Warranty: 1-year limited warranty',
  1200, 5,
  (select id from public.categories where slug = 'acc-mouse-pads'),
  '/products/meetion/p100-1.jpg',
  array['/products/meetion/p100-1.jpg']::text[],
  'https://www.meetion.com/mt-p100.html',
  'meetion-p100',
  true,
  'Meetion',
  array['Weight: 650±5g', 'Dimension: 790*345*5mm', 'Materials: Rubber base and fabric surface']::text[],
  '[{"label": "Model", "value": "MT-P100"}, {"label": "Color", "value": "Black"}, {"label": "Materials", "value": "Rubber base and fabric surface"}, {"label": "Dimension", "value": "790*345*5mm"}, {"label": "Weight", "value": "650±5g"}]'::jsonb,
  array['https://www.youtube.com/watch?v=WCS1jGuVMmk']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-p100');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion PD120 RGB Gaming Mouse Pad',
  'Model: Meetion PD120

Connection: Micro-USB (powers the lighting)
Warranty: 1-year limited warranty',
  1800, 5,
  (select id from public.categories where slug = 'acc-mouse-pads'),
  '/products/meetion/pd120-1.jpg',
  array['/products/meetion/pd120-1.jpg']::text[],
  'https://www.meetion.com/mt-pd120.html',
  'meetion-pd120',
  true,
  'Meetion',
  array['Interface: USB - Micro USB', 'Weight: 200±5g', 'Dimension: 355*265*4mm', 'Materials: rubber+fibre']::text[],
  '[{"label": "Model", "value": "MT-PD120"}, {"label": "Color", "value": "Black"}, {"label": "Light chip", "value": "RGB LED"}, {"label": "Dimension", "value": "355*265*4mm"}, {"label": "Input", "value": "DC5V-150mA (max.)"}, {"label": "Weight", "value": "200±5g"}, {"label": "Materials", "value": "rubber+fibre"}, {"label": "Interface", "value": "USB - Micro USB"}]'::jsonb,
  array['https://www.youtube.com/watch?v=K_Yo5k9xq3s']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-pd120');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion PD121 Large RGB Gaming Mouse Pad',
  'Model: Meetion PD121

Connection: Micro-USB (powers the lighting)
Warranty: 1-year limited warranty',
  2300, 5,
  (select id from public.categories where slug = 'acc-mouse-pads'),
  '/products/meetion/pd121-1.jpg',
  array['/products/meetion/pd121-1.jpg']::text[],
  'https://www.meetion.com/mt-pd121.html',
  'meetion-pd121',
  true,
  'Meetion',
  array['Interface: USB - Micro USB', 'Weight: 595±5g', 'Dimension: 880*310*4mm', 'Materials: rubber+fibre']::text[],
  '[{"label": "Model", "value": "MT-PD121"}, {"label": "Color", "value": "Black"}, {"label": "Light chip", "value": "RGB LED"}, {"label": "Dimension", "value": "880*310*4mm"}, {"label": "Input", "value": "DC5V-150mA (max.)"}, {"label": "Weight", "value": "595±5g"}, {"label": "Materials", "value": "rubber+fibre"}, {"label": "Interface", "value": "USB - Micro USB"}]'::jsonb,
  array['https://www.youtube.com/watch?v=1cwdBM173_k', 'https://www.youtube.com/watch?v=3tRmPBHd-Po']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-pd121');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP003 3.5mm Office Headset',
  'Model: Meetion HP003

Connection: 3.5mm plug
Colour: Black
Warranty: 1-year limited warranty',
  2000, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp003-1.jpg',
  array['/products/meetion/hp003-1.jpg', '/products/meetion/hp003-2.jpg', '/products/meetion/hp003-3.jpg', '/products/meetion/hp003-4.jpg', '/products/meetion/hp003-5.jpg']::text[],
  'https://www.meetion.com/mt-hp003.html',
  'meetion-hp003',
  true,
  'Meetion',
  array['Interface: 3.5mm', 'Speaker: φ40mm', 'Microphone: Omni-directional', 'Length: 1.20±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 195±2g']::text[],
  '[{"label": "Model", "value": "MT-HP003"}, {"label": "Color", "value": "Black\\White"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "170*70*180mm"}, {"label": "Sensitivity", "value": "116±3db"}, {"label": "Weight", "value": "195±2g"}, {"label": "Impedance", "value": "32±15%Ω"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Frequency response", "value": "20~20KHz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "3.5mm"}, {"label": "Length", "value": "1.20±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp003');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTH003MIC Bluetooth Headset with Mic',
  'Model: Meetion BTH003MIC

Connection: Bluetooth
Warranty: 1-year limited warranty',
  2800, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/bth003mic-1.jpg',
  array['/products/meetion/bth003mic-1.jpg', '/products/meetion/bth003mic-2.jpg', '/products/meetion/bth003mic-3.jpg', '/products/meetion/bth003mic-4.jpg', '/products/meetion/bth003mic-5.jpg']::text[],
  'https://www.meetion.com/mt-bth003.html',
  'meetion-bth003mic',
  true,
  'Meetion',
  array['Interface: TYPE-C', 'Speaker: φ40mm', 'Microphone: Omni-directional', 'Length: 1.20±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 180±2g']::text[],
  '[{"label": "Model", "value": "MT-BTH003"}, {"label": "Color", "value": "Black\\White"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "170*70*180mm"}, {"label": "Sensitivity", "value": "116±3db"}, {"label": "Weight", "value": "180±2g"}, {"label": "Impedance", "value": "32±15%Ω"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Frequency response", "value": "20~20KHz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "TYPE-C"}, {"label": "Length", "value": "1.20±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-bth003mic');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP003U USB Office Headset',
  'Model: Meetion HP003U

Connection: USB cable
Warranty: 1-year limited warranty',
  2300, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp003u-1.jpg',
  array['/products/meetion/hp003u-1.jpg', '/products/meetion/hp003u-white.jpg', '/products/meetion/hp003u-2.jpg', '/products/meetion/hp003u-3.jpg', '/products/meetion/hp003u-4.jpg', '/products/meetion/hp003u-5.jpg']::text[],
  'https://www.meetion.com/mt-hp003u.html',
  'meetion-hp003u',
  true,
  'Meetion',
  array['Interface: USB', 'Speaker: φ40mm', 'Microphone: Omni-directional', 'Length: 1.20±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 200±2g']::text[],
  '[{"label": "Model", "value": "MT-HP003U"}, {"label": "Color", "value": "Black\\White"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "170*70*180mm"}, {"label": "Sensitivity", "value": "116±3db"}, {"label": "Weight", "value": "200±2g"}, {"label": "Impedance", "value": "32±15%Ω"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Frequency response", "value": "20~20KHz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "USB"}, {"label": "Length", "value": "1.20±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "hp003u-black", "color": "Black", "price": 2300, "image": "/products/meetion/hp003u-1.jpg"}, {"id": "hp003u-white", "color": "White", "price": 2300, "image": "/products/meetion/hp003u-white.jpg"}], "defaultOptionId": "hp003u-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp003u');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP002 3.5mm Call Center Headset',
  'Model: Meetion HP002

Connection: 3.5mm plug
Warranty: 1-year limited warranty',
  1900, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp002-1.jpg',
  array['/products/meetion/hp002-1.jpg', '/products/meetion/hp002-white.jpg', '/products/meetion/hp002-2.jpg', '/products/meetion/hp002-3.jpg', '/products/meetion/hp002-4.jpg', '/products/meetion/hp002-5.jpg']::text[],
  'https://www.meetion.com/mt-hp002.html',
  'meetion-hp002',
  true,
  'Meetion',
  array['Interface: 3.5mm', 'Speaker: φ40mm', 'Microphone: Omni-directional', 'Length: 1.20±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 155±2g']::text[],
  '[{"label": "Model", "value": "MT-HP002"}, {"label": "Color", "value": "Black\\White"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "170*70*180mm"}, {"label": "Sensitivity", "value": "116±3db"}, {"label": "Weight", "value": "155±2g"}, {"label": "Impedance", "value": "32±15%Ω"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Frequency response", "value": "20~20KHz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "3.5mm"}, {"label": "Length", "value": "1.20±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "hp002-black", "color": "Black", "price": 1900, "image": "/products/meetion/hp002-1.jpg"}, {"id": "hp002-white", "color": "White", "price": 1900, "image": "/products/meetion/hp002-white.jpg"}], "defaultOptionId": "hp002-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp002');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion HP002U USB Call Center Headset',
  'Model: Meetion HP002U

Connection: USB cable
Warranty: 1-year limited warranty',
  2300, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/hp002u-1.jpg',
  array['/products/meetion/hp002u-1.jpg', '/products/meetion/hp002u-2.jpg', '/products/meetion/hp002u-3.jpg', '/products/meetion/hp002u-4.jpg', '/products/meetion/hp002u-5.jpg']::text[],
  'https://www.meetion.com/usb-single-ear-headset-1724642816369438.html',
  'meetion-hp002u',
  true,
  'Meetion',
  array['Single-ear call-centre headset', 'USB plug, 1.8m cable', 'Omni-directional microphone', 'Lightweight: 135g']::text[],
  '[{"label": "Model", "value": "MT-HP002U"}, {"label": "Color", "value": "Black\\White"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "170*70*180mm"}, {"label": "Sensitivity", "value": "116±3db"}, {"label": "Weight", "value": "155±2g"}, {"label": "Impedance", "value": "32±15%Ω"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Frequency response", "value": "20~20KHz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "USB"}, {"label": "Length", "value": "1.20±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "hp002u-black", "color": "Black", "price": 2300}, {"id": "hp002u-white", "color": "White", "price": 2300}], "defaultOptionId": "hp002u-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-hp002u');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTH002 Bluetooth Call Center Headset',
  'Model: Meetion BTH002

Connection: Bluetooth
Colour: White + Grey
Warranty: 1-year limited warranty',
  2700, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/bth002-1.jpg',
  array['/products/meetion/bth002-1.jpg', '/products/meetion/bth002-2.jpg', '/products/meetion/bth002-3.jpg', '/products/meetion/bth002-4.jpg', '/products/meetion/bth002-5.jpg']::text[],
  'https://www.meetion.com/mt-bth002/white.html',
  'meetion-bth002',
  true,
  'Meetion',
  array['Interface: TYPE-C', 'Speaker: φ40mm', 'Microphone: Omni-directional', 'Length: 1.20±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 135±2g']::text[],
  '[{"label": "Model", "value": "MT-BTH002"}, {"label": "Color", "value": "Black\\White"}, {"label": "Speaker", "value": "φ40mm"}, {"label": "Dimension", "value": "170*70*180mm"}, {"label": "Sensitivity", "value": "116±3db"}, {"label": "Weight", "value": "135±2g"}, {"label": "Impedance", "value": "32±15%Ω"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Frequency response", "value": "20~20KHz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic Sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "TYPE-C"}, {"label": "Length", "value": "1.20±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-bth002');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTH003 Bluetooth Headset',
  'Model: Meetion BTH003

Connection: USB cable
Warranty: 1-year limited warranty',
  2800, 5,
  (select id from public.categories where slug = 'acc-headsets'),
  '/products/meetion/bth003-1.jpg',
  array['/products/meetion/bth003-1.jpg', '/products/meetion/bth003-white.jpg', '/products/meetion/bth003-2.jpg', '/products/meetion/bth003-3.jpg', '/products/meetion/bth003-4.jpg', '/products/meetion/bth003-5.jpg']::text[],
  null,
  'meetion-bth003',
  true,
  'Meetion',
  array['40mm speakers', 'Omni-directional microphone', 'Lightweight: 135g']::text[],
  '[{"label": "Speaker", "value": "40mm, 32Ω ±15%, 116 ±3dB, 20Hz – 20kHz"}, {"label": "Microphone", "value": "Omni-directional, 6.0mm, −35 ±3dB"}, {"label": "Size", "value": "170 × 70 × 180 mm"}, {"label": "Weight", "value": "135g"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "bth003-black", "color": "Black", "price": 2800, "image": "/products/meetion/bth003-1.jpg"}, {"id": "bth003-white", "color": "White", "price": 2800, "image": "/products/meetion/bth003-white.jpg"}], "defaultOptionId": "bth003-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-bth003');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion C235 Wired Keyboard & Mouse Combo',
  'Model: Meetion C235

Connection: USB cable
Warranty: 1-year limited warranty',
  1900, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/c235-1.jpg',
  array['/products/meetion/c235-1.jpg', '/products/meetion/c235-2.jpg', '/products/meetion/c235-3.jpg', '/products/meetion/c235-4.jpg', '/products/meetion/c235-5.jpg']::text[],
  'https://www.meetion.com/mt-c235.html',
  'meetion-c235',
  true,
  'Meetion',
  array['Resolution: 1200 DPI', 'Backlight: None', 'No. of keys: Keyboard：104 Mouse：3', 'Interface: USB', 'Cable Length: 1.5m', 'Compatible systems: Win XP/Vista/7/8/10/11 MAC OS']::text[],
  '[{"label": "Model", "value": "C235"}, {"label": "Color", "value": "Black"}, {"label": "Backlight", "value": "None"}, {"label": "Dimension", "value": "515*152*43mm"}, {"label": "Type", "value": "Wired"}, {"label": "Weight", "value": "Keyboard：415g Mouse：60g"}, {"label": "No. of keys", "value": "Keyboard：104 Mouse：3"}, {"label": "Key life", "value": "Keyboard：10 million times Mouse：3 million times"}, {"label": "Resolution", "value": "1200 DPI"}, {"label": "Cable Length", "value": "1.5m"}, {"label": "Interface", "value": "USB"}, {"label": "Compatible systems", "value": "Win XP/Vista/7/8/10/11 MAC OS"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-c235');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion K200 USB Keyboard',
  'Model: Meetion K200

Connection: USB cable
Warranty: 1-year limited warranty',
  1300, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/k200-1.jpg',
  array['/products/meetion/k200-1.jpg', '/products/meetion/k200-2.jpg', '/products/meetion/k200-3.jpg', '/products/meetion/k200-4.jpg', '/products/meetion/k200-5.jpg']::text[],
  'https://www.meetion.com/standard-usb-chocolate-keyboard.html',
  'meetion-k200',
  true,
  'Meetion',
  array['Interface: USB', 'Cable length: 1.80±0.01m', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 415±5g', 'Dimension: 445*139*25mm']::text[],
  '[{"label": "Model", "value": "MT-K200"}, {"label": "Color", "value": "Black"}, {"label": "Cable length", "value": "1.80±0.01m"}, {"label": "Dimension", "value": "445*139*25mm"}, {"label": "No.of keys", "value": "104/105"}, {"label": "Weight", "value": "415±5g"}, {"label": "Interface", "value": "USB"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}]'::jsonb,
  array['https://www.youtube.com/watch?v=Nfu5NscVxTc']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-k200');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CW295 Wireless Keyboard & Mouse Combo',
  'Model: Meetion CW295

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  3300, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/cw295-1.jpg',
  array['/products/meetion/cw295-1.jpg', '/products/meetion/cw295-2.jpg', '/products/meetion/cw295-3.jpg', '/products/meetion/cw295-4.jpg', '/products/meetion/cw295-5.jpg']::text[],
  'https://www.meetion.com/cw295.html',
  'meetion-cw295',
  true,
  'Meetion',
  array['Battery-Powered 2.4G Wireless Keyboard and Mouse Office Combo', 'Made of ABS Material', 'Full-Size Keyboard and Ergonomic Ambidextrous Mouse', 'Includes: 1 AA Battery, 1 AAA Battery, 2 Sets of Feet Pads, and a User Manual']::text[],
  '[{"label": "Product name", "value": "CW295"}, {"label": "Battery", "value": "Keyboard: 1*AAA Mouse: 1*AA"}, {"label": "Model", "value": "CW295"}, {"label": "Charging time", "value": "None"}, {"label": "Number of keys", "value": "Keyboard: 112 keys Mouse: 4 buttons"}, {"label": "Battery life", "value": "Keyboard: About 800h Mouse: About 250h"}, {"label": "Connection method", "value": "2.4G Wireless"}, {"label": "Key function", "value": "Support multimedia function keys"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "WindowsXP/Vista/7/8/10/11/MAC"}, {"label": "Interface", "value": "2.4G-USB"}, {"label": "Weight", "value": "Keyboard: 420±20g Mouse: 62.5g"}, {"label": "Mouse DPI", "value": "800-1200-2400-3200"}, {"label": "Size", "value": "Keyboard: 444*145*25mm Mouse: 106*63*39mm"}, {"label": "Color", "value": "Black"}, {"label": "Switch lifespan", "value": "Keyboard: 5 Million Mouse: 3 Million"}, {"label": "Operation Temperature", "value": "Keyboard: 10~35℃ Mouse: 0~40°C"}, {"label": "Storage Temperature", "value": "Keyboard: -20~+40℃ Mouse: -20~+60°C"}]'::jsonb,
  array['https://www.meetion.com/lifisher-m0/1773739276767-20250827cw295-product-displaymp4.mp4']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cw295');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CW235 Wireless Keyboard & Mouse Combo',
  'Model: Meetion CW235

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  2800, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/cw235-1.jpg',
  array['/products/meetion/cw235-1.jpg', '/products/meetion/cw235-2.jpg', '/products/meetion/cw235-3.jpg', '/products/meetion/cw235-4.jpg', '/products/meetion/cw235-5.jpg']::text[],
  'https://www.meetion.com/wireless-combo-cw235.html',
  'meetion-cw235',
  true,
  'Meetion',
  array['Battery-Powered 2.4G Wireless Keyboard and Mouse Office Combo', 'Made of ABS Material', 'Full-Size Keyboard and Ergonomic Ambidextrous Mouse', 'Includes: 1 AA Battery, 1 AAA Battery, 2 Sets of Feet Pads, and a User Manual']::text[],
  '[{"label": "Product name", "value": "MT- CW235"}, {"label": "Battery", "value": "Keyboard: AAA*1 Mouse: AA*1"}, {"label": "Model", "value": "CW235"}, {"label": "Charging time", "value": "None"}, {"label": "Number of keys", "value": "Keyboard: 104 keys Mouse: 3 Buttons"}, {"label": "Working time", "value": "Keyboard: About 480H Mouse: About 100H"}, {"label": "Connection method", "value": "2.4G Wireless"}, {"label": "Multi-media Keys", "value": "Yes"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "Win XP/7/8/10/11, Vista, MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Weight", "value": "Keyboard: 383±5g Mouse: 45±5g"}, {"label": "Keyboar type", "value": "Membrane"}, {"label": "Size", "value": "Keyboard: 450*135*25mm Mouse: 105*60*40mm"}, {"label": "Color", "value": "Black"}, {"label": "DPI", "value": "1200"}, {"label": "Storage Temperature", "value": "-20~60°"}, {"label": "Operation Temperature", "value": "0~40°"}]'::jsonb,
  array['https://www.meetion.com/lifisher-m0/1773740422006-20250901cw235product-displaymp4.mp4']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cw235');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CW216 Wireless Keyboard & Mouse Combo',
  'Model: Meetion CW216

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  3700, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/cw216-1.jpg',
  array['/products/meetion/cw216-1.jpg', '/products/meetion/cw216-2.jpg', '/products/meetion/cw216-3.jpg', '/products/meetion/cw216-4.jpg', '/products/meetion/cw216-5.jpg']::text[],
  'https://www.meetion.com/cw216.html',
  'meetion-cw216',
  true,
  'Meetion',
  array['Battery-Powered 2.4G Wireless Keyboard and Mouse Office Combo', 'Made of ABS Material', 'Full-Size Keyboard and Ergonomic Ambidextrous Mouse', 'Includes: 1 AA Battery, 1 AAA Battery, 2 Sets of Feet Pads, and a User Manual']::text[],
  '[{"label": "Product name", "value": "MT-CW216"}, {"label": "Battery", "value": "Keybooard: AAA*2 Mouse: AA*1"}, {"label": "Model", "value": "CW216"}, {"label": "Working Time", "value": "Keybaord: About 1200H Mouse: About 250H"}, {"label": "Number of keys", "value": "Keyboard: 105 keys Mouse: 4 keys"}, {"label": "Weight", "value": "Keyboard: 380±5g Mouse: 64.2g ±5 g"}, {"label": "Connection method", "value": "2.4G"}, {"label": "Size", "value": "Keyboard: 438*126*28mm Mouse: 107*63*40mm"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "WIN7/8/10/11/Vista/MacOS"}, {"label": "Keyboard Type", "value": "Membrane"}, {"label": "Multimedia Keys", "value": "Yes"}, {"label": "Color", "value": "Black"}, {"label": "Keyboard Tilt Angle", "value": "6°"}, {"label": "Storage Temperature", "value": "-20° to 60°"}, {"label": "Working Temperature", "value": "0-40°"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-cw216');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion iKey K210 Slim Multi-Device Wireless Keyboard',
  'Model: Meetion iKey K210

Connection: 2.4G wireless plus 3 Bluetooth channels
Warranty: 1-year limited warranty',
  4800, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/ikey-k210-1.jpg',
  array['/products/meetion/ikey-k210-1.jpg', '/products/meetion/ikey-k210-2.jpg', '/products/meetion/ikey-k210-3.jpg', '/products/meetion/ikey-k210-4.jpg', '/products/meetion/ikey-k210-5.jpg']::text[],
  'https://www.meetion.com/mt-k210.html',
  'meetion-ikey-k210',
  true,
  'Meetion',
  array['ABS Plastic', 'Scissor structure keyboard', 'Battery capacity 300mAh 4.78 keys 5.Compatible with Mac/Win system 6.Apple keyboard layout']::text[],
  '[{"label": "Product name", "value": "iKey Apple Series"}, {"label": "Battery", "value": "300mAh"}, {"label": "Model", "value": "K210"}, {"label": "Charging time", "value": "About 2-3H"}, {"label": "Number of keys", "value": "78 keys"}, {"label": "Battery life", "value": "About 150H"}, {"label": "Connection method", "value": "2.4G + Bluetooth three channels"}, {"label": "Key function", "value": "Support multimedia function keys"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "Support Mac/iOs/Win/Android four systems"}, {"label": "Interface", "value": "Type-C"}, {"label": "Weight", "value": "378±5g"}, {"label": "Keys", "value": "Silent scissor feet"}, {"label": "Size", "value": "282*117*11mm"}, {"label": "Color", "value": "Black grey/Rose gold/Silver white/Purple"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-ikey-k210');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion iKey K230 Slim Rechargeable Wireless Keyboard',
  'Model: Meetion iKey K230

Connection: 2.4G wireless plus 3 Bluetooth channels
Warranty: 1-year limited warranty',
  6100, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/ikey-k230-1.jpg',
  array['/products/meetion/ikey-k230-1.jpg', '/products/meetion/ikey-k230-2.jpg', '/products/meetion/ikey-k230-3.jpg', '/products/meetion/ikey-k230-4.jpg', '/products/meetion/ikey-k230-5.jpg']::text[],
  'https://www.meetion.com/mt-k230.html',
  'meetion-ikey-k230',
  true,
  'Meetion',
  array['ABS Plastic', 'Scissor structure keyboard', 'Battery capacity 300mAh 4.108 keys 5.Compatible with Mac/Win system 6. Apple keyboard layout']::text[],
  '[{"label": "Model", "value": "iKey K230"}, {"label": "Color", "value": "Black grey/Rose gold/Silver white/Purple"}, {"label": "Type", "value": "2.4GHz & Bluetooth Dual Mode"}, {"label": "Dimension", "value": "421*117*12mm"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Weight", "value": "563±5g"}, {"label": "No. of Keys", "value": "109 Keys"}, {"label": "Compatible Systems", "value": "Support Mac/iOS/Win/Android four system!"}, {"label": "Keys", "value": "Silent scissor feet"}, {"label": "Interface", "value": "Type-C"}, {"label": "Battry", "value": "300mAH"}, {"label": "Charging time", "value": "About 2-3H"}, {"label": "Battery life", "value": "About 150H"}, {"label": "Key function", "value": "Support multimedia function keys"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["White", "Black"]}, "options": [{"id": "ikey-k230-white", "color": "White", "price": 6100, "image": "/products/meetion/ikey-k230-1.jpg"}, {"id": "ikey-k230-black", "color": "Black", "price": 6100}], "defaultOptionId": "ikey-k230-white"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-ikey-k230');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion Director W Ergonomic Wireless Keyboard',
  'Model: Meetion Director W

Connection: 2.4G wireless (USB receiver)
Colour: Black
Warranty: 1-year limited warranty',
  7200, 5,
  (select id from public.categories where slug = 'acc-keyboards'),
  '/products/meetion/directorwe-1.jpg',
  array['/products/meetion/directorwe-1.jpg', '/products/meetion/directorwe-2.jpg', '/products/meetion/directorwe-3.jpg']::text[],
  'https://www.meetion.com/wireless-ergonomic-keyboard.html',
  'meetion-directorwe',
  true,
  'Meetion',
  array['Ergonomic split-curve design for long hours of typing', 'Suited to designers, engineers and programmers', 'Low-power 2.4G wireless', '2 × AAA batteries included']::text[],
  '[{"label": "Material", "value": "ABS plastic"}, {"label": "Size", "value": "485 × 255 × 47 mm"}, {"label": "Power", "value": "2 × AAA batteries (included)"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-directorwe');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion iKey C210 Slim Wireless Keyboard & Mouse Combo',
  'Model: Meetion iKey C210

Connection: 2.4G wireless plus 3 Bluetooth channels
Warranty: 1-year limited warranty',
  6700, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/ikey-c210-1.jpg',
  array['/products/meetion/ikey-c210-1.jpg', '/products/meetion/ikey-c210-2.jpg', '/products/meetion/ikey-c210-3.jpg', '/products/meetion/ikey-c210-4.jpg', '/products/meetion/ikey-c210-5.jpg']::text[],
  'https://www.meetion.com/mt-c210.html',
  'meetion-ikey-c210',
  true,
  'Meetion',
  array['Slim keyboard and mouse set', 'Scissor-switch keyboard, 78 keys, Apple-style layout', 'Works with Mac and Windows', '2.4G wireless plus three Bluetooth channels on both keyboard and mouse', 'Rechargeable: 300mAh battery in each']::text[],
  '[{"label": "Model", "value": "iKey C210"}, {"label": "Set", "value": "Keyboard + mouse"}, {"label": "Keyboard type", "value": "Scissor structure, 78 keys, Apple-style layout"}, {"label": "Connection", "value": "2.4G wireless + 3 Bluetooth channels (keyboard and mouse)"}, {"label": "Keyboard battery", "value": "300mAh rechargeable"}, {"label": "Mouse battery", "value": "300mAh rechargeable"}, {"label": "Compatible systems", "value": "Mac / Windows"}, {"label": "Material", "value": "ABS plastic"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Silver", "Black"]}, "options": [{"id": "ikey-c210-silver", "color": "Silver", "price": 6700, "image": "/products/meetion/ikey-c210-1.jpg"}, {"id": "ikey-c210-black", "color": "Black", "price": 6700}], "defaultOptionId": "ikey-c210-silver"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-ikey-c210');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion iKey C230 Slim Wireless Keyboard & Mouse Combo',
  'Model: Meetion iKey C230

Connection: 2.4G wireless plus 3 Bluetooth channels
Warranty: 1-year limited warranty',
  7800, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/ikey-c230-1.jpg',
  array['/products/meetion/ikey-c230-1.jpg', '/products/meetion/ikey-c230-2.jpg', '/products/meetion/ikey-c230-3.jpg', '/products/meetion/ikey-c230-4.jpg', '/products/meetion/ikey-c230-5.jpg']::text[],
  'https://www.meetion.com/mt-c230.html',
  'meetion-ikey-c230',
  true,
  'Meetion',
  array['Key function: Support multimedia function keys', 'Number of keys: 109 keys', 'Connection method: 2.4G + Bluetooth three channels', 'Transmission distance: 10m', 'Battery: 300mAh', 'Charging time: About 2-3H']::text[],
  '[{"label": "Model", "value": "C230"}, {"label": "Model", "value": "﻿C210"}, {"label": "Number of keys", "value": "109 keys"}, {"label": "Number of keys", "value": "78 keys"}, {"label": "Color", "value": "Black grey/Rose gold/Silver white/Purple"}, {"label": "Color", "value": "Black grey/Rose gold/Silver white/Purple"}, {"label": "Connection method", "value": "2.4G + Bluetooth three channels"}, {"label": "Connection method", "value": "2.4G + Bluetooth three channels"}, {"label": "Transmission distance", "value": "10m"}, {"label": "Transmission distance", "value": "10m"}, {"label": "Interface", "value": "Type-C"}, {"label": "Interface", "value": "Type-C"}, {"label": "Keys", "value": "Silent scissor feet"}, {"label": "Keys", "value": "Silent scissor feet"}, {"label": "Battery", "value": "300mAh"}, {"label": "Battery", "value": "300mAh"}, {"label": "Charging time", "value": "About 2-3H"}, {"label": "Charging time", "value": "About 2-3H"}, {"label": "Battery life", "value": "About 150H"}, {"label": "Battery life", "value": "About 150H"}, {"label": "Key function", "value": "Support multimedia function keys"}, {"label": "Key function", "value": "Support multimedia function keys"}, {"label": "System compatibility", "value": "Support Mac/iOs/Win/Android four systems"}, {"label": "System compatibility", "value": "Support Mac/iOs/Win/Android four systems"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Silver", "Black"]}, "options": [{"id": "ikey-c230-silver", "color": "Silver", "price": 7800, "image": "/products/meetion/ikey-c230-1.jpg"}, {"id": "ikey-c230-black", "color": "Black", "price": 7800}], "defaultOptionId": "ikey-c230-silver"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-ikey-c230');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion C4120 Wireless Keyboard & Mouse Combo',
  'Model: Meetion C4120

Connection: 2.4G wireless (USB receiver)
Colour: Black
Warranty: 1-year limited warranty',
  3100, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/c4120-little-1.jpg',
  array['/products/meetion/c4120-little-1.jpg', '/products/meetion/c4120-little-2.jpg', '/products/meetion/c4120-little-3.jpg', '/products/meetion/c4120-little-4.jpg', '/products/meetion/c4120-little-5.jpg']::text[],
  'https://www.meetion.com/2-4-ghz-wireless-combo-c4120-little.html',
  'meetion-c4120-little',
  true,
  'Meetion',
  array['Resolution: 800/1200/1600 DPI', 'Interface: USB Nano receiver', 'Battery: AAA*1', 'Compatible Systems: Win XP/Vista/7/8/10/11/MAC OS', 'Weight: 415±5g', 'Dimension: 433*133*23.5mm']::text[],
  '[{"label": "No.of keys", "value": "104/105"}, {"label": "Mouse Type", "value": "2.4GHz Wireless"}, {"label": "Battery", "value": "AAA*1"}, {"label": "No. of keys", "value": "4"}, {"label": "Interface", "value": "USB Nano receiver"}, {"label": "Resolution", "value": "800/1200/1600 DPI"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}, {"label": "Battery", "value": "AA*1"}, {"label": "Dimension", "value": "433*133*23.5mm"}, {"label": "Interface", "value": "USB Nano receiver"}, {"label": "Weight", "value": "415±5g"}, {"label": "Dimension", "value": "110 * 60 * 37mm"}, {"label": "Weight", "value": "60±2g"}]'::jsonb,
  array['https://www.youtube.com/watch?v=Ry7dgQvmY7s', 'https://www.youtube.com/watch?v=7PZwgj6V-BY']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-c4120-little');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion Director B2 Ergonomic Wireless Keyboard & Mouse Combo',
  'Model: Meetion Director B2

Connection: 2.4G wireless plus 2 Bluetooth channels
Colour: Black
Warranty: 1-year limited warranty',
  8000, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/directorb2-1.jpg',
  array['/products/meetion/directorb2-1.jpg', '/products/meetion/directorb2-2.jpg', '/products/meetion/directorb2-3.jpg', '/products/meetion/directorb2-4.jpg', '/products/meetion/directorb2-5.jpg']::text[],
  'https://www.meetion.com/mt-directorc2.html',
  'meetion-directorb2',
  true,
  'Meetion',
  array['Ergonomic keyboard and mouse set for long hours of use', 'Suited to designers, engineers and programmers', 'Bluetooth plus low-power 2.4G wireless', 'Built-in rechargeable lithium battery', 'Type-C charging cable included']::text[],
  '[{"label": "Model", "value": "Director B2"}, {"label": "Set", "value": "Ergonomic keyboard + mouse"}, {"label": "Connection", "value": "Bluetooth + low-power 2.4G wireless"}, {"label": "Battery", "value": "Built-in rechargeable lithium battery"}, {"label": "Charging", "value": "USB Type-C (cable included)"}]'::jsonb,
  array['https://www.youtube.com/watch?v=hhpm8U-tWF4']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-directorb2');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion Mini5000 Mini Wireless Keyboard & Mouse Combo',
  'Model: Meetion Mini5000

Connection: 2.4G wireless and Bluetooth
Warranty: 1-year limited warranty',
  3700, 5,
  (select id from public.categories where slug = 'acc-combos'),
  '/products/meetion/mini5000-1.jpg',
  array['/products/meetion/mini5000-1.jpg', '/products/meetion/mini5000-2.jpg', '/products/meetion/mini5000-3.jpg', '/products/meetion/mini5000-4.jpg', '/products/meetion/mini5000-5.jpg']::text[],
  'https://www.meetion.com/mt-mini5000.html',
  'meetion-mini5000',
  true,
  'Meetion',
  array['Battery-Powered Dual-Mode Wireless Keyboard and Mouse Combo', 'Made of ABS Material 3.75% Keyboard 4.Includes: 1 AA Battery, 1 AAA Battery and a User Manual']::text[],
  '[{"label": "Product name", "value": "MT- Mini 5000"}, {"label": "Battery", "value": "Keyboard: AAA*2 Mouse: AA*1"}, {"label": "Model", "value": "Mini 5000"}, {"label": "Charging time", "value": "None"}, {"label": "Number of keys", "value": "Keyboard: 86/87 keys Mouse: 5+1 buttons"}, {"label": "Working time", "value": "Keyboard: About 1200H Mouse: About 313H"}, {"label": "Connection method", "value": "2.4G + Bluetooth"}, {"label": "Multi-media keys", "value": "Yes"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "Win XP/7/8/10/11, Vista, MacOS"}, {"label": "Interface", "value": "USB"}, {"label": "Weight", "value": "Keyboard: 354±5g Mouse: 53±5g"}, {"label": "Keyboard type", "value": "Membrane"}, {"label": "Size", "value": "Keyboard: 322*154*28mm Mouse: 106*63*38mm"}, {"label": "Color", "value": "Black / White"}, {"label": "DPI", "value": "800-1200-1600-2400-3200"}, {"label": "Return rate", "value": "125Hz"}, {"label": "Switch lifespan", "value": "3 Million"}, {"label": "Storage Temperature", "value": "-20°~60°"}, {"label": "Working Temperature", "value": "0~40°"}]'::jsonb,
  array['https://www.meetion.com/lifisher-m4425/1767603769346-mini5000product-displaymp4.mp4']::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "mini5000-black", "color": "Black", "price": 3700, "image": "/products/meetion/mini5000-1.jpg"}, {"id": "mini5000-white", "color": "White", "price": 3700}], "defaultOptionId": "mini5000-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-mini5000');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion M360 Wired Mouse',
  'Model: Meetion M360

Connection: USB cable
Warranty: 1-year limited warranty',
  500, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/m360-1.jpg',
  array['/products/meetion/m360-1.jpg']::text[],
  'https://www.meetion.com/mt-m360.html',
  'meetion-m360',
  true,
  'Meetion',
  array['Resolution: 1000dpi', 'Interface: USB', 'Cable length: 1.5±0.01m', 'Compatible system: Win XP/ Vista 7/8/10/11, MAC OS', 'Weight: 75±5g', 'Dimension: 115*62.5*38mm']::text[],
  '[{"label": "Model", "value": "M360"}, {"label": "Color", "value": "Black"}, {"label": "Resolution", "value": "1000dpi"}, {"label": "Dimension", "value": "115*62.5*38mm"}, {"label": "Qty of key", "value": "2+1"}, {"label": "Weight", "value": "75±5g"}, {"label": "Compatible system", "value": "Win XP/ Vista 7/8/10/11, MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable length", "value": "1.5±0.01m"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-m360');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion M100 Silent Wired Mouse',
  'Model: Meetion M100

Connection: USB cable
Warranty: 1-year limited warranty',
  700, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/m1oo-1.jpg',
  array['/products/meetion/m1oo-1.jpg', '/products/meetion/m1oo-2.jpg', '/products/meetion/m1oo-3.jpg', '/products/meetion/m1oo-4.jpg', '/products/meetion/m1oo-5.jpg']::text[],
  'https://www.meetion.com/mt-m100.html',
  'meetion-m1oo',
  true,
  'Meetion',
  array['Wired mouse', '5 million times silent switch for left and right buttons', '1200DPI']::text[],
  '[{"label": "Model", "value": "M100"}, {"label": "Color", "value": "Black"}, {"label": "Backlight", "value": "None"}, {"label": "Dimension", "value": "112.8*58.2*37.8mm"}, {"label": "Mouse Type", "value": "Wired"}, {"label": "Weight", "value": "75g±5g"}, {"label": "No. of keys", "value": "3"}, {"label": "Key life", "value": "5 million times silent switch"}, {"label": "Resolution", "value": "1200 DPI"}, {"label": "Cable Length", "value": "1.5m"}, {"label": "Interface", "value": "USB"}, {"label": "Compatible systems", "value": "Win XP/Vista/7/8/10/11 MAC OS"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-m1oo');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion R545 Wireless Mouse',
  'Model: Meetion R545

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  1300, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/r545-1.jpg',
  array['/products/meetion/r545-1.jpg']::text[],
  'https://www.meetion.com/mt-r545.html',
  'meetion-r545',
  true,
  'Meetion',
  array['Resolution: 1600dpi', 'Operation Mode: Opto-electronic', 'Wireless distance: 10m', 'Weight: 70±5g', 'Dimension: 100 * 60 * 39mm']::text[],
  '[{"label": "Model", "value": "R545"}, {"label": "Color", "value": "Black\\Blue\\White\\Pink\\Cyan"}, {"label": "Operation Mode", "value": "Opto-electronic"}, {"label": "Dimension", "value": "100 * 60 * 39mm"}, {"label": "Type", "value": "2.4GHz Wireless"}, {"label": "Weight", "value": "70±5g"}, {"label": "Power Type", "value": "Battery AA*1"}, {"label": "Type", "value": "USB"}, {"label": "Key life", "value": "5 million times"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Resolution", "value": "1600dpi"}, {"label": "Rated voltage / current", "value": "3.7V / 8mA"}]'::jsonb,
  array['https://www.youtube.com/watch?v=CdlQpFyc2FA']::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["White", "Black", "Blue"]}, "options": [{"id": "r545-white", "color": "White", "price": 1300, "image": "/products/meetion/r545-1.jpg"}, {"id": "r545-black", "color": "Black", "price": 1300, "image": "/products/meetion/r545-1.jpg"}, {"id": "r545-blue", "color": "Blue", "price": 1300, "image": "/products/meetion/r545-1.jpg"}], "defaultOptionId": "r545-white"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-r545');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion R546 Wireless Mouse',
  'Model: Meetion R546

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  1300, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/r546-1.jpg',
  array['/products/meetion/r546-1.jpg', '/products/meetion/r546-2.jpg', '/products/meetion/r546-3.jpg', '/products/meetion/r546-4.jpg', '/products/meetion/r546-5.jpg']::text[],
  'https://www.meetion.com/mt-r546.html',
  'meetion-r546',
  true,
  'Meetion',
  array['Resolution: 800-1200-1600 DPI', 'Polling rate: 125Hz', 'Backlight: None', 'Wireless distance: 10M', 'Battery: AAA*2', 'Weight: 55±2g']::text[],
  '[{"label": "Model", "value": "MT-R546"}, {"label": "Color", "value": "Black/White/Pink/Purple"}, {"label": "Backlight", "value": "None"}, {"label": "Dimension", "value": "118.8*61.8*38.9mm"}, {"label": "Mouse Type", "value": "2.4GHz"}, {"label": "Weight", "value": "55±2g"}, {"label": "No. of keys", "value": "4"}, {"label": "Key life", "value": "3 million times silent switch"}, {"label": "Resolution", "value": "800-1200-1600 DPI"}, {"label": "Wireless distance", "value": "10M"}, {"label": "Battery", "value": "AAA*2"}, {"label": "Polling rate", "value": "125Hz"}, {"label": "Work current", "value": "≤14 mA"}, {"label": "System", "value": "Win XP/Vista/7/8/10MAC OS"}, {"label": "Battery life", "value": "200H"}]'::jsonb,
  array['https://www.meetion.com/lifisher-m4425/1767604595671-r546product-displaymp4.mp4']::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "r546-black", "color": "Black", "price": 1300, "image": "/products/meetion/r546-1.jpg"}, {"id": "r546-white", "color": "White", "price": 1300}], "defaultOptionId": "r546-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-r546');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion R547 Wireless Mouse',
  'Model: Meetion R547

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  1300, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/r547-1.jpg',
  array['/products/meetion/r547-1.jpg', '/products/meetion/r547-2.jpg', '/products/meetion/r547-3.jpg', '/products/meetion/r547-4.jpg', '/products/meetion/r547-5.jpg']::text[],
  'https://www.meetion.com/mt-r547.html',
  'meetion-r547',
  true,
  'Meetion',
  array['Resolution: 1600dpi', 'Operation Mode: Opto-electronic', 'Wireless distance: 10m', 'Weight: 58±2g', 'Dimension: 106 * 60 * 34mm']::text[],
  '[{"label": "Model", "value": "R547"}, {"label": "Color", "value": "Black\\Gray\\Red\\Green\\Blue"}, {"label": "Operation Mode", "value": "Opto-electronic"}, {"label": "Dimension", "value": "106 * 60 * 34mm"}, {"label": "Type", "value": "2.4GHz Wireless"}, {"label": "Weight", "value": "58±2g"}, {"label": "Power Type", "value": "Battery AA*1"}, {"label": "Type", "value": "USB"}, {"label": "Key life", "value": "5 million times"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Resolution", "value": "1600dpi"}, {"label": "Rated voltage / current", "value": "3.7V / 8mA"}]'::jsonb,
  array['https://www.youtube.com/watch?v=YLXMTWiJWoI', 'https://www.youtube.com/watch?v=HLzx2Mx-8eA']::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "Grey"]}, "options": [{"id": "r547-black", "color": "Black", "price": 1300, "image": "/products/meetion/r547-1.jpg"}, {"id": "r547-grey", "color": "Grey", "price": 1300}], "defaultOptionId": "r547-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-r547');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion R560 Wireless Mouse',
  'Model: Meetion R560

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  1300, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/r560-1.jpg',
  array['/products/meetion/r560-1.jpg']::text[],
  'https://www.meetion.com/mt-r560.html',
  'meetion-r560',
  true,
  'Meetion',
  array['Resolution: 800/1200/1600 DPI', 'Operation Mode: Optical', 'Battery: AA*1', 'Compatible systems: Win XP/Vista/7/8/10/MAC OS', 'Weight: 60±2g', 'Dimension: 110 * 60 * 37mm']::text[],
  '[{"label": "Model", "value": "R560"}, {"label": "Color", "value": "Black\\Gray\\White\\Chocolate"}, {"label": "Operation Mode", "value": "Optical"}, {"label": "Dimension", "value": "110 * 60 * 37mm"}, {"label": "Mouse Type", "value": "2.4GHz Wireless"}, {"label": "Weight", "value": "60±2g"}, {"label": "No. of keys", "value": "4"}, {"label": "Resolution", "value": "800/1200/1600 DPI"}, {"label": "Battery", "value": "AA*1"}, {"label": "Interface", "value": "USB Nano receiver"}, {"label": "Compatible systems", "value": "Win XP/Vista/7/8/10/MAC OS"}]'::jsonb,
  array['https://www.youtube.com/watch?v=mQ-NrOmhEI0']::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Grey", "Black"]}, "options": [{"id": "r560-grey", "color": "Grey", "price": 1300, "image": "/products/meetion/r560-1.jpg"}, {"id": "r560-black", "color": "Black", "price": 1300, "image": "/products/meetion/r560-1.jpg"}], "defaultOptionId": "r560-grey"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-r560');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion R571 Silent Wireless Mouse',
  'Model: Meetion R571

Connection: 2.4G wireless (USB receiver)
Warranty: 1-year limited warranty',
  1500, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/r571-1.jpg',
  array['/products/meetion/r571-1.jpg', '/products/meetion/r571-2.jpg', '/products/meetion/r571-3.jpg', '/products/meetion/r571-4.jpg', '/products/meetion/r571-5.jpg']::text[],
  'https://www.meetion.com/mt-btm571.html',
  'meetion-r571',
  true,
  'Meetion',
  array['DPI: 800-1200-1600-2400-3200', 'Switch lifespan: 3 Million', 'Connection method: 2.4G + Bluetooth two channels', 'Transmission distance: 10m', 'Battery: 300mAh', 'Charging time: About 1h']::text[],
  '[{"label": "Product name", "value": "MT-BTM571"}, {"label": "Battery", "value": "300mAh"}, {"label": "Model", "value": "BTM571"}, {"label": "Charging time", "value": "About 1h"}, {"label": "Number of buttons", "value": "3+1 buttons"}, {"label": "Working time", "value": "About 60h"}, {"label": "Connection method", "value": "2.4G + Bluetooth two channels"}, {"label": "Switch lifespan", "value": "3 Million"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "Win XP/7/8/10/11, Vista, MacOS"}, {"label": "Interface", "value": "Type-C"}, {"label": "Weight", "value": "57±5g"}, {"label": "DPI", "value": "800-1200-1600-2400-3200"}, {"label": "Size", "value": "106*63*38mm"}, {"label": "Color", "value": "Black / White / Pink /Purple"}, {"label": "Return rate", "value": "125Hz"}, {"label": "Storage temperature", "value": "-20°~60°"}, {"label": "Working temperature", "value": "0~40°"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  '{"dimensions": ["color"], "choices": {"color": ["Black", "White"]}, "options": [{"id": "r571-black", "color": "Black", "price": 1500, "image": "/products/meetion/r571-1.jpg"}, {"id": "r571-white", "color": "White", "price": 1500}], "defaultOptionId": "r571-black"}'::jsonb
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-r571');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTM185 Dual-Mode Silent Wireless Mouse',
  'Model: Meetion BTM185

Connection: 2.4G wireless plus 2 Bluetooth channels
Warranty: 1-year limited warranty',
  2100, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/btm185-1.jpg',
  array['/products/meetion/btm185-1.jpg', '/products/meetion/btm185-2.jpg', '/products/meetion/btm185-3.jpg', '/products/meetion/btm185-4.jpg', '/products/meetion/btm185-5.jpg']::text[],
  'https://www.meetion.com/mt-btm185.html',
  'meetion-btm185',
  true,
  'Meetion',
  array['Resolution: 800-1200-1600-2400-3200 DPI', 'Polling rate: 125Hz', 'Backlight: None', 'Wireless distance: 10M', 'Battery: AA*1', 'Weight: 66±2g']::text[],
  '[{"label": "Model", "value": "MT-BTM185"}, {"label": "Color", "value": "Black"}, {"label": "Backlight", "value": "None"}, {"label": "Dimension", "value": "106.8*68.8*39.5mm"}, {"label": "Mouse Type", "value": "2.4G + Bluetooth dual mode"}, {"label": "Weight", "value": "66±2g"}, {"label": "No. of keys", "value": "4"}, {"label": "Key life", "value": "3 million times silent switch"}, {"label": "Resolution", "value": "800-1200-1600-2400-3200 DPI"}, {"label": "Wireless distance", "value": "10M"}, {"label": "Battery", "value": "AA*1"}, {"label": "Polling rate", "value": "125Hz"}, {"label": "Work current", "value": "≤10 mA"}, {"label": "System", "value": "Win XP/Vista/7/8/10MAC OS"}, {"label": "Battery life", "value": "220H"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-btm185');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTM007 Rechargeable Ergonomic Wireless Mouse',
  'Model: Meetion BTM007

Connection: 2.4G wireless plus 2 Bluetooth channels
Warranty: 1-year limited warranty',
  3200, 5,
  (select id from public.categories where slug = 'acc-mice'),
  null,
  '{}'::text[],
  'www.meetion.com/MT-BTM007.html',
  'meetion-btm007',
  true,
  'Meetion',
  array['Dual-Mode Rechargeable Ergonomic Mouse with Built-in 700mAh Battery and NTC Protection', '2.4G + Dual Bluetooth; Auto- Detection for Win/Mac Dual Systems', 'Tilt Wheel Mouse with RGB Lighting', '3 Million Clicks Silent Switches', 'DPI: 800 - 1200 - 1600 (Default) - 2400 with Memory Function']::text[],
  '[{"label": "Model", "value": "BTM007"}, {"label": "Type", "value": "Ergonomic wireless mouse with tilt wheel"}, {"label": "Connection", "value": "2.4G wireless + 2 Bluetooth channels"}, {"label": "DPI", "value": "800 / 1200 / 1600 (default) / 2400, with memory"}, {"label": "Battery", "value": "700mAh rechargeable, with NTC protection"}, {"label": "Switches", "value": "Silent, rated 3 million clicks"}, {"label": "Lighting", "value": "RGB"}, {"label": "Compatible systems", "value": "Windows / Mac (auto-detect)"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-btm007');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion BTM008 Vertical Ergonomic Wireless Mouse',
  'Model: Meetion BTM008

Connection: 2.4G wireless plus 2 Bluetooth channels
Warranty: 1-year limited warranty',
  3700, 5,
  (select id from public.categories where slug = 'acc-mice'),
  '/products/meetion/btm008-1.jpg',
  array['/products/meetion/btm008-1.jpg', '/products/meetion/btm008-2.jpg', '/products/meetion/btm008-3.jpg', '/products/meetion/btm008-4.jpg', '/products/meetion/btm008-5.jpg']::text[],
  'https://www.meetion.com/mt-btm008.html',
  'meetion-btm008',
  true,
  'Meetion',
  array['ABS Plastic', 'Ergonomic right-handed mouse, 57°', '2.4G + dual Bluetooth, dual- mode connectivity', 'Supports up to 2400 DPI', 'Sensor: PAW3212', 'Low power consumption 500mAh battery, 100 hours of working time']::text[],
  '[{"label": "Operation Mode", "value": "Opto-electronic"}, {"label": "Type", "value": "2.4GHz & Bluetooth Dual Mode"}, {"label": "Power Type", "value": "Rechargeable"}, {"label": "Interface", "value": "Type-C"}, {"label": "Key life", "value": "5 million times"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Weight", "value": "95±5g"}, {"label": "Product Size", "value": "104*83*55mm"}, {"label": "Resolution", "value": "2400DPI (800-1200-1800-2400)"}, {"label": "Number of buttons", "value": "7+1"}, {"label": "Feature", "value": "Right-handed Wireless Ergonomic Vertical Design"}, {"label": "Battery capacity", "value": "500mA"}, {"label": "Charging time", "value": "1.5H"}, {"label": "Working time", "value": "100H"}, {"label": "Note", "value": "Please remove the protective film from the bottom of the screen before use"}]'::jsonb,
  '{}'::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-btm008');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CHR31 Gaming Chair',
  'Model: Meetion CHR31

Warranty: not covered (furniture)',
  47600, 5,
  (select id from public.categories where slug = 'acc-gaming-chairs'),
  '/products/meetion/chr-31-1.jpg',
  array['/products/meetion/chr-31-1.jpg', '/products/meetion/chr-31-2.jpg', '/products/meetion/chr-31-3.jpg', '/products/meetion/chr-31-4.jpg', '/products/meetion/chr-31-5.jpg']::text[],
  'https://www.meetion.com/mt-chr31.html',
  'meetion-chr-31',
  true,
  'Meetion',
  array['Adjustable armrests', 'Extendable footrest', 'Seat height 45–53cm, seat width 48.5cm', 'Seat depth 43cm', 'Armrest width 66cm', 'Backrest 57cm high, 50cm wide', 'Chair height 114–122cm', 'Maximum load 130kg', 'Net weight 19.5kg', 'Black with orange accents']::text[],
  '[{"label": "Product", "value": "MT-CHR31"}, {"label": "Model", "value": "CHR31"}, {"label": "Seat Cushion Height", "value": "Adjustable up & down by 5.5cm"}, {"label": "Backrest Width", "value": "51cm"}, {"label": "Headrest Adjustable Angle", "value": "45° rotation adjustment"}, {"label": "Seat-to-Back Height", "value": "45–53cm"}, {"label": "Seat Material", "value": "PP material"}, {"label": "Chair Height", "value": "114–122cm"}, {"label": "Mesh Material", "value": "Special nylon mesh"}, {"label": "Backrest Height", "value": "59cm"}, {"label": "Footrest Adjustable Length", "value": "10cm"}, {"label": "Armrest Inner Width", "value": "47.5cm"}, {"label": "Maximum Load Capacity", "value": "136kg"}, {"label": "Armrest Outer Width", "value": "65.5cm"}, {"label": "Seat Cushion Size", "value": "48.5cm"}, {"label": "Maximum Recline Angle", "value": "126°"}, {"label": "Seat Depth", "value": "43–47.5cm"}]'::jsonb,
  array['https://www.meetion.com/lifisher-m4425/1767603104497-chr31product-displaymp4.mp4']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-chr-31');

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id, image_path, gallery_image_paths,
  source_url, legacy_demo_id, is_online, brand, features, specifications, video_urls, resource_links, variants
)
select
  'Meetion CHR32 Gaming Chair',
  'Model: Meetion CHR32

Warranty: not covered (furniture)',
  49100, 5,
  (select id from public.categories where slug = 'acc-gaming-chairs'),
  '/products/meetion/chr-32-1.jpg',
  array['/products/meetion/chr-32-1.jpg', '/products/meetion/chr-32-2.jpg', '/products/meetion/chr-32-3.jpg', '/products/meetion/chr-32-4.jpg', '/products/meetion/chr-32-5.jpg']::text[],
  'https://www.meetion.com/mt-chr32.html',
  'meetion-chr-32',
  true,
  'Meetion',
  array['Adjustable armrests', 'Extendable footrest', 'Seat height 45–53cm, seat width 48.5cm', 'Seat depth 43cm', 'Armrest width 66cm', 'Backrest 57cm high, 50cm wide', 'Chair height 114–122cm', 'Maximum load 130kg', 'Net weight 19.5kg', 'Black with orange accents']::text[],
  '[{"label": "Seat Cushion Height", "value": "Adjustable up & down by 5.5cm"}, {"label": "Backrest Width", "value": "51cm"}, {"label": "Headrest Adjustable Angle", "value": "45° rotation adjustment"}, {"label": "Seat-to-Back Height", "value": "45–53cm"}, {"label": "Seat Material", "value": "PP material"}, {"label": "Chair Height", "value": "114–122cm"}, {"label": "Mesh Material", "value": "Special nylon mesh"}, {"label": "Backrest Height", "value": "59cm"}, {"label": "Footrest Adjustable Length", "value": "10cm"}, {"label": "Armrest Inner Width", "value": "47.5cm"}, {"label": "Maximum Load Capacity", "value": "136kg"}, {"label": "Armrest Outer Width", "value": "65.5cm"}, {"label": "Seat Cushion Size", "value": "48.5cm"}, {"label": "Maximum Recline Angle", "value": "126°"}, {"label": "Seat Depth", "value": "43–47.5cm"}, {"label": "Backrest Adjustable Height", "value": "Three-level adjustment, 5cm range"}]'::jsonb,
  array['https://www.meetion.com/lifisher-m4425/1767603473466-20250925chr32product-displaymp4.mp4']::text[],
  '[]'::jsonb,
  null
where not exists (select 1 from public.inventory_products where legacy_demo_id = 'meetion-chr-32');

-- Apple products: branded pictures (the plain originals stay in /products/apple) ---
update public.inventory_products set
  image_path = '/products/apple-branded/apple-airpods-4-price-pakistan-1.jpg',
  gallery_image_paths = array['/products/apple-branded/apple-airpods-4-price-pakistan-1.jpg', '/products/apple-branded/apple-airpods-4-price-pakistan-2.jpg', '/products/apple-branded/apple-airpods-4-price-pakistan-3.jpg']::text[]
where id = 'a697d4c7-c4c7-4c55-ae54-c41d5f51a2e6';  -- Apple AirPods 4 With Type C Charging (White)

update public.inventory_products set
  image_path = '/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-1.jpg',
  gallery_image_paths = array['/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-1.jpg', '/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-2.jpg', '/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-3.jpg', '/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-4.jpg', '/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-5.jpg', '/products/apple-branded/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-6.jpg']::text[]
where id = 'debee671-9705-4725-8478-ae1806408e27';  -- Apple AirPods Pro 3

update public.inventory_products set
  image_path = '/products/apple-branded/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-1.jpg',
  gallery_image_paths = array['/products/apple-branded/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-1.jpg', '/products/apple-branded/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-2.jpg', '/products/apple-branded/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-3.jpg', '/products/apple-branded/ipad-a16-pink.jpg', '/products/apple-branded/ipad-a16-silver.jpg', '/products/apple-branded/ipad-a16-yellow.jpg']::text[],
  variants = '{"choices": {"size": ["11-inch"], "color": ["Blue", "Pink", "Silver", "Yellow"], "storage": ["128GB"]}, "options": [{"id": "c4ba0d47-bc82-4e59-a47c-db0554f00b51", "size": "11-inch", "color": "Blue", "image": "/products/apple-branded/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-1.jpg", "price": 119500, "storage": "128GB"}, {"id": "f9989238-6cc6-4c59-ba42-262caaa32789", "size": "11-inch", "color": "Pink", "image": "/products/apple-branded/ipad-a16-pink.jpg", "price": 119500, "storage": "128GB"}, {"id": "ac368eeb-20f4-47f6-bc04-6ce984a47774", "size": "11-inch", "color": "Silver", "image": "/products/apple-branded/ipad-a16-silver.jpg", "price": 119500, "storage": "128GB"}, {"id": "fdbbcca9-e8e0-4afb-8a11-69052a3e7fd4", "size": "11-inch", "color": "Yellow", "image": "/products/apple-branded/ipad-a16-yellow.jpg", "price": 119500, "storage": "128GB"}], "dimensions": ["size", "color", "storage"], "defaultOptionId": "c4ba0d47-bc82-4e59-a47c-db0554f00b51"}'::jsonb
where id = 'ddfde1e9-3a68-4f9b-9049-7d72369ec12f';  -- Apple iPad 11th Generation (A16)

update public.inventory_products set
  image_path = '/products/apple-branded/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan-1.jpg',
  gallery_image_paths = array['/products/apple-branded/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan-1.jpg', '/products/apple-branded/ipad-air-m4-starlight.jpg', '/products/apple-branded/ipad-air-m4-grey.jpg']::text[],
  variants = '{"choices": {"size": ["11-inch"], "color": ["Purple", "Starlight", "Grey"], "storage": ["128GB"]}, "options": [{"id": "ipad-air-m4-11-inch-128gb-purple", "size": "11-inch", "color": "Purple", "image": "/products/apple-branded/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan-1.jpg", "price": 215000, "storage": "128GB"}, {"id": "ipad-air-m4-11-inch-256gb-starlight", "size": "11-inch", "color": "Starlight", "image": "/products/apple-branded/ipad-air-m4-starlight.jpg", "price": 222000, "storage": "128GB"}, {"id": "ipad-air-m4-13-inch-128gb-grey", "size": "11-inch", "color": "Grey", "image": "/products/apple-branded/ipad-air-m4-grey.jpg", "price": 210000, "storage": "128GB"}], "dimensions": ["size", "color", "storage"], "defaultOptionId": "ipad-air-m4-13-inch-128gb-grey"}'::jsonb
where id = '6af4679c-7d2d-4069-98f5-8db5b027b61c';  -- Apple iPad Air M4

update public.inventory_products set
  image_path = '/products/apple-branded/apple-pencil-pro-price-reviews-paksitan-1.jpg',
  gallery_image_paths = array['/products/apple-branded/apple-pencil-pro-price-reviews-paksitan-1.jpg', '/products/apple-branded/apple-pencil-pro-price-reviews-paksitan-2.jpg']::text[]
where id = 'f952cc21-10d5-441c-8fba-63f8822b5791';  -- Apple Pencil Pro (MX2D3, 2024)

update public.inventory_products set
  image_path = '/products/apple-branded/apple-pencil-type-c-white-price-reviews-pakistan-1.jpg',
  gallery_image_paths = array['/products/apple-branded/apple-pencil-type-c-white-price-reviews-pakistan-1.jpg', '/products/apple-branded/apple-pencil-type-c-white-price-reviews-pakistan-2.jpg']::text[]
where id = '86726d17-f4d9-4964-a398-0819ce12e3a6';  -- Apple Pencil Type C (MUWA3, White)
