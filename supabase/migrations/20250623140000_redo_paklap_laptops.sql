-- Re-import Paklap new laptops with clean titles, local images, empty descriptions.
-- Removes previous Paklap rows and re-inserts by import_key.

delete from public.inventory_products
where source_url like 'https://www.paklap.pk/%';

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 250R G9 Notebook PC - Raptor Lake - 13th Gen Core i3 1315U Processor 8-GB 512-GB SSD Intel UHD Graphics 15.6" Full HD 1080P 250nits AG DIsplay W11 Pro (Grey, Open Box)',
  '',
  105000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-250r-g9-13th-gen-core-i3-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-250r-g9-13th-gen-core-i3-laptop-pakistan.html',
  'hp-250r-g9-13th-gen-core-i3-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-250r-g9-13th-gen-core-i3-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Infinix InBook Air XL442 - Alder Lake - 12th Gen Core i3 1215U Processor 8-GB 256-GB SSD Intel Integrated Graphics 14" WUXGA 1200p LCD 300nits Display 60Hz W11 (Grey, 1 Year Local Warranty NEW)',
  '',
  120000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/infinix-inbook-air-xl442-core-i3-laptop-pakistan.jpg',
  'https://www.paklap.pk/infinix-inbook-air-xl442-core-i3-laptop-pakistan.html',
  'infinix-inbook-air-xl442-core-i3-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'infinix-inbook-air-xl442-core-i3-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo V15 G5 - Raptor Lake - 13th Gen Core i3 1315U Processor 8-GB 256-GB SSD Intel UHD Integrated GC 15.6" Full HD 1080p Display TPM2.0 (Business Black, Lenovo 1 Year Direct Local Warranty, NEW)',
  '',
  140000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-v15-g5-13th-gen-core-i3-1315u-laptop-price-pakistan.jpg',
  'https://www.paklap.pk/lenovo-v15-g5-13th-gen-core-i3-1315u-laptop-price-pakistan.html',
  'lenovo-v15-g5-13th-gen-core-i3-1315u-laptop-price-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-v15-g5-13th-gen-core-i3-1315u-laptop-price-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell Pro 15 Essential PV15250 Laptop - Intel Core 3 100U Processor 8-GB 512-GB SSD Intel UHD Graphics 15.6" FHD 1080P WVA 120Hz AG Display (Carbon Black, NEW)',
  '',
  145000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-pro-15-essential-pv15250-core-3-laptop-pakistan.jpg',
  'https://www.paklap.pk/dell-pro-15-essential-pv15250-core-3-laptop-pakistan.html',
  'dell-pro-15-essential-pv15250-core-3-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-pro-15-essential-pv15250-core-3-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 250R G9 Notebook PC - Raptor Lake - 13th Gen Core i5 1334U Processor 8-GB 512-GB SSD Intel UHD Graphics 15.6" Full HD 1080P 250nits AG Display (Black, NEW)',
  '',
  165000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-250r-g9-13th-gen-core-i5-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/hp-250r-g9-13th-gen-core-i5-laptop-2026-pakistan.html',
  'hp-250r-g9-13th-gen-core-i5-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-250r-g9-13th-gen-core-i5-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell 15 DC15250 Laptop - Raptor Lake - 13th Gen Core i5 1334U Processor 8-GB 512-GB SSD Intel Integrated GC 15.6" Full HD 1080P WVA Touchscreen AG Display W11 (Carbon Black, NEW)',
  '',
  166000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-15-dc15250-13th-gen-core-i5-laptop-2026-pakistan.png',
  'https://www.paklap.pk/dell-15-dc15250-13th-gen-core-i5-laptop-2026-pakistan.html',
  'dell-15-dc15250-13th-gen-core-i5-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-15-dc15250-13th-gen-core-i5-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo V15 G2 - Tiger Lake - 11th Gen Core i7 1185G7 QuadCore Processor 8-GB RAM 1-TB HDD Intel Integrated GC 15.6" FHD 1080p TN 250nits AG Display DolbyAudio TPM 2.0 (Black, Lenovo Direct Local Warranty)',
  '',
  170000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-v15-g2-11th-gen-core-i7-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-v15-g2-11th-gen-core-i7-laptop-pakistan.html',
  'lenovo-v15-g2-11th-gen-core-i7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-v15-g2-11th-gen-core-i7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 250R G10 Notebook PC - Intel Core 5 120U Processor 8-GB 512-GB SSD Intel Integrated Graphics 15.6" FHD 1080P IPS 300nits AG Display (Black, NEW)',
  '',
  170000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-250r-g10-core-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-250r-g10-core-5-laptop-pakistan.html',
  'hp-250r-g10-core-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-250r-g10-core-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Asus VivoBook 16 X1607QA - Snapdragon X X1-26-100 8-Core Processor 16-GB 1-TB SSD Qualcomm Adreno Graphics 16" WUXGA 1200P IPS AG Display Backlit KB W11 (Silver, NEW)',
  '',
  185000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/asus-vivobook-16-x1607qa-snapdragon-x-laptop-pakistan.jpg',
  'https://www.paklap.pk/asus-vivobook-16-x1607qa-snapdragon-x-laptop-pakistan.html',
  'asus-vivobook-16-x1607qa-snapdragon-x-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'asus-vivobook-16-x1607qa-snapdragon-x-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 15 FD0154WM - Intel Core Ultra 5 125H Processor 8-GB 512-GB SSD Intel Iris Xe Graphics 15.6" Full HD 1080P IPS Micro-Edge BrightView 250nits Touchscreen Display W11 (Natural Silver, NEW)',
  '',
  185000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-15-fd0154wm-core-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-15-fd0154wm-core-ultra-5-laptop-pakistan.html',
  'hp-15-fd0154wm-core-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-15-fd0154wm-core-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 15 FD1310TU - Meteor Lake - Intel Core Ultra 7 155H Processor 8-GB 512-GB SSD Intel Arc Graphics 15.6" Full HD 1080p 250nits MicroEdge Display Backlit KB (Natural Silver, NEW)',
  '',
  203000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-15-fd1310tu-intel-core-ultra-7-laptop-price-pakistan.jpg',
  'https://www.paklap.pk/hp-15-fd1310tu-intel-core-ultra-7-laptop-price-pakistan.html',
  'hp-15-fd1310tu-intel-core-ultra-7-laptop-price-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-15-fd1310tu-intel-core-ultra-7-laptop-price-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 14 G8 - Intel Core 5 210H 8-Core Processor 8-GB 512-GB SSD Intel Integrated Graphics 14" WUXGA 1200p IPS AG Display Dolby Audio Backlit KB FP Reader TPM 2.0 (Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  215000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-14-g8-intel-core-5-laptop-price-in-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-14-g8-intel-core-5-laptop-price-in-pakistan.html',
  'lenovo-thinkbook-14-g8-intel-core-5-laptop-price-in-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-14-g8-intel-core-5-laptop-price-in-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 250R G10 Notebook PC - Intel Core 7 150U Processor 16-GB 512-GB SSD Intel Integrated Graphics 15.6" FHD 1080P IPS 300nits AG Display (Turbo Silver, NEW)',
  '',
  215000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-250r-g10-core-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-250r-g10-core-7-laptop-pakistan.html',
  'hp-250r-g10-core-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-250r-g10-core-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E16 Gen 1 - Raptor Lake - 13th Gen Core i5 1335u Deca-Core Processor 8-GB 512-GB SSD Intel Integrated GC 16" WUXGA IPS AG 300nits Display Backlit KB FP Reader (Graphite Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  220000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e16-gen-1-13th-gen-ci5-laptop-price-reviews-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e16-gen-1-13th-gen-ci5-laptop-price-reviews-pakistan.html',
  'lenovo-thinkpad-e16-gen-1-13th-gen-ci5-laptop-price-reviews-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e16-gen-1-13th-gen-ci5-laptop-price-reviews-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ProBook 440 G11 - Intel Core Ultra 5 125U 12-Core Processor 8-GB 512-GB SSD Intel Integrated GC 14" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB FP Reader (Pike Silver, Bag Included NEW)',
  '',
  220000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-probook-440-g11-intel-core-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-probook-440-g11-intel-core-ultra-5-laptop-pakistan.html',
  'hp-probook-440-g11-intel-core-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-probook-440-g11-intel-core-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP OmniBook 7 AI 14 FR0004TU Laptop - Intel Core Ultra 5 225H Processor 16-GB 1-TB SSD Intel Arc 130-T Graphics 14" 2.2K 1400P IPS MicroEdge AG Display PolyStudio Audio Backlit KB W11 (Glacier Silver, Open Box)',
  '',
  220000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-omnibook-7-ai-14-fr0004tu-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-omnibook-7-ai-14-fr0004tu-ultra-5-laptop-pakistan.html',
  'hp-omnibook-7-ai-14-fr0004tu-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-omnibook-7-ai-14-fr0004tu-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 15 FD1003NQ - Intel Core Ultra 5 125H Processor 24-GB 1-TB SSD Intel Arc Graphics 15.6" Full HD 1080P IPS 300nits Display (Natural Silver, NEW)',
  '',
  220000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-15-fd1003nq-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-15-fd1003nq-ultra-5-laptop-pakistan.html',
  'hp-15-fd1003nq-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-15-fd1003nq-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad T14 Gen 3 - 12th Gen Core i5 1235u Processor 8-GB 512GB SSD Intel Iris Xe Graphics 14" WUXGA IPS 300nits AG Display Dolby Audio BKB FPR TPM (Thunder Black, 3 Years Direct Local Warranty, NEW)',
  '',
  222500.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-t14-gen-3-12th-gen-core-i5-laptop-price-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-t14-gen-3-12th-gen-core-i5-laptop-price-pakistan.html',
  'lenovo-thinkpad-t14-gen-3-12th-gen-core-i5-laptop-price-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-t14-gen-3-12th-gen-core-i5-laptop-price-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 14 G8 - Raptor Lake - Intel Core 7 240H 10-Core Processor 8-GB 512-GB SSD Intel Integrated Graphics 14" WUXGA 1200p IPS AG Display Dolby Audio Backlit KB FP Reader TPM 2.0 (Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  237000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-14-g8-intel-core-7-new-2025-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-14-g8-intel-core-7-new-2025-laptop-pakistan.html',
  'lenovo-thinkbook-14-g8-intel-core-7-new-2025-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-14-g8-intel-core-7-new-2025-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ZBook Firefly 14 G11 - Intel Core Ultra 5 125H Processor 16-GB 1-TB SSD 4-GB NVIDIA RTX A500 GDDR6 GC 14" WUXGA 1200P IPS Touchscreen AG Display Backlit KB W11 Pro (Silver, Open Box)',
  '',
  240000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-zbook-firefly-14-g11-ultra-5-rtx-a500-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-zbook-firefly-14-g11-ultra-5-rtx-a500-laptop-pakistan.html',
  'hp-zbook-firefly-14-g11-ultra-5-rtx-a500-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-zbook-firefly-14-g11-ultra-5-rtx-a500-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 16 Gen 7 - AMD Ryzen 5 7535HS Processor 16-GB 512-GB SSD AMD Radeon 660M Graphics 16" WUXGA 1200P IPS 300nits AG Display BKB FPR TPM (Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  245000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-16-gen-7-ryzen-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-16-gen-7-ryzen-5-laptop-pakistan.html',
  'lenovo-thinkbook-16-gen-7-ryzen-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-16-gen-7-ryzen-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 16 G9 - Intel Core 5 210H 8-Core Processor 16-GB 512-GB SSD Intel Integrated Graphics 16" WUXGA 1200P IPS 400nits AG Display Dolby Audio Backlit KB FP Reader TPM (Arctic Grey, Lenovo 1 Year Diract Local Warranty, NEW)',
  '',
  250000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-16-g9-core-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-16-g9-core-5-laptop-pakistan.html',
  'lenovo-thinkbook-16-g9-core-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-16-g9-core-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E14 Gen 7 - Raptor Lake - Intel® Core™ 5 210H 8-Core Processor 8-GB 512GB SSD Intel Integrated Graphics 14" WUXGA IPS AG 300nits Display Backlit KB FP Reader TPM 2.0 (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  255000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e14-gen-7-intel-core-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e14-gen-7-intel-core-5-laptop-pakistan.html',
  'lenovo-thinkpad-e14-gen-7-intel-core-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e14-gen-7-intel-core-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ProBook 460 G11 - Intel Core Ultra 7 155U 12-Core Processor 8-GB 512-GB SSD Intel Integrated GC 16" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB (HP Carry Case, Pike Silver, NEW)',
  '',
  255000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-probook-460-g11-intel-core-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-probook-460-g11-intel-core-ultra-7-laptop-pakistan.html',
  'hp-probook-460-g11-intel-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-probook-460-g11-intel-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ProBook 4 G1iR 14 Notebook - Intel Core 5 120U Processor 8-GB 512-GB SSD Intel Integrated GC 14" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB FP Reader (Pike Silver, HP Direct Local Warranty)',
  '',
  255000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-probook-4-g1ir-14-notebook-intel-core-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-probook-4-g1ir-14-notebook-intel-core-5-laptop-pakistan.html',
  'hp-probook-4-g1ir-14-notebook-intel-core-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-probook-4-g1ir-14-notebook-intel-core-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo LOQ 15 Essential - Alder Lake - 12th Gen Core i5 12450HX Processor 8-GB 512-GB SSD 6-GB NVIDIA GeForce RTX 4050 GDDR6 GC Nahimic Audio W11 (Luna Grey, NEW)',
  '',
  255000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-loq-15-essential-12th-gen-core-i5-rtx-4050-gpu-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-loq-15-essential-12th-gen-core-i5-rtx-4050-gpu-gaming-laptop-pakistan.html',
  'lenovo-loq-15-essential-12th-gen-core-i5-rtx-4050-gpu-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-loq-15-essential-12th-gen-core-i5-rtx-4050-gpu-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E14 Gen 6 - Intel Core Ultra 5 125U 12-Core Processor 8-GB 512-GB SSD Intel Integrated GC 14" WUXGA 1200p IPS 300nits AG Display Backlit KB FP Reader TPM (Black, Bag Included, Lenovo Direct Local Warranty)',
  '',
  262000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e14-gen-6-intel-core-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e14-gen-6-intel-core-ultra-5-laptop-pakistan.html',
  'lenovo-thinkpad-e14-gen-6-intel-core-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e14-gen-6-intel-core-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 15 FD2100TU AI Laptop - Intel Core Ultra 5 225U 12-Core Processor 16-GB 512-GB SSD Intel integrated Graphics 15.6" Full HD 1080p IPS 250nits AG Display Backlit KB (Natural Silver, HP Direct Local Warranty)',
  '',
  268000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-15-fd2100tu-ultra-5-laptop-pakistan.png',
  'https://www.paklap.pk/hp-15-fd2100tu-ultra-5-laptop-pakistan.html',
  'hp-15-fd2100tu-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-15-fd2100tu-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 14 G8 - Intel Core Ultra 5 225U 12-Core Processor 16-GB 512-GB SSD Intel Integrated Graphics 14" WUXGA 1200P IPS AG Display Dolby Audio Backlit KB FP Reader TPM 2.0 (Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  273000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-14-g8-ultra-5-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-14-g8-ultra-5-laptop-2026-pakistan.html',
  'lenovo-thinkbook-14-g8-ultra-5-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-14-g8-ultra-5-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell Pro 15 Essential PV15250 Laptop - Raptor Lake -13th Gen Core i7 1355U 10-Core Processor 16-GB 512-GB SSD Intel UHD Graphics 15.6" FHD 1080P WVA 120Hz AG Display Backlit KB FP Reader (Platinum Silver, Dell 3 Years Local Warranty, NEW)',
  '',
  275000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-pro-15-essential-pv15250-13th-gen-core-i7-laptop-pakistan.png',
  'https://www.paklap.pk/dell-pro-15-essential-pv15250-13th-gen-core-i7-laptop-pakistan.html',
  'dell-pro-15-essential-pv15250-13th-gen-core-i7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-pro-15-essential-pv15250-13th-gen-core-i7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 14 G9 - Intel Core 7 240H 10-Core Processor 16-GB 512-GB SSD Intel Integrated Graphics 14" WUXGA 1200P IPS 400nits AG Display Dolby Audio Backlit KB FP Reader (Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  280000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-14-g9-intel-core-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-14-g9-intel-core-7-laptop-pakistan.html',
  'lenovo-thinkbook-14-g9-intel-core-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-14-g9-intel-core-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Victus 15 FA2082WM - Raptor Lake - 13th Gen Core i5 13420H Processor 16-GB 512-GB SSD 6-GB NVIDIA GeForce RTX 4050 GDDR6 GC 15.6" Full HD 1080p IPS 144Hz 300nits MicroEdge AG Display B&O Play Backlit KB W11 (Mica Silver, NEW)',
  '',
  280000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-victus-15-fa2082wm-13th-gen-core-i5-rtx-4050-gpu-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-victus-15-fa2082wm-13th-gen-core-i5-rtx-4050-gpu-laptop-pakistan.html',
  'hp-victus-15-fa2082wm-13th-gen-core-i5-rtx-4050-gpu-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-victus-15-fa2082wm-13th-gen-core-i5-rtx-4050-gpu-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 16 G8 - Arrow Lake - Intel Core 7 240H 10-Core Processor 16-GB 512-GB SSD Intel Integrated GC 16" WUXGA 1200p IPS AG 300nits Display Dolby Audio Backlit KB FPR TPM 2.0 (Bag Included, Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  285000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-16-g8-intel-core-7-laptop-price-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-16-g8-intel-core-7-laptop-price-pakistan.html',
  'lenovo-thinkbook-16-g8-intel-core-7-laptop-price-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-16-g8-intel-core-7-laptop-price-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Elitebook 660 G11 - Intel Core Ultra 5 125U 12-Core Processor 8-GB 512-GB SSD Intel Integrated GC 16" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB FP Reader (Silver, Bag Included, HP Direct Local Warranty, NEW)',
  '',
  285000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-elitebook-660-g11-intel-core-ultra-5-laptop-pakistan.png',
  'https://www.paklap.pk/hp-elitebook-660-g11-intel-core-ultra-5-laptop-pakistan.html',
  'hp-elitebook-660-g11-intel-core-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-elitebook-660-g11-intel-core-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 16 G8 - Intel Core Ultra 5 225U 12-Core Processor 16-GB 512-GB SSD Intel Integrated Graphics 16" WUXGA 1200P IPS 300nits AG Display Dolby Audio Backlit KB FP Reader TPM (Arctic Grey, Lenovo 1 Year Direct Local Warranty, NEW)',
  '',
  288000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-16-g8-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-16-g8-ultra-5-laptop-pakistan.html',
  'lenovo-thinkbook-16-g8-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-16-g8-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Victus 15 FB3093dx Gaming Laptop - AMD Ryzen 7 7445HS 6-Core Processor 16-GB 512-GB SSD 6-GB NVIDIA GeForce RTX4050 GDDR6 GC 15.6" Full HD 1080p IPS 144Hz 300nits MicroEdge Display Backlit KB W11 (Mica Silver, NEW)',
  '',
  295000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-victus-15-fb3093dx-amd-ryzen-7-rtx-4050-gpu-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-victus-15-fb3093dx-amd-ryzen-7-rtx-4050-gpu-gaming-laptop-pakistan.html',
  'hp-victus-15-fb3093dx-amd-ryzen-7-rtx-4050-gpu-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-victus-15-fb3093dx-amd-ryzen-7-rtx-4050-gpu-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 16 G9 - Intel Core 7 240H 10-Core Processor 16-GB 512-GB SSD Intel Integrated Graphics 16" WUXGA 1200P IPS 400nits AG Display Dolby Audio Backlit KB FP Reader (Arctic Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  296000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-16-g9-intel-core-7-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-16-g9-intel-core-7-laptop-2026-pakistan.html',
  'lenovo-thinkbook-16-g9-intel-core-7-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-16-g9-intel-core-7-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP 15 FD2098TU AI Laptop - Intel Core Ultra 7 255U Processor 16-GB 512-GB SSD Intel Integrated Graphics 15.6" FHD 1080P AG Display Backlit KB (Natural Silver, HP Direct Local Warranty)',
  '',
  298000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-15-fd2098tu-core-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-15-fd2098tu-core-ultra-7-laptop-pakistan.html',
  'hp-15-fd2098tu-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-15-fd2098tu-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ProBook 4 G1iR 14 Notebook - Intel Core 7 150U 10-Core Processor 8-GB 512-GB SSD Intel Integrated GC 14" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB FP Reader (Pike Silver, HP Direct Local Warranty, NEW)',
  '',
  300000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-probook-4-g1ir-14-notebook-core-7-150u-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-probook-4-g1ir-14-notebook-core-7-150u-laptop-pakistan.html',
  'hp-probook-4-g1ir-14-notebook-core-7-150u-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-probook-4-g1ir-14-notebook-core-7-150u-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 14 G8 - Arrow Lake - Intel Core Ultra 7 255H 16-Core Processor 16-GB 512-GB SSD Intel Arc Graphics 14" WUXGA 1200p IPS 300nits AG Display Backlit KB FP Reader TPM 2.0 (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  310000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-14-g8-core-ultra-7-2025-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-14-g8-core-ultra-7-2025-laptop-pakistan.html',
  'lenovo-thinkbook-14-g8-core-ultra-7-2025-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-14-g8-core-ultra-7-2025-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ProBook 4 G1i 14 Notebook - Intel Core Ultra 5 225U 12-Core Processor 16-GB 512-GB SSD Intel Integrated GC 14" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB FP Reader (Pike Silver, HP Direct Local Warranty, NEW)',
  '',
  315000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-probook-4-g1i-14-notebook-core-5-225u-laptop-pakistan.png',
  'https://www.paklap.pk/hp-probook-4-g1i-14-notebook-core-5-225u-laptop-pakistan.html',
  'hp-probook-4-g1i-14-notebook-core-5-225u-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-probook-4-g1i-14-notebook-core-5-225u-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E14 Gen 7 - Lunar Lake - Intel Core Ultra 5 226V 8-Core Processor 16-GB 512-GB SSD Intel Arc 130V Graphics 14" WUXGA 1200P IPS 300nits AG Display Dolby Atmos Audio BKB FPR TPM (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  316000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e14-gen-7-ultra-5-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e14-gen-7-ultra-5-laptop-pakistan.html',
  'lenovo-thinkpad-e14-gen-7-ultra-5-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e14-gen-7-ultra-5-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E16 Gen 3 - Lunar Lake - Intel Core Ultra 5 226V 8-Core Processor 16-GB 512-GB SSD Intel Arc 130V Graphics 16" WUXGA 1200P IPS 300nits AG Display Dolby Atmos Audio BKB FPR TPM (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  316000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e16-gen-3-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e16-gen-3-laptop-pakistan.html',
  'lenovo-thinkpad-e16-gen-3-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e16-gen-3-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Elitebook 640 G11 - Intel Core Ultra 7 155U 12-Core Processor 8-GB 512-GB SSD Intel Integrated GC 14" WUXGA 1200p IPS AG 300nits Display PolyStudio Audio Backlit KB FP Reader (Silver, Bag Included, HP Direct Local Warranty, NEW)',
  '',
  320000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-elite-book-640-g11-core-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-elite-book-640-g11-core-ultra-7-laptop-pakistan.html',
  'hp-elite-book-640-g11-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-elite-book-640-g11-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E16 Gen 3 - Arrow Lake - Intel® Core™ Ultra 5 225H 14-Core Processor 16-GB 512-GB SSD Intel Arc 140-T Graphics 16" WUXGA IPS AG 300nits Display Backlit KB FP Reader TPM 2.0 (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  320000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e16-gen-3-intel-core-ultra-5-laptop-2026-pakistan.png',
  'https://www.paklap.pk/lenovo-thinkpad-e16-gen-3-intel-core-ultra-5-laptop-2026-pakistan.html',
  'lenovo-thinkpad-e16-gen-3-intel-core-ultra-5-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e16-gen-3-intel-core-ultra-5-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo LOQ 15 - Raptor Lake - 13th Gen Core i5 13450HX Processor 16-GB 512-GB SSD 8-GB NVIDIA GeForce RTX 5050 GDDR7 GC 15.6" FHD 1080p IPS 300nits AG 144Hz G-Sync Display Nahimic Audio BKB TPM2.0 W11 (Luna Grey, NEW)',
  '',
  320000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-loq-15-13th-gen-core-i5-rtx-5050-gpu-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-loq-15-13th-gen-core-i5-rtx-5050-gpu-gaming-laptop-pakistan.html',
  'lenovo-loq-15-13th-gen-core-i5-rtx-5050-gpu-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-loq-15-13th-gen-core-i5-rtx-5050-gpu-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkBook 16 G8 - Arrow Lake - Intel Core Ultra 7 255H 16-Core Processor 16-GB 512-GB SSD Intel Integrated Arc 140T Graphics 16" WUXGA 1200p IPS AG 300nits Display Dolby Audio BKB FPR (Arctic Grey, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  323000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkbook-16-g8-core-ultra-7-laptop-2025-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkbook-16-g8-core-ultra-7-laptop-2025-pakistan.html',
  'lenovo-thinkbook-16-g8-core-ultra-7-laptop-2025-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkbook-16-g8-core-ultra-7-laptop-2025-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Victus 15 FA2352TX Gaming Laptop - Raptor Lake - 13th Gen Core i7 13620H Processor 16-GB 512-GB SSD 8-GB NVIDIA GeForce RTX 5050 GDDR7 GC 15.6" Full HD 1080p IPS 144Hz 300nits MicroEdge Display DTS:X® Ultra Audio Backlit KB (Mica Silver, NEW)',
  '',
  325000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-victus-15-fa2352tx-13th-gen-core-i7-rtx-5050-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-victus-15-fa2352tx-13th-gen-core-i7-rtx-5050-gaming-laptop-pakistan.html',
  'hp-victus-15-fa2352tx-13th-gen-core-i7-rtx-5050-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-victus-15-fa2352tx-13th-gen-core-i7-rtx-5050-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ZBook Power 16 G11 Mobile Workstation PC - Intel Core Ultra 7 155H Processor 8-GB 1-TB SSD 6-GB NVIDIA RTX 1000 Ada GDDR6 GC 16" WUXGA 1200P IPS 300nits AG Display B&O Audio Backlit KB FP Reader W11 Pro (Grey, Open Box)',
  '',
  330000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-pakistan.html',
  'hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP ZBook Power 16 G11 Mobile Workstation PC - Intel Core Ultra 7 165H Processor 8-GB 1-TB SSD 6-GB NVIDIA RTX 1000 Ada GDDR6 GC 16" WUXGA 1200P IPS 300nits AG Display B&O Audio Backlit KB FP Reader W11 Pro (Grey, Open Box)',
  '',
  335000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-2026-pakistan.html',
  'hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-zbook-power-16-g11-ultra-7-rtx-1000-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Victus 15 FA2309TX - Raptor Lake - 13th Gen Core i7 13620H Processor 24-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5050 GDDR7 GC 15.6" Full HD 1080p IPS 144Hz 300nits MicroEdge Display DTS:X® Ultra Audio RGB Backlit KB W11 (Mica Silver, NEW)',
  '',
  340000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-victus-15-fa2309tx-core-i7-rtx-5050-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-victus-15-fa2309tx-core-i7-rtx-5050-gaming-laptop-pakistan.html',
  'hp-victus-15-fa2309tx-core-i7-rtx-5050-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-victus-15-fa2309tx-core-i7-rtx-5050-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Victus 15 FA2391TX Gaming Laptop - Raptor Lake - 13th Gen Core i7 13620H Processor 16-GB 512-GB SSD 8-GB NVIDIA GeForce RTX 5050 GDDR7 GC 15.6" FHD 1080P 144Hz IPS Micro-Edge AG Display DTS:X Ultra Audio BKB (Mica Silver, HP Direct Local Warranty, NEW)',
  '',
  345000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-victus-15-fa2391tx-core-i7-rtx-5050-gmaing-laptop-pakistan.png',
  'https://www.paklap.pk/hp-victus-15-fa2391tx-core-i7-rtx-5050-gmaing-laptop-pakistan.html',
  'hp-victus-15-fa2391tx-core-i7-rtx-5050-gmaing-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-victus-15-fa2391tx-core-i7-rtx-5050-gmaing-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Microsoft Surface Pro 11 - Snapdragon X Elite 12-Core Processor 16-GB 1-TB SSD Qualcomm Adreno Graphics 13" 1920P OLED PixelSense Flow Touchscreen Display Dolby Atmos W11 TPM 2.0 (Pen Included, Black, Open Box)',
  '',
  350000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/microsoft-surface-pro-11-snapdragon-x-elite-laptop-pakistan.jpg',
  'https://www.paklap.pk/microsoft-surface-pro-11-snapdragon-x-elite-laptop-pakistan.html',
  'microsoft-surface-pro-11-snapdragon-x-elite-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'microsoft-surface-pro-11-snapdragon-x-elite-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell Pro 14 PC14250 Laptop - Intel Core Ultra 7 255U 12-Core Processor 16-GB 512-GB SSD Intel Integrated Graphics 14" FHD 1080P AG Display Backlit KB FP Reader (Bag Included, Magnetite, 3 Years Local Warranty, NEW)',
  '',
  355000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-pro-14-pc14250-core-ultra-7-laptop-pakistan.png',
  'https://www.paklap.pk/dell-pro-14-pc14250-core-ultra-7-laptop-pakistan.html',
  'dell-pro-14-pc14250-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-pro-14-pc14250-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell Pro 16 PC16250 Laptop - Intel Core Ultra 7 225U 12-Core Processor 16-GB 512-GB SSD Intel integrated Graphics 16" FHD 1200P 60Hz AG Display Backlit KB FP Reader (Magnetite, Dell 3 Years Local Warranty, NEW)',
  '',
  355000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-pro-16-pc16250-core-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/dell-pro-16-pc16250-core-ultra-7-laptop-pakistan.html',
  'dell-pro-16-pc16250-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-pro-16-pc16250-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E14 Gen 7 - Intel Core Ultra 7 256V 8-Core Processor 16-GB 512-GB SSD Intel Arc 140V Graphics 14" WUXGA 1200P IPS 300nits AG Display Dolby Atmos Audio BKB FPR TPM (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  356000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e14-gen-7-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e14-gen-7-ultra-7-laptop-pakistan.html',
  'lenovo-thinkpad-e14-gen-7-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e14-gen-7-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E16 Gen 3 - Lunar Lake - Intel Core Ultra 7 256V 8-Core Processor 16-GB 512-GB SSD Intel Arc 140V Graphics 16" WUXGA 1200P IPS 300nits AG Display Dolby Atmos Audio BKB FPR TPM (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  356000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e16-gen-3-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e16-gen-3-ultra-7-laptop-pakistan.html',
  'lenovo-thinkpad-e16-gen-3-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e16-gen-3-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo ThinkPad E16 Gen 3 - Arrow Lake - Intel® Core™ Ultra 7 255H 16-Core Processor 16-GB 512-GB SSD Intel Arc 140-T Graphics 16" WUXGA IPS AG 300nits Display Backlit KB FP Reader TPM 2.0 (Black, Bag Included, Lenovo Direct Local Warranty, NEW)',
  '',
  360000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-e16-gen-3-intel-core-ultra-7-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-e16-gen-3-intel-core-ultra-7-laptop-2026-pakistan.html',
  'lenovo-thinkpad-e16-gen-3-intel-core-ultra-7-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-e16-gen-3-intel-core-ultra-7-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 16 Gaming Laptop - Raptor Lake - 14th Gen Core i9 14900HX 24-Core Processor 12-GB 512-GB SSD 8-GB NVIDIA GeForce RTX 4060 GDDR6 GC 16" WQXGA 1600p IPS 165Hz G-Sync Display Nahimic Audio 4-Zone RGB BKB W11 TPM 2.0 (Luna Grey, Open Box)',
  '',
  360000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-16-14th-gen-core-i9-rtx-4060-gaming-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-16-14th-gen-core-i9-rtx-4060-gaming-laptop-2026-pakistan.html',
  'lenovo-legion-5-16-14th-gen-core-i9-rtx-4060-gaming-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-16-14th-gen-core-i9-rtx-4060-gaming-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell 14 Plus DB14250 Laptop - Intel Core Ultra 9 288V Processor 32-GB 1-TB SSD Intel Arc Graphics 14" 2.5K 1600P IPS WVA AG Display FP Reader Backlit KB W11 (Ice Blue, NEW)',
  '',
  375000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-14-plus-db14250-ultra-9-laptop-pakistan.png',
  'https://www.paklap.pk/dell-14-plus-db14250-ultra-9-laptop-pakistan.html',
  'dell-14-plus-db14250-ultra-9-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-14-plus-db14250-ultra-9-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Microsoft Surface Studio 2 Laptop - 13th Gen Core i7 13700H Processor 16-GB 512-GB SSD 6-GB Nvidia Geforce RTX 4050 GDDR6 GC 14.4" PixelSense Touchscreen Flow Display Dolby Atmos Audio Backlit KB W11 (Platinum, NEW)',
  '',
  395000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/microsoft-surface-studio-2-13th-gen-core-i7-rtx-4050-laptop-pakistan.png',
  'https://www.paklap.pk/microsoft-surface-studio-2-13th-gen-core-i7-rtx-4050-laptop-pakistan.html',
  'microsoft-surface-studio-2-13th-gen-core-i7-rtx-4050-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'microsoft-surface-studio-2-13th-gen-core-i7-rtx-4050-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP Omen 16 AM0361TX Laptop - Intel Core Ultra 7 255H Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 16" 2K 1200P IPS 400nits Display DTS:X Ultra Audio Backlit KB TPM (Shadow Black, NEW)',
  '',
  395000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-omen-16-am0361tx-ultra-7-rtx-5060-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-omen-16-am0361tx-ultra-7-rtx-5060-gaming-laptop-pakistan.html',
  'hp-omen-16-am0361tx-ultra-7-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-omen-16-am0361tx-ultra-7-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Dell 14 Plus DB04250 2-in-1 Laptop - Intel Core Ultra 9 288V 8-Core Processor 32-GB 1-TB SSD Intel Arc Graphics 14" FHD+ 1200P IPS Touchscreen Convertible Display Backlit KB FP Reader W11 (Ice Blue, NEW)',
  '',
  405000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/dell-14-plus-db04250-ultra-9-laptop-pakistan.jpg',
  'https://www.paklap.pk/dell-14-plus-db04250-ultra-9-laptop-pakistan.html',
  'dell-14-plus-db04250-ultra-9-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'dell-14-plus-db04250-ultra-9-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 15 Gaming Laptop - Raptor Lake - 14th Gen Core i7 14700HX 20-Core Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5050 GDDR7 GC 15.1" WQXGA 1600p OLED IPS 165Hz Display Nahimic Audio RGB Backlit KB TPM W11 (Eclipse Black, NEW)',
  '',
  420000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-14th-gen-core-i7-rtx-5050-gpu-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-14th-gen-core-i7-rtx-5050-gpu-gaming-laptop-pakistan.html',
  'lenovo-legion-5-14th-gen-core-i7-rtx-5050-gpu-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-14th-gen-core-i7-rtx-5050-gpu-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 15 Gaming Laptop - AMD Ryzen AI 7 260 Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 15.3" WQXGA 1200P IPS 300nits AG Display Nahimic Audio Backlit KB W11 (Eclipse Black, NEW)',
  '',
  420000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-15-ryzen-ai-7-rtx-5060-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-15-ryzen-ai-7-rtx-5060-gaming-laptop-pakistan.html',
  'lenovo-legion-5-15-ryzen-ai-7-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-15-ryzen-ai-7-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 15 Gaming Laptop - Raptor Lake - 14th Gen Core i7 14700HX 20-Core Processor 16-GB 512-GB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 15.1" WQXGA 1600p OLED IPS 165Hz Display Nahimic Audio RGB Backlit KB TPM W11 (Eclipse Black, NEW)',
  '',
  435000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-14th-gen-ci7-rtx-5060-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-14th-gen-ci7-rtx-5060-gaming-laptop-pakistan.html',
  'lenovo-legion-5-14th-gen-ci7-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-14th-gen-ci7-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 16 - Raptor Lake - 13th Gen Core i7 13650HX 14-Core Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 4060 GDDR6 GC 16" WQXGA 1600P IPS Dolby Vision AG Display Nahimic Audio 4-Zone RGB BKB (Luna Grey, Lenovo Direct Local Warranty, NEW)',
  '',
  445000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-16-13th-gen-core-i7-rtx-4060-gpu-gaming-laptop-price-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-16-13th-gen-core-i7-rtx-4060-gpu-gaming-laptop-price-pakistan.html',
  'lenovo-legion-5-16-13th-gen-core-i7-rtx-4060-gpu-gaming-laptop-price-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-16-13th-gen-core-i7-rtx-4060-gpu-gaming-laptop-price-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP OMEN 17 DB1006NR Gaming Laptop - AMD Ryzen AI 9 365 Processor 32-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5070 GDDR7 GC 17.3" QHD 1440P IPS Micro-Edge AG Display DTS:X® Ultra Audio RGB Backlit KB TPM W11 (Shadow Black, Open Box)',
  '',
  450000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-omen-17-db1006nr-ryzen-ai-9-rtx-5070-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/hp-omen-17-db1006nr-ryzen-ai-9-rtx-5070-laptop-2026-pakistan.html',
  'hp-omen-17-db1006nr-ryzen-ai-9-rtx-5070-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-omen-17-db1006nr-ryzen-ai-9-rtx-5070-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 15 Gaming Laptop - Raptor Lake - 13th Gen Core i7 13650HX Processor 32-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 15.3" WUXGA 1200P IPS 300nits 165Hz AG Display Nahimic Audio Backlit KB W11 (Eclipse Black, NEW)',
  '',
  450000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-15-13th-gen-core-i7-rtx-5060-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-15-13th-gen-core-i7-rtx-5060-gaming-laptop-pakistan.html',
  'lenovo-legion-5-15-13th-gen-core-i7-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-15-13th-gen-core-i7-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 15 - Arrow Lake - Intel Core Ultra 7 255HX 20-Core Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 15.1" WQXGA 1600p OLED 165Hz Display Nahimic Audio RGB Backlit KB TPM W11 (Eclipse Black, NEW)',
  '',
  455000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-15-core-ultra-7-rtx-5060-gaming-laptop-pakistan.png',
  'https://www.paklap.pk/lenovo-legion-5-15-core-ultra-7-rtx-5060-gaming-laptop-pakistan.html',
  'lenovo-legion-5-15-core-ultra-7-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-15-core-ultra-7-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Thinkpad T14 Gen 6 - Arrow Lake - Intel Core Ultra 7 255U 12-Core Processor 16-GB 512-GB SSD Integrated Intel Graphics 14" WUXGA 1200p IPS AG 400nits AG Display Dolby Audio BKB FPR TPM 2.0 (Black, Lenovo 3 Years Direct Local Warranty, NEW)',
  '',
  485000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-thinkpad-t14-gen-6-intel-core-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-thinkpad-t14-gen-6-intel-core-ultra-7-laptop-pakistan.html',
  'lenovo-thinkpad-t14-gen-6-intel-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-thinkpad-t14-gen-6-intel-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP OMEN 16 AN0119NR Slim Gaming Laptop - Intel Core Ultra 9 285H Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX5070 GDDR7 GC 16" WQXGA IPS 240Hz MicroEdge AG Display DTS:X® Ultra Audio Backlit KB W11 TPM (Shadow Black, NEW)',
  '',
  490000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-omen-slim-gaming-16-an0119nr-core-ultra-9-nvidia-rtx-5070-gpu-pakistan.jpg',
  'https://www.paklap.pk/hp-omen-slim-gaming-16-an0119nr-core-ultra-9-nvidia-rtx-5070-gpu-pakistan.html',
  'hp-omen-slim-gaming-16-an0119nr-core-ultra-9-nvidia-rtx-5070-gpu-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-omen-slim-gaming-16-an0119nr-core-ultra-9-nvidia-rtx-5070-gpu-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 16 - Arrow Lake - Intel Core Ultra 9 275HX Processor 32-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 16" WQXGA 1600p IPS 240Hz G-Sync Display Nahimic Audio RGB Backlit KB W11 (Storm Grey, NEW)',
  '',
  505000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-16-core-ultra-9-rtx-5060-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-16-core-ultra-9-rtx-5060-gaming-laptop-pakistan.html',
  'lenovo-legion-5-16-core-ultra-9-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-16-core-ultra-9-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion Pro 5 16 Gaming Laptop - AMD Ryzen 9 9955HX Processor 16-GB 2-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 16" WQXGA 1600P OLED Dolby Vision G-SYNC Nahimic Audio 24-Zone RGB Backlit KB W11 (Eclipse Black, NEW)',
  '',
  510000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-pakistan.html',
  'lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion 5 15 Gaming Laptop - AMD Ryzen AI 7 350 Processor 16-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5070 GDDR7 GC 15.1" WQXGA 1600P OLED 165Hz Display Nahimic Audio 24-Zone RGB Backlit KB W11 (Eclipse Black, NEW)',
  '',
  510000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-5-15-ryzen-ai-7-rtx-5070-gaming-laptop-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-5-15-ryzen-ai-7-rtx-5070-gaming-laptop-pakistan.html',
  'lenovo-legion-5-15-ryzen-ai-7-rtx-5070-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-5-15-ryzen-ai-7-rtx-5070-gaming-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion Pro 5 16 Gaming Laptop - AMD Ryzen 9 8945HX Processor 32-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5060 GDDR7 GC 16" WQXGA 1600P IPS 240Hz Dolby Vision Display Nahimic Audio 24-Zone RGB Backlit W11 (Eclipse Black, NEW)',
  '',
  510000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-2026-pakistan.html',
  'lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-pro-5-16-ryzen-9-rtx-5060-gaming-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'HP OmniBook Ultra Flip 14 FH0068TU - Lunar Lake - Intel Core Ultra 7 258V Processor 32-GB 1-TB SSD 8-GB Intel Arc 140V Graphics 14" 3k 1800p OLED x360 Touchscreen Convertible Display BKB PolyStudio Audio W11 (Eclipse Gray, HP Direct Local Warranty, NEW)',
  '',
  525000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/hp-omnibook-ultra-flip-14-fh0068tu-intel-core-ultra-7-laptop-pakistan.jpg',
  'https://www.paklap.pk/hp-omnibook-ultra-flip-14-fh0068tu-intel-core-ultra-7-laptop-pakistan.html',
  'hp-omnibook-ultra-flip-14-fh0068tu-intel-core-ultra-7-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'hp-omnibook-ultra-flip-14-fh0068tu-intel-core-ultra-7-laptop-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion Pro 5 16 Gaming Laptop - Arrow Lake - Intel Core Ultra 9 275HX Processor 32-GB 1-TB SSD 8-GB NVIDIA GeForce RTX 5070 GDDR7 GC 16" WQXGA 1600P OLED 165Hz Dolby Vision Display Nahimic Audio 24-Zone RGB Backlit KB W11 (Eclipse Black, NEW)',
  '',
  650000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-pro-5-16-ultra-9-rtx-5070-gaming-laptop-2026-pakistan.jpg',
  'https://www.paklap.pk/lenovo-legion-pro-5-16-ultra-9-rtx-5070-gaming-laptop-2026-pakistan.html',
  'lenovo-legion-pro-5-16-ultra-9-rtx-5070-gaming-laptop-2026-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-pro-5-16-ultra-9-rtx-5070-gaming-laptop-2026-pakistan'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, source_url, legacy_demo_id, listing_badge, is_online)
select
  'Lenovo Legion Pro 7 - Arrow Lake - Intel Core Ultra 9 275HX Processor 64-GB 2-TB SSD 24-GB NVIDIA GeForce RTX5090 GDDR7 GC 16" WQXGA 1600p OLED 240Hz G-Sync Display Nahimic Audio Per-key RGB BKB (Eclipse Black, NEW)',
  '',
  1350000.00,
  5,
  (select id from public.categories where slug = 'laptop' limit 1),
  '/products/laptops/lenovo-legion-pro-7-core-ultra-9-rtx-5090-gpu-gaming-laptop-pakistan.png',
  'https://www.paklap.pk/lenovo-legion-pro-7-core-ultra-9-rtx-5090-gpu-gaming-laptop-pakistan.html',
  'lenovo-legion-pro-7-core-ultra-9-rtx-5090-gpu-gaming-laptop-pakistan',
  null,
  true
where not exists (
  select 1 from public.inventory_products x where x.legacy_demo_id = 'lenovo-legion-pro-7-core-ultra-9-rtx-5090-gpu-gaming-laptop-pakistan'
);
