-- Paklap Apple Products catalog (scraped from paklap.pk/apple-products.html).
-- Replaces all products in the Apple Products category.

delete from public.inventory_products
where category_id = (select id from public.categories where slug = 'apple-products' limit 1);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Pencil Type C (MUWA3, White)',
  'Reference listing: https://www.paklap.pk/apple-pencil-type-c-white-price-reviews-pakistan.html',
  31500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-pencil-type-c-white-price-reviews-pakistan-1.jpg',
  array['/products/apple/apple-pencil-type-c-white-price-reviews-pakistan-1.jpg', '/products/apple/apple-pencil-type-c-white-price-reviews-pakistan-2.jpg']::text[],
  'https://www.paklap.pk/apple-pencil-type-c-white-price-reviews-pakistan.html',
  'apple-pencil-type-c-white-price-reviews-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"No Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-pencil-type-c-white-price-reviews-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Air Tag (MX542 - Pack of 4)',
  'Reference listing: https://www.paklap.pk/apple-airtag-price-reviews-pakistan.html',
  31900.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airtag-price-reviews-pakistan-1.jpg',
  array['/products/apple/apple-airtag-price-reviews-pakistan-1.jpg', '/products/apple/apple-airtag-price-reviews-pakistan-2.jpg', '/products/apple/apple-airtag-price-reviews-pakistan-3.jpg', '/products/apple/apple-airtag-price-reviews-pakistan-4.jpg', '/products/apple/apple-airtag-price-reviews-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-airtag-price-reviews-pakistan.html',
  'apple-airtag-price-reviews-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Color","value":"White"},{"label":"Warranty","value":"No Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airtag-price-reviews-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Airpods Pro with Magsafe Charging Case 2021 (MLWK3)',
  'Reference listing: https://www.paklap.pk/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi.html',
  34999.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-1.jpg',
  array['/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-1.jpg', '/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-2.jpg', '/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-3.jpg', '/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-4.jpg', '/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-5.jpg', '/products/apple/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi-6.jpg']::text[],
  'https://www.paklap.pk/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi.html',
  'apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Color","value":"White"},{"label":"Warranty","value":"01 Year Apple International Manufacturer Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airpods-pro-2021-price-reviews-pakistan-lahore-karachi.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple AirPods 4 With Type C Charging (White)',
  'Reference listing: https://www.paklap.pk/apple-airpods-4-price-pakistan.html',
  40000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airpods-4-price-pakistan-1.jpg',
  array['/products/apple/apple-airpods-4-price-pakistan-1.jpg', '/products/apple/apple-airpods-4-price-pakistan-2.jpg', '/products/apple/apple-airpods-4-price-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-airpods-4-price-pakistan.html',
  'apple-airpods-4-price-pakistan',
  true,
  '[{"label":"Color","value":"White"},{"label":"Category","value":"Airpods"},{"label":"Charging","value":"USB - C"},{"label":"Sensors","value":"Dual beamforming microphones, Inward-facing microphone, Optical in-ear sensor, Motion-detecting accelerometer,Speech-detecting accelerometer, Force sensor"},{"label":"Chip","value":"H2 Chip"},{"label":"Connectivity","value":"Bluetooth 5.3"},{"label":"Water Resistant","value":"No"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airpods-4-price-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Pencil Pro (MX2D3, 2024)',
  'Reference listing: https://www.paklap.pk/apple-pencil-pro-price-reviews-paksitan.html',
  40000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-pencil-pro-price-reviews-paksitan-1.jpg',
  array['/products/apple/apple-pencil-pro-price-reviews-paksitan-1.jpg', '/products/apple/apple-pencil-pro-price-reviews-paksitan-2.jpg']::text[],
  'https://www.paklap.pk/apple-pencil-pro-price-reviews-paksitan.html',
  'apple-pencil-pro-price-reviews-paksitan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"No Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-pencil-pro-price-reviews-paksitan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Magic Keyboard USB-C (MXCL3)',
  'Reference listing: https://www.paklap.pk/apple-magic-keyboard-mxcl3-pakistan.html',
  45000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-magic-keyboard-mxcl3-pakistan-1.jpg',
  array['/products/apple/apple-magic-keyboard-mxcl3-pakistan-1.jpg', '/products/apple/apple-magic-keyboard-mxcl3-pakistan-2.jpg', '/products/apple/apple-magic-keyboard-mxcl3-pakistan-3.jpg', '/products/apple/apple-magic-keyboard-mxcl3-pakistan-4.jpg', '/products/apple/apple-magic-keyboard-mxcl3-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-magic-keyboard-mxcl3-pakistan.html',
  'apple-magic-keyboard-mxcl3-pakistan',
  true,
  '[{"label":"Brand","value":"A4-Tech"},{"label":"Keyboardtype","value":"Wireless"},{"label":"Color","value":"White"},{"label":"Connectivity","value":"USB"},{"label":"USB","value":"Yes"},{"label":"Backlight","value":"No"},{"label":"Warranty","value":"International Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-magic-keyboard-mxcl3-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Magic Multi-Touch Surface Wireless Mouse USB-C (Black, MXK63, NEW)',
  'Reference listing: https://www.paklap.pk/apple-magic-mouse-mxk63-black-pakistan.html',
  49999.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-magic-mouse-mxk63-black-pakistan-1.jpg',
  array['/products/apple/apple-magic-mouse-mxk63-black-pakistan-1.jpg', '/products/apple/apple-magic-mouse-mxk63-black-pakistan-2.jpg', '/products/apple/apple-magic-mouse-mxk63-black-pakistan-3.jpg', '/products/apple/apple-magic-mouse-mxk63-black-pakistan-4.jpg', '/products/apple/apple-magic-mouse-mxk63-black-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-magic-mouse-mxk63-black-pakistan.html',
  'apple-magic-mouse-mxk63-black-pakistan',
  true,
  '[{"label":"Connection Type","value":"Wireless"},{"label":"DPI","value":"1000 DPI"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"International Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-magic-mouse-mxk63-black-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple AirPods 4 ANC With Type C Charging (White)',
  'Reference listing: https://www.paklap.pk/apple-airpods-4-anc-price-pakistan.html',
  50000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airpods-4-anc-price-pakistan-1.jpg',
  array['/products/apple/apple-airpods-4-anc-price-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-airpods-4-anc-price-pakistan.html',
  'apple-airpods-4-anc-price-pakistan',
  true,
  '[{"label":"Color","value":"White"},{"label":"Category","value":"Airpods"},{"label":"Charging","value":"USB - C"},{"label":"Sensors","value":"Dual beamforming microphones, Inward-facing microphone, Optical in-ear sensor, Motion-detecting accelerometer,Speech-detecting accelerometer, Force sensor"},{"label":"Chip","value":"H2 Chip"},{"label":"Connectivity","value":"Bluetooth 5.3"},{"label":"Water Resistant","value":"No"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airpods-4-anc-price-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Airpods 3rd Generation with Charging Case (White)',
  'Reference listing: https://www.paklap.pk/apple-airpods-3rd-generation-price-pakistan.html',
  68500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airpods-3rd-generation-price-pakistan-1.jpg',
  array['/products/apple/apple-airpods-3rd-generation-price-pakistan-1.jpg', '/products/apple/apple-airpods-3rd-generation-price-pakistan-2.jpg', '/products/apple/apple-airpods-3rd-generation-price-pakistan-3.jpg', '/products/apple/apple-airpods-3rd-generation-price-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-airpods-3rd-generation-price-pakistan.html',
  'apple-airpods-3rd-generation-price-pakistan',
  true,
  '[{"label":"Color","value":"White"},{"label":"Category","value":"Airpods"},{"label":"Charging","value":"Charging Case"},{"label":"Sensors","value":"Dual Beamforming Microphones, Inward-Facing Microphone, Skin-Detect Sensor, Force Sensor, Motion-Speach-Accelerometer"},{"label":"Chip","value":"H1 Chip"},{"label":"Connectivity","value":"Bluetooth 5.0"},{"label":"Water Resistant","value":"Yes"},{"label":"Size","value":"Height: 1.21-inches, Width: 0.72-inch, Depth: 0.76 inch"},{"label":"Weight","value":"1lbs"},{"label":"Warranty","value":"International"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airpods-3rd-generation-price-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MDFW4 Magic Keyboard iPad Air 13" Trackpad (7th & 8th Models, White)',
  'Reference listing: https://www.paklap.pk/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan.html',
  95000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan-1.jpg',
  array['/products/apple/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan-1.jpg', '/products/apple/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan-2.jpg', '/products/apple/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan-3.jpg', '/products/apple/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan-4.jpg', '/products/apple/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan.html',
  'apple-mdfw4-magic-keyboard-ipad-white-price-pakistan',
  true,
  '[{"label":"Brand","value":"A4-Tech"},{"label":"Color","value":"White"},{"label":"Backlight","value":"Yes"},{"label":"Warranty","value":"1 Year International Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-mdfw4-magic-keyboard-ipad-white-price-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Watch Series 10 42mm with Sport Band (Silver)',
  'Reference listing: https://www.paklap.pk/apple-watch-series-10-42mm-with-sport-band-silver-price-reviews-pakistan.html',
  115000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-watch-series-10-42mm-with-sport-band-silver-price-reviews-pakistan-1.jpg',
  array['/products/apple/apple-watch-series-10-42mm-with-sport-band-silver-price-reviews-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-watch-series-10-42mm-with-sport-band-silver-price-reviews-pakistan.html',
  'apple-watch-series-10-42mm-with-sport-band-silver-price-reviews-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Series","value":"Series 10"},{"label":"Dial Size","value":"42-MM"},{"label":"Screen Type","value":"OLED"},{"label":"Water Protection","value":"Yes"},{"label":"Siri Control","value":"Yes"},{"label":"Operating System","value":"Android"},{"label":"Color","value":"Silver"},{"label":"Warranty","value":"No Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-watch-series-10-42mm-with-sport-band-silver-price-reviews-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad 11 Generation A16 Chip 11-Inch Liquid Retina Display (128GB, WiFi, Blue, 2025)',
  'Reference listing: https://www.paklap.pk/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan.html',
  115500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-1.jpg',
  array['/products/apple/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-1.jpg', '/products/apple/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-2.jpg', '/products/apple/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan.html',
  'apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad"},{"label":"iPad Generation","value":"11th Generation"},{"label":"Chipset","value":"A16"},{"label":"Storage","value":"128GB"},{"label":"Screen Size","value":"11 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Selfie Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Sensors","value":"Touch ID Three‐axis gyro Accelerometer Barometer Ambient light sensor"},{"label":"Color","value":"Blue"},{"label":"Warranty","value":"International Warranty"},{"label":"Processor Type","value":"A16 chip 5-core CPU"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"1.05 pounds"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-11-generation-a16-chip-11-inch-display-blue-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Watch Series 10 46mm with Sport Band (Rose Gold)',
  'Reference listing: https://www.paklap.pk/apple-watch-series-10-46mm-sport-band-rose-gold-pakistan.html',
  121900.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-watch-series-10-46mm-sport-band-rose-gold-pakistan-1.jpg',
  array['/products/apple/apple-watch-series-10-46mm-sport-band-rose-gold-pakistan-1.jpg', '/products/apple/apple-watch-series-10-46mm-sport-band-rose-gold-pakistan-2.jpg']::text[],
  'https://www.paklap.pk/apple-watch-series-10-46mm-sport-band-rose-gold-pakistan.html',
  'apple-watch-series-10-46mm-sport-band-rose-gold-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Series","value":"Series 10"},{"label":"Screen Type","value":"OLED"},{"label":"Water Protection","value":"Yes"},{"label":"Siri Control","value":"Yes"},{"label":"Operating System","value":"IOS"},{"label":"Color","value":"Rose Gold"},{"label":"Warranty","value":"No Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-watch-series-10-46mm-sport-band-rose-gold-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Airpods Max 2nd Generation Wireless Headphones (Midnight)',
  'Reference listing: https://www.paklap.pk/apple-airpods-max-2nd-gen-black-pakistan.html',
  178000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airpods-max-2nd-gen-black-pakistan-1.jpg',
  array['/products/apple/apple-airpods-max-2nd-gen-black-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-airpods-max-2nd-gen-black-pakistan.html',
  'apple-airpods-max-2nd-gen-black-pakistan',
  true,
  '[{"label":"Color","value":"Black"},{"label":"Category","value":"Airpods Max"},{"label":"Charging","value":"USB - C"},{"label":"Sensors","value":"Optical sensor (each ear cup), Position sensor (each ear cup), Case-detect sensor (each ear cup), Accelerometer (each ear cup), Gyroscope (left ear cup)"},{"label":"Chip","value":"H1 Chip"},{"label":"Connectivity","value":"Bluetooth 5.0"},{"label":"Water Resistant","value":"No"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airpods-max-2nd-gen-black-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Airpods Max 2nd Generation Wireless Headphones (Purple)',
  'Reference listing: https://www.paklap.pk/apple-airpods-max-2nd-gen-purple-pakistan.html',
  178000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-airpods-max-2nd-gen-purple-pakistan-1.jpg',
  array['/products/apple/apple-airpods-max-2nd-gen-purple-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-airpods-max-2nd-gen-purple-pakistan.html',
  'apple-airpods-max-2nd-gen-purple-pakistan',
  true,
  '[{"label":"Color","value":"Purple"},{"label":"Category","value":"Airpods Max"},{"label":"Charging","value":"USB - C"},{"label":"Sensors","value":"Optical sensor (each ear cup), Position sensor (each ear cup), Case-detect sensor (each ear cup), Accelerometer (each ear cup), Gyroscope (left ear cup)"},{"label":"Chip","value":"H1 Chip"},{"label":"Connectivity","value":"Bluetooth 5.0"},{"label":"Water Resistant","value":"No"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-airpods-max-2nd-gen-purple-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad Air 8th Generation M4 Chip 11-Inch Display (128GB, WiFi, Purple, 2026)',
  'Reference listing: https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan.html',
  189000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan-1.png',
  array['/products/apple/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan-1.png']::text[],
  'https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan.html',
  'apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad Air"},{"label":"iPad Generation","value":"8th Generation"},{"label":"Chipset","value":"M4"},{"label":"Storage","value":"128GB"},{"label":"Screen Size","value":"11 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Color","value":"Purple"},{"label":"Warranty","value":"International Warranty"},{"label":"Processor Type","value":"8-core CPU"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"1.03 pounds"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-11-inch-display-purple-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Mac Mini MGNT3 - M1 Chip with 8-core CPU & GPU 08GB 512GB SSD Silver (2020)',
  'Reference listing: https://www.paklap.pk/apple-mac-mini-mgnt3-m1-chip-price-pakistan.html',
  191000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-mac-mini-mgnt3-m1-chip-price-pakistan-1.jpg',
  array['/products/apple/apple-mac-mini-mgnt3-m1-chip-price-pakistan-1.jpg', '/products/apple/apple-mac-mini-mgnt3-m1-chip-price-pakistan-2.jpg', '/products/apple/apple-mac-mini-mgnt3-m1-chip-price-pakistan-3.jpg', '/products/apple/apple-mac-mini-mgnt3-m1-chip-price-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-mac-mini-mgnt3-m1-chip-price-pakistan.html',
  'apple-mac-mini-mgnt3-m1-chip-price-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M1 Chip"},{"label":"RAM","value":"8 GB"},{"label":"SSD","value":"512 GB SSD"},{"label":"Graphic Series","value":"8 - Core GPU"},{"label":"Color","value":"Silver"},{"label":"CPU","value":"8 - Core CPU"},{"label":"Warranty","value":"International"},{"label":"Operating System","value":"MAC OS"},{"label":"Condition","value":"New"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-mac-mini-mgnt3-m1-chip-price-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Neo 13 MHFA4 - Apple A18 Pro Chip 6-Core CPU 5-Core GPU 8-GB 256-GB SSD 13-Inch IPS Liquid Retina Display Magic KB (Silver, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan.html',
  214500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan-1.jpg',
  array['/products/apple/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan-1.jpg', '/products/apple/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan-2.jpg', '/products/apple/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan-3.jpg', '/products/apple/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan.html',
  'apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple A18 Pro Chip"},{"label":"Processor Type","value":"Apple A18 Pro Chip"},{"label":"Processor Speed","value":"6‑Core CPU, 5‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"8 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"256 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"256 GB SSD"},{"label":"Type of harddrive","value":"256 GB SSD Solid State Drive"},{"label":"Dedicated graphics","value":"Apple A18 Pro Chip"},{"label":"Graphics memory","value":"5 - Core GPU"},{"label":"Type of graphics memory","value":"Apple A18 Pro Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple A18 Pro Chip"},{"label":"Backlight","value":"No"},{"label":"Screen size","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2408 x 1506"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Silver"},{"label":"RAM","value":"8 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.23 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Magic Keyboard (78 ANSI / 79 ISO keys) including 12 full-height function keys, precise Multi-Touch trackpad with gesture support, wireless connectivity, and rechargeable battery (No Touch ID)"},{"label":"Bluetooth","value":"Bluetooth 6"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)5"},{"label":"Condition","value":"New"},{"label":"USB","value":"1x USB Type-C (USB 3) Port – 10Gbps, Charging & DisplayPort Support 1x USB Type-C (USB 2) Port – 480Mbps, Charging Support"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-neo-13-mhfa4-a18-pro-chip-laptop-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Neo 13 MHFF4 - Apple A18 Pro Chip 6-Core CPU 5-Core GPU 8-GB 256-GB SSD 13-Inch IPS Liquid Retina Display Magic KB (Indigo, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan.html',
  214500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan-1.jpg',
  array['/products/apple/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan-1.jpg', '/products/apple/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan-2.jpg', '/products/apple/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan-3.jpg', '/products/apple/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan.html',
  'apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple A18 Pro Chip"},{"label":"Processor Type","value":"Apple A18 Pro Chip"},{"label":"Processor Speed","value":"6‑Core CPU, 5‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"8 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"256 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"256 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Dedicated graphics","value":"Apple A18 Pro Chip"},{"label":"Graphics memory","value":"5 - Core GPU"},{"label":"Type of graphics memory","value":"Apple A18 Pro Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple A18 Pro Chip"},{"label":"Backlight","value":"No"},{"label":"Screen size","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2408 x 1506"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Black"},{"label":"RAM","value":"8 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.23 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Magic Keyboard 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Multi-Touch trackpad for precise cursor control and support for gestures"},{"label":"Bluetooth","value":"Bluetooth 6"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)5"},{"label":"Condition","value":"New"},{"label":"USB","value":"1x USB Type-C (USB 3) Port – 10Gbps, Charging & DisplayPort Support 1x USB Type-C (USB 2) Port – 480Mbps, Charging Support"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-neo-13-mhff4-a18-pro-chip-laptop-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Neo 13 MHFD4 - Apple A18 Pro Chip 6-Core CPU 5-Core GPU 8-GB 256-GB SSD 13-Inch IPS Liquid Retina Display Magic KB (Citrus, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan.html',
  218500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan-1.png',
  array['/products/apple/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan-1.png', '/products/apple/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan-2.png', '/products/apple/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan-3.png']::text[],
  'https://www.paklap.pk/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan.html',
  'apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple A18 Pro Chip"},{"label":"Processor Type","value":"Apple A18 Pro Chip"},{"label":"Processor Speed","value":"6‑Core CPU, 5‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"8 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"256 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"256 GB SSD"},{"label":"Type of harddrive","value":"256 GB SSD Solid State Drive"},{"label":"Dedicated graphics","value":"Apple A18 Pro Chip"},{"label":"Graphics memory","value":"5 - Core GPU"},{"label":"Type of graphics memory","value":"Apple A18 Pro Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple A18 Pro Chip"},{"label":"Backlight","value":"No"},{"label":"Screen size","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2408 x 1506"},{"label":"Touchscreen","value":"No"},{"label":"RAM","value":"8 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.23 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Magic Keyboard (78 ANSI / 79 ISO keys) including 12 full-height function keys, precise Multi-Touch trackpad with gesture support, wireless connectivity, and rechargeable battery (No Touch ID)"},{"label":"Bluetooth","value":"Bluetooth 6"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)5"},{"label":"Condition","value":"New"},{"label":"USB","value":"1x USB Type-C (USB 3) Port – 10Gbps, Charging & DisplayPort Support 1x USB Type-C (USB 2) Port – 480Mbps, Charging Support"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-neo-13-mhfda-a18-pro-chip-laptop-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad Air 8th Generation M4 Chip 11-Inch Display (256GB, WiFi, Starlight, 2026)',
  'Reference listing: https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-11-inch-display-starlight-2026-pakistan.html',
  231000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-air-8th-gen-m4-chip-11-inch-display-starlight-2026-pakistan-1.png',
  array['/products/apple/apple-ipad-air-8th-gen-m4-chip-11-inch-display-starlight-2026-pakistan-1.png']::text[],
  'https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-11-inch-display-starlight-2026-pakistan.html',
  'apple-ipad-air-8th-gen-m4-chip-11-inch-display-starlight-2026-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad Air"},{"label":"iPad Generation","value":"8th Generation"},{"label":"Chipset","value":"M4"},{"label":"Storage","value":"256GB"},{"label":"Screen Size","value":"11 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Selfie Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Sensors","value":"Touch ID Three‐axis gyro Accelerometer Barometer Ambient light sensor"},{"label":"Color","value":"Starlight"},{"label":"Warranty","value":"International Warranty"},{"label":"Processor Type","value":"8-core CPU"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"1.03 pounds"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-11-inch-display-starlight-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Ultra 3 Watch 49mm Always-On Retina Display Natural Titanium Case With Blue Ocean Band (2025, NEW)',
  'Reference listing: https://www.paklap.pk/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan.html',
  236500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan-1.jpg',
  array['/products/apple/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan-1.jpg', '/products/apple/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan-2.jpg', '/products/apple/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan.html',
  'apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Dial Size","value":"49-MM"},{"label":"Screen Type","value":"Always-On Retina display"},{"label":"Water Protection","value":"Yes"},{"label":"Siri Control","value":"Yes"},{"label":"Operating System","value":"IOS"},{"label":"Color","value":"Blue"},{"label":"Warranty","value":"1 Year International Warranty"},{"label":"Sensors","value":"Electrical heart sensor Third-generation optical heart sensor Blood oxygen sensor1 Temperature sensor2 Depth gauge Water temperature sensor Compass Always-on altimeter High-g accelerometer High dynamic range gyroscope Ambient light sensor"},{"label":"Weight","value":"61.6 grams"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ultra-3-watch-natural-titanium-case-with-blue-ocean-band-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Ultra 3 Watch 49mm Always-On Retina Display Black Titanium Case With Black Ocean Band (2025, NEW)',
  'Reference listing: https://www.paklap.pk/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan.html',
  236500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan-1.jpg',
  array['/products/apple/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan-1.jpg', '/products/apple/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan-2.jpg', '/products/apple/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan.html',
  'apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Dial Size","value":"49-MM"},{"label":"Screen Type","value":"Always-On Retina display"},{"label":"Water Protection","value":"Yes"},{"label":"Siri Control","value":"Yes"},{"label":"Operating System","value":"IOS"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"1 Year International Warranty"},{"label":"Sensors","value":"Electrical heart sensor Third-generation optical heart sensor Blood oxygen sensor1 Temperature sensor2 Depth gauge Water temperature sensor Compass Always-on altimeter High-g accelerometer High dynamic range gyroscope Ambient light sensor"},{"label":"Weight","value":"61.6 grams"},{"label":"Operating System","value":"iOS"},{"label":"Warranty","value":"1 Year International Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ultra-3-watch-black-titanium-case-with-black-ocean-band-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Ultra 3 Watch 49mm Always-On Retina Display Black Titanium Case With Charcol Trail Loop Band (2025, NEW)',
  'Reference listing: https://www.paklap.pk/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan.html',
  236500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan-1.jpg',
  array['/products/apple/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan-1.jpg', '/products/apple/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan-2.jpg', '/products/apple/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan.html',
  'apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Dial Size","value":"49-MM"},{"label":"Screen Type","value":"Always-On Retina display"},{"label":"Water Protection","value":"Yes"},{"label":"Siri Control","value":"Yes"},{"label":"Operating System","value":"IOS"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"1 Year International Warranty"},{"label":"Sensors","value":"Electrical heart sensor Third-generation optical heart sensor Blood oxygen sensor1 Temperature sensor2 Depth gauge Water temperature sensor Compass Always-on altimeter High-g accelerometer High dynamic range gyroscope Ambient light sensor"},{"label":"Weight","value":"61.6 grams"},{"label":"Operating System","value":"iOS"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ultra-3-watch-black-titanium-case-with-charcol-trail-loop-band-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Ultra 3 Watch 49mm Always-On Retina Display Natural Titanium Case With Light Blue Alpine Band (2025, NEW)',
  'Reference listing: https://www.paklap.pk/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan.html',
  237500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan-1.jpg',
  array['/products/apple/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan-1.jpg', '/products/apple/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan-2.jpg', '/products/apple/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan.html',
  'apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Dial Size","value":"49-MM"},{"label":"Screen Type","value":"Always-On Retina display"},{"label":"Water Protection","value":"Yes"},{"label":"Siri Control","value":"Yes"},{"label":"Operating System","value":"IOS"},{"label":"Color","value":"Blue"},{"label":"Warranty","value":"1 Year International Warranty"},{"label":"Sensors","value":"Electrical heart sensor Third-generation optical heart sensor Blood oxygen sensor1 Temperature sensor2 Depth gauge Water temperature sensor Compass Always-on altimeter High-g accelerometer High dynamic range gyroscope Ambient light sensor"},{"label":"Weight","value":"61.6 grams"},{"label":"Warranty","value":"1 Year International Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ultra-3-watch-natural-titanium-case-with-light-blue-alpine-band-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Neo 13 MHFJ4 - Apple A18 Pro Chip 6-Core CPU 5-Core GPU 8-GB 512-GB SSD 13-Inch IPS Liquid Retina Display Magic KB With Touch ID (Blush, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan.html',
  252000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan-1.jpg',
  array['/products/apple/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan-1.jpg', '/products/apple/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan-2.jpg', '/products/apple/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan-3.jpg', '/products/apple/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan.html',
  'apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple A18 Pro Chip"},{"label":"Processor Type","value":"Apple A18 Pro Chip"},{"label":"Processor Speed","value":"6‑Core CPU, 5‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"8 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Dedicated graphics","value":"Apple A18 Pro Chip"},{"label":"Graphics memory","value":"5 - Core GPU"},{"label":"Type of graphics memory","value":"Apple A18 Pro Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple A18 Pro Chip"},{"label":"Backlight","value":"No"},{"label":"Screen size","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2408 x 1506"},{"label":"Touchscreen","value":"No"},{"label":"RAM","value":"8 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.23 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Magic Keyboard with Touch ID 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Multi-Touch trackpad for precise cursor control and support for gestures"},{"label":"Bluetooth","value":"Bluetooth 6"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)5"},{"label":"Condition","value":"New"},{"label":"USB","value":"1x USB Type-C (USB 3) Port – 10Gbps, Charging & DisplayPort Support 1x USB Type-C (USB 2) Port – 480Mbps, Charging Support"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-neo-13-mhfj4-a18-pro-chip-laptop-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Neo 13 MHFG4 - Apple A18 Pro Chip 6-Core CPU 5-Core GPU 8-GB 512-GB SSD 13-Inch IPS Liquid Retina Display Magic KB With Touch ID (Indigo, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan.html',
  252000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan-1.jpg',
  array['/products/apple/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan-1.jpg', '/products/apple/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan-2.jpg', '/products/apple/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan-3.jpg', '/products/apple/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan.html',
  'apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple A18 Pro Chip"},{"label":"Processor Type","value":"Apple A18 Pro Chip"},{"label":"Processor Speed","value":"6‑Core CPU, 5‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"8 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Dedicated graphics","value":"Apple A18 Pro Chip"},{"label":"Graphics memory","value":"5 - Core GPU"},{"label":"Type of graphics memory","value":"Apple A18 Pro Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple A18 Pro Chip"},{"label":"Backlight","value":"No"},{"label":"Screen size","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.0-inch (diagonal) LED-backlit display with IPS technology;2 2408-by-1506 native resolution at 219 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2408 x 1506"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Black"},{"label":"RAM","value":"8 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.23 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Magic Keyboard with Touch ID 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Multi-Touch trackpad for precise cursor control and support for gestures"},{"label":"Bluetooth","value":"Bluetooth 6"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)5"},{"label":"Condition","value":"New"},{"label":"USB","value":"1x USB Type-C (USB 3) Port – 10Gbps, Charging & DisplayPort Support 1x USB Type-C (USB 2) Port – 480Mbps, Charging Support"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-neo/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-neo-13-mhfg4-a18-pro-chip-laptop-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad Air 8th Generation M4 Chip 13-Inch Liquid Retina Display (128GB, WiFi, Gray, 2026)',
  'Reference listing: https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-13-inch-display-gray-pakistan.html',
  268000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-air-8th-gen-m4-chip-13-inch-display-gray-pakistan-1.png',
  array['/products/apple/apple-ipad-air-8th-gen-m4-chip-13-inch-display-gray-pakistan-1.png']::text[],
  'https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-13-inch-display-gray-pakistan.html',
  'apple-ipad-air-8th-gen-m4-chip-13-inch-display-gray-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad Air"},{"label":"iPad Generation","value":"8th Generation"},{"label":"Chipset","value":"M4"},{"label":"Storage","value":"128GB"},{"label":"Screen Size","value":"13 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Selfie Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Sensors","value":"Touch ID Three‐axis gyro Accelerometer Barometer Ambient light sensor"},{"label":"Color","value":"Grey"},{"label":"Warranty","value":"International Warranty"},{"label":"Processor Type","value":"8-core CPU"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"1.03 pounds"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-air-8th-gen-m4-chip-13-inch-display-gray-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 13 MDHE4 - Apple M5 Chip 10-Core CPU 8-Core GPU 16-GB 512-GB SSD 13.6-Inch Liquid Retina with True Tone Display Backlit Magic KB with Touch ID (Midnight, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan.html',
  336000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan-1.jpg', '/products/apple/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan-2.jpg', '/products/apple/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan-3.jpg', '/products/apple/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan.html',
  'apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10-core CPU, 8-core GPU, 16-core Neural Engine"},{"label":"Installed RAM","value":"16 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"8 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"8 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"8 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"13.6-inch (diagonal) LED-backlit display with IPS technology;2 2560-by-1664 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.6-inch (diagonal) LED-backlit display with IPS technology;2 2560-by-1664 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2560 x 1664"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Midnight"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.23 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard with 78 (ANSI) / 79 (ISO) Keys, including 12 Full-Height Function Keys, Touch ID, and Ambient Light Sensor"},{"label":"Bluetooth","value":"Bluetooth 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)4"},{"label":"Condition","value":"New"},{"label":"USB","value":"2 × Thunderbolt 4 (USB-C) Ports with Support for Charging, DisplayPort, Thunderbolt 4 (up to 40Gb/s), and USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-13-mdhe4-m5-chip-midnight-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad Pro M5 Chip 13-Inch Ultra Retina XDR Display (256GB, WiFi, Space Black, 2026)',
  'Reference listing: https://www.paklap.pk/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan.html',
  363000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan-1.jpg',
  array['/products/apple/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan-1.jpg', '/products/apple/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan-2.jpg', '/products/apple/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan.html',
  'apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad Pro"},{"label":"Chipset","value":"M5"},{"label":"Storage","value":"256GB"},{"label":"Screen Size","value":"13 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Selfie Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Sensors","value":"Face ID LiDAR Scanner Three-axis gyro Accelerometer Barometer Ambient light sensors"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"International Warranty"},{"label":"Processor Type","value":"Apple M5 Chip 9-Core CPU"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"1.28 pounds"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-pro-m5-chip-13-inch-display-space-black-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad Pro M5 Chip 11-Inch Ultra Retina XDR Display (512GB, WiFi, Space Black, 2026)',
  'Reference listing: https://www.paklap.pk/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan.html',
  373000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan-1.jpg',
  array['/products/apple/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan-1.jpg', '/products/apple/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan-2.jpg', '/products/apple/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan.html',
  'apple-ipad-pro-m5-chip-11-inch-display-black-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad Pro"},{"label":"Chipset","value":"M5"},{"label":"Storage","value":"32GB"},{"label":"Screen Size","value":"8.3 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Selfie Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"International Warranty"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"0.98 pound"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-pro-m5-chip-11-inch-display-black-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MDV94 - Apple M5 Chip 10-Core CPU 10-Core GPU 16-GB 512-GB SSD 15.3-Inch Liquid Retina with True Tone Display Backlit Magic KB with Touch ID (Silver, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan.html',
  404500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan-4.jpg', '/products/apple/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan.html',
  'apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10-core CPU, 10-core GPU, 16-core Neural Engine"},{"label":"Installed RAM","value":"16 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"10 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Silver"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)6"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"Bluetooth 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)4"},{"label":"Condition","value":"New"},{"label":"USB","value":"2 × Thunderbolt 4 (USB-C) Ports with Support for Charging, DisplayPort, Thunderbolt 4 (up to 40Gb/s), and USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mdv94-m5-chip-silver-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MDVD4 - Apple M5 Chip 10-Core CPU 10-Core GPU 16-GB 512-GB SSD 15.3-Inch Liquid Retina with True Tone Display Backlit Magic KB with Touch ID (Starlight, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan.html',
  404500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan.html',
  'apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10-core CPU, 10-core GPU, 16-core Neural Engine"},{"label":"Installed RAM","value":"16 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"10 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x 1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Starlight"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)6"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"Bluetooth 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)4"},{"label":"Condition","value":"New"},{"label":"USB","value":"2 × Thunderbolt 4 (USB-C) Ports with Support for Charging, DisplayPort, Thunderbolt 4 (up to 40Gb/s), and USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mdvd4-m5-chip-starlight-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MC7C4 - Apple M4 Chip 10-Core CPU 10-Core GPU 16GB 512GB SSD 15.3-Inch Liquid Retina Display with IPS Technology Backlit Magic KB with Touch ID (Sky Blue, 2024)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan.html',
  409500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan.html',
  'apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M4 Chip"},{"label":"Processor Type","value":"Apple M4 Chip"},{"label":"Processor Speed","value":"10‑core CPU with 4 performance cores and 6 efficiency cores 10‑core GPU Hardware-accelerated ray tracing 16-core Neural Engine 120GB/s memory bandwidth"},{"label":"Installed RAM","value":"16GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512GB"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M4 Chip"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M4 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M4 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Sky Color"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)"},{"label":"Fingerprint Reader","value":"Yes"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Yes"},{"label":"Bluetooth","value":"Bluetooth 5.3"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)"},{"label":"Condition","value":"New"},{"label":"USB","value":"MagSafe 3 charging port 3.5 mm headphone jack Two Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mc7c4-m4-chip-sky-blue-2024-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MW1K3 - Apple M4 Chip 10-Core CPU 10-Core GPU 16-GB 512-GB SSD 15.3-Inch Liquid Retina Display IPS Technology Backlit Magic KB with Touch ID (Starlight, 2025)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan.html',
  409500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-4.jpg', '/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-5.jpg', '/products/apple/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan-6.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan.html',
  'apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M4 Chip"},{"label":"Processor Type","value":"Apple M4 Chip"},{"label":"Processor Speed","value":"10‑core CPU with 4 performance cores and 6 efficiency cores 10‑core GPU Hardware-accelerated ray tracing 16-core Neural Engine 120GB/s memory bandwidth"},{"label":"Installed RAM","value":"16GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M4 Chip"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M4 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M4 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Starlight"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)"},{"label":"Fingerprint Reader","value":"Yes"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Yes"},{"label":"Bluetooth","value":"Bluetooth 5.3"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)"},{"label":"Condition","value":"New"},{"label":"USB","value":"MagSafe 3 charging port 3.5 mm headphone jack Two Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mw1k3-m4-chip-starlight-2025-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MW1M3 - Apple M4 Chip 10-Core CPU 10-Core GPU 16GB 512GB SSD 15.3-Inch Liquid Retina Display with IPS Technology Backlit Magic KB with Touch ID (Midnight, 2025)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan.html',
  409500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-4.jpg', '/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-5.jpg', '/products/apple/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan-6.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan.html',
  'apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M4 Chip"},{"label":"Processor Type","value":"Apple M4 Chip"},{"label":"Processor Speed","value":"10‑core CPU with 4 performance cores and 6 efficiency cores 10‑core GPU Hardware-accelerated ray tracing 16-core Neural Engine 120GB/s memory bandwidth"},{"label":"Installed RAM","value":"16GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512GB"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M4 Chip"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M4 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M4 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Midnight"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)"},{"label":"Fingerprint Reader","value":"Yes"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Yes"},{"label":"Bluetooth","value":"Bluetooth 5.3"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)"},{"label":"Condition","value":"New"},{"label":"USB","value":"MagSafe 3 charging port 3.5 mm headphone jack Two Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mw1m3-m4-chip-midnight-2025-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MW1H3 - Apple M4 Chip 10-Core CPU 10-Core GPU 16-GB 512-GB SSD 15.3-Inch Liquid Retina Display IPS Technology Backlit Magic KB with Touch ID (Silver, 2025)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan.html',
  409500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-4.jpg', '/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-5.jpg', '/products/apple/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan-6.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan.html',
  'apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M4 Chip"},{"label":"Processor Type","value":"Apple M4 Chip"},{"label":"Processor Speed","value":"10‑core CPU with 4 performance cores and 6 efficiency cores 10‑core GPU Hardware-accelerated ray tracing 16-core Neural Engine 120GB/s memory bandwidth"},{"label":"Installed RAM","value":"16 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512 GB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M4 Chip"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M4 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M4 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Silver"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)"},{"label":"Fingerprint Reader","value":"Touch ID sensor"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard with: 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"Bluetooth 6"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)4"},{"label":"Condition","value":"New"},{"label":"USB","value":"MagSafe 3 charging port 3.5 mm headphone jack Two Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mw1h3-m4-chip-silver-2025-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 13 MC6V4 - Apple M4 Chip 10-Core GPU 10-Core CPU 24GB 512GB SSD 13.6-Inch Liquid Retina with True Tone Display Backlit Magic KB with Touch ID (Skyblue, 2025)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan.html',
  409500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-1.jpg', '/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-2.jpg', '/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-3.jpg', '/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-4.jpg', '/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-5.jpg', '/products/apple/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan-6.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan.html',
  'apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M4 Chip"},{"label":"Processor Type","value":"Apple M4 Chip"},{"label":"Processor Speed","value":"10‑core GPU, 10‑core CPU, 16-core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified memory"},{"label":"Hard drive size","value":"512 GB"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"512 GB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M4 Chip"},{"label":"Graphics memory","value":"10-Core GPU"},{"label":"Type of graphics memory","value":"Apple M4 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M4 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"13.6-inch (diagonal) LED-backlit display with IPS technology;2 2560-by-1664 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"13.6-inch (diagonal) LED-backlit display with IPS technology;2 2560-by-1664 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2560x1664"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Sky Color"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"2.7 pounds (1.24 kg)"},{"label":"Fingerprint Reader","value":"Yes"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard"},{"label":"Bluetooth","value":"Bluetooth® 5.3"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)"},{"label":"Condition","value":"New"},{"label":"USB","value":"MagSafe 3 charging port 3.5 mm headphone jack Two Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"1080p FaceTime HD camera"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://support.apple.com/en-us/122209"},{"label":"Product page","value":"https://support.apple.com/en-us/122209"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-13-mc6v4-m4-chip-skyblue-2025-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iPad Pro M5 Chip 11-Inch Ultra Retina XDR Display (1TB, WiFi, Space Black, 2026)',
  'Reference listing: https://www.paklap.pk/apple-ipad-pro-m5-chip-11-inch-display-black-2026-pakistan.html',
  483000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-ipad-pro-m5-chip-11-inch-display-black-2026-pakistan-1.jpg',
  array['/products/apple/apple-ipad-pro-m5-chip-11-inch-display-black-2026-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-ipad-pro-m5-chip-11-inch-display-black-2026-pakistan.html',
  'apple-ipad-pro-m5-chip-11-inch-display-black-2026-pakistan',
  true,
  '[{"label":"Ipad Category","value":"iPad Pro"},{"label":"Chipset","value":"M5"},{"label":"Storage","value":"1-Terabyte"},{"label":"Screen Size","value":"8.3 - Inch"},{"label":"Main Rear Camera","value":"12 Mega Pixel"},{"label":"Selfie Camera","value":"12 Mega Pixel"},{"label":"Mobile Band","value":"Wifi Only"},{"label":"Color","value":"Black"},{"label":"Warranty","value":"International Warranty"},{"label":"Speakers","value":"Yes"},{"label":"Operating System","value":"iPad OS"},{"label":"Weight","value":"0.98 pound"},{"label":"Condition","value":"New"},{"label":"Wireless network","value":"Yes"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-ipad-pro-m5-chip-11-inch-display-black-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Pro 14 MDE14 - Apple M5 Chip 10-Core CPU 10-Core GPU 16-GB 1-TB SSD 14-Inch Liquid Retina XDR Screen Display Backlit Magic KB With Touch ID (Space Black, 2025)',
  'Reference listing: https://www.paklap.pk/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan.html',
  530500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan-1.jpg',
  array['/products/apple/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan-1.jpg', '/products/apple/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan-2.jpg', '/products/apple/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan-3.jpg', '/products/apple/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan-4.jpg', '/products/apple/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan.html',
  'apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10‑Core CPU, 10‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"16 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M5 Chip"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen surface","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen resolution","value":"3024 x 1964"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Space Black"},{"label":"RAM","value":"16 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"Weight (M5): 3.4 pounds (1.55 kg)"},{"label":"Fingerprint Reader","value":"Yes"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Yes"},{"label":"Bluetooth","value":"Bluetooth 5.3"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)"},{"label":"Condition","value":"New"},{"label":"USB","value":"Three Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"Yes"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-pro-14-mde14-m5-chip-space-black-2025-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MDVN4 - Apple M5 Chip 10-Core CPU 10-Core GPU 24-GB 1-TB SSD 15.3-Inch Liquid Retina with True Tone Display Backlit Magic KB with Touch ID (Midnight, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan.html',
  551500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan.html',
  'apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10-core CPU, 10-core GPU, 16-core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"10 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x 1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Midnight"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)6"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"Bluetooth 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)4"},{"label":"Condition","value":"New"},{"label":"USB","value":"2 × Thunderbolt 4 (USB-C) Ports with Support for Charging, DisplayPort, Thunderbolt 4 (up to 40Gb/s), and USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mdvn4-m5-chip-midnight-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Air 15 MDVU4 - Apple M5 Chip 10-Core CPU 10-Core GPU 24-GB 1-TB SSD 15.3-Inch Liquid Retina with True Tone Display Backlit Magic KB with Touch ID (Sky Blue, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan.html',
  551500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan-1.jpg', '/products/apple/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan-2.jpg', '/products/apple/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan-3.jpg', '/products/apple/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan.html',
  'apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10-core CPU, 10-core GPU, 16-core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"10 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen surface","value":"15.3-inch (diagonal) LED-backlit display with IPS technology;2 2880-by-1864 native resolution at 224 pixels per inch 500 nits brightness"},{"label":"Screen resolution","value":"2880 x 1864"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Sky Color"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.3 pounds (1.51 kg)6"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"Bluetooth 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)4"},{"label":"Condition","value":"New"},{"label":"USB","value":"2 × Thunderbolt 4 (USB-C) Ports with Support for Charging, DisplayPort, Thunderbolt 4 (up to 40Gb/s), and USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-air/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-air-15-mdvu4-m5-chip-sky-blue-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Pro 14 MDE34 - Apple M5 Chip 10-Core CPU 10-Core GPU 24-GB 1-TB SSD 14-Inch Liquid Retina XDR Screen Display Backlit Magic KB With Touch ID (Space Black, 2025)',
  'Reference listing: https://www.paklap.pk/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan.html',
  603500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan-1.jpg',
  array['/products/apple/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan-1.jpg', '/products/apple/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan-2.jpg', '/products/apple/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan-3.jpg', '/products/apple/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan-4.jpg', '/products/apple/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan.html',
  'apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10‑Core CPU, 10‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"Apple M5 Chip"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen surface","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen resolution","value":"3024 x 1964"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Space Black"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"Weight (M5): 3.4 pounds (1.55 kg)"},{"label":"Fingerprint Reader","value":"Yes"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Yes"},{"label":"Bluetooth","value":"Bluetooth 5.3"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 6E (802.11ax)"},{"label":"Condition","value":"New"},{"label":"USB","value":"Three Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"Yes"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-pro-14-mde34-m5-chip-space-black-2025-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iMac Z19D0019T - M3 Chip 8 Core CPU 16GB 512GB SSD 24-Inch 4.5K Retina Display 10 Core GPU Magic Mouse & Magic Keyboard Included MACOS (Silver, 2023)',
  'Reference listing: https://www.paklap.pk/apple-imac-z19d00019t-m3-chip-desktop-pc-pakistan.html',
  618000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-imac-z19d00019t-m3-chip-desktop-pc-pakistan-1.jpg',
  array['/products/apple/apple-imac-z19d00019t-m3-chip-desktop-pc-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-imac-z19d00019t-m3-chip-desktop-pc-pakistan.html',
  'apple-imac-z19d00019t-m3-chip-desktop-pc-pakistan',
  true,
  '[{"label":"Chipset","value":"M3"},{"label":"Chipset Speed","value":"8-Core CPU, 10-Core GPU | 16-Core Neural Engine"},{"label":"Installed RAM","value":"16GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"512GB"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"512 GB SSD"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Graphics processor","value":"Apple M1 Chip 10-Core GPU"},{"label":"Screen Size","value":"24 - Inch"},{"label":"Screen Surface","value":"4480-by-2520 resolution at 218 pixels per inch with support for 1 billion colors, 500 nits brightness"},{"label":"Color","value":"Silver"},{"label":"RAM","value":"16GB"},{"label":"Operating system","value":"MAC OS"},{"label":"Condition","value":"New"},{"label":"Manual / Product Page","value":"https://www.apple.com/newsroom/2023/10/apple-supercharges-24-inch-imac-with-new-m3-chip/"},{"label":"Warranty","value":"International Warranty"},{"label":"Wireless","value":"Bluetooth,Wi-Fi"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-imac-z19d00019t-m3-chip-desktop-pc-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple Mac Studio MQH73 - M2 Max Chip 12-Core CPU 30-Core GPU 32GB 512GB SSD Silver (2022)',
  'Reference listing: https://www.paklap.pk/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan.html',
  638500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan-1.jpg',
  array['/products/apple/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan-1.jpg', '/products/apple/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan-2.jpg', '/products/apple/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan-3.jpg']::text[],
  'https://www.paklap.pk/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan.html',
  'apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Color","value":"Silver"},{"label":"Warranty","value":"International Warranty"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-mac-studio-mqh73-m2-max-chip-silver-price-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Pro 14 MJ3D4 - Apple M5 Chip 10-Core CPU 10-Core GPU 32-GB 1-TB SSD 14-Inch Liquid Retina XDR Screen Display Backlit Magic KB With Touch ID (Space Black, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan.html',
  651000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan-1.jpg', '/products/apple/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan-2.jpg', '/products/apple/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan-3.jpg', '/products/apple/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan-4.jpg', '/products/apple/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan.html',
  'apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Chip"},{"label":"Processor Speed","value":"10‑Core CPU, 10‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"32 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"10 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M5 Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen surface","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen resolution","value":"3024 x 1964"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Space Black"},{"label":"RAM","value":"32 GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.56 pounds (1.62 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard with: 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"Bluetooth 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)6"},{"label":"Condition","value":"New"},{"label":"USB","value":"Three Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-pro-14-mj3d4-m5-chip-space-black-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Pro 14 MGDR4 - Apple M5 Pro Chip 15-Core CPU 16-Core GPU 24-GB 1-TB SSD 14-Inch Liquid Retina XDR Screen Display Backlit Magic KB With Touch ID (Space Black, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan.html',
  688000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan-1.jpg', '/products/apple/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan-2.jpg', '/products/apple/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan-3.jpg', '/products/apple/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan-4.jpg', '/products/apple/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan-5.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan.html',
  'apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Pro Chip"},{"label":"Processor Speed","value":"15‑Core CPU, 16‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"16 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"16 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Pro Chip"},{"label":"Switchable graphics","value":"No"},{"label":"Graphics processor","value":"Apple M5 Pro Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen surface","value":"14.2-inch (diagonal) Liquid Retina XDR display;2 3024-by-1964 native resolution at 254 pixels per inch"},{"label":"Screen resolution","value":"3024 x 1964"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Space Black"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"3.56 pounds (1.62 kg)"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard with: 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"BT 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)6"},{"label":"Condition","value":"New"},{"label":"USB","value":"Three Thunderbolt 4 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 4 (up to 40Gb/s) USB 4 (up to 40Gb/s)"},{"label":"HDMI","value":"No"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-pro-14-mgdr4-m5-pro-chip-space-black-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple iMac Z19D0019U - M3 Chip 8 Core CPU 16GB 2 Terabyte SSD 24-Inch 4.5K Retina Display 10 Core GPU Magic Mouse & Keyboard Included MACOS (Silver, 2023)',
  'Reference listing: https://www.paklap.pk/apple-imac-z19d0019u-m3-desktop-pc-pakistan.html',
  788000.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-imac-z19d0019u-m3-desktop-pc-pakistan-1.jpg',
  array['/products/apple/apple-imac-z19d0019u-m3-desktop-pc-pakistan-1.jpg']::text[],
  'https://www.paklap.pk/apple-imac-z19d0019u-m3-desktop-pc-pakistan.html',
  'apple-imac-z19d0019u-m3-desktop-pc-pakistan',
  true,
  '[{"label":"Chipset","value":"M3"},{"label":"Chipset Speed","value":"8-Core CPU, 10-Core GPU | 16-Core Neural Engine"},{"label":"Installed RAM","value":"16GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"2 - Terabyte"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"SSD","value":"2 TB SSD"},{"label":"Graphic Series","value":"10 - Core GPU"},{"label":"Graphics processor","value":"Apple M1 Chip 10-Core GPU"},{"label":"Screen Size","value":"24 - Inch"},{"label":"Screen Surface","value":"24-inch 4.5K Retina display 4480-by-2520 resolution at 218 pixels per inch with support for 1 billion colors 500 nits brightness Wide color (P3) True Tone technology"},{"label":"Color","value":"Silver"},{"label":"RAM","value":"16GB"},{"label":"Operating system","value":"MAC OS"},{"label":"Condition","value":"New"},{"label":"Manual / Product Page","value":"https://support.apple.com/en-us/117734"},{"label":"Warranty","value":"International Warranty"},{"label":"Wireless","value":"Bluetooth,Wi-Fi"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-imac-z19d0019u-m3-desktop-pc-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Pro 16 MGEA4 - Apple M5 Pro Chip 18-Core CPU 20-Core GPU 24-GB 1-TB SSD 16-Inch Liquid Retina XDR Screen Display Backlit Magic KB With Touch ID (Space Black, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan.html',
  845500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan-1.jpg', '/products/apple/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan-2.jpg', '/products/apple/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan-3.jpg', '/products/apple/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan.html',
  'apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Pro Chip"},{"label":"Processor Speed","value":"18‑Core CPU, 20‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"20 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"20 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Pro Chip"},{"label":"Switchable graphics","value":"20 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Pro Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"16.2-inch (diagonal) Liquid Retina XDR display;2 3456-by-2234 native resolution at 254 pixels per inch"},{"label":"Screen surface","value":"16.2-inch (diagonal) Liquid Retina XDR display;2 3456-by-2234 native resolution at 254 pixels per inch"},{"label":"Screen resolution","value":"3456 x 2234"},{"label":"Color","value":"Space Black"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"4.7 pounds (2.15 kg)8"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard with: 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"BT 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)6"},{"label":"Condition","value":"New"},{"label":"USB","value":"Three Thunderbolt 5 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 5 (up to 120Gb/s) USB 4 (up to 120Gb/s)"},{"label":"HDMI","value":"One HDMI port"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-pro-16-mgea4-m5-pro-chip-space-black-2026-pakistan.html'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, gallery_image_paths, source_url, legacy_demo_id, is_online, specifications
)
select
  'Apple MacBook Pro 16 MGE44 - Apple M5 Pro Chip 18-Core CPU 20-Core GPU 24-GB 1-TB SSD 16-Inch Liquid Retina XDR Screen Display Backlit Magic KB With Touch ID (Silver, 2026)',
  'Reference listing: https://www.paklap.pk/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan.html',
  845500.00,
  5,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan-1.jpg',
  array['/products/apple/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan-1.jpg', '/products/apple/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan-2.jpg', '/products/apple/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan-3.jpg', '/products/apple/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan-4.jpg']::text[],
  'https://www.paklap.pk/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan.html',
  'apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan',
  true,
  '[{"label":"Brand","value":"Apple"},{"label":"Generation","value":"Apple M5 Chip"},{"label":"Processor Type","value":"Apple M5 Pro Chip"},{"label":"Processor Speed","value":"18‑Core CPU, 20‑Core GPU, 16‑Core Neural Engine"},{"label":"Installed RAM","value":"24 GB"},{"label":"Type of memory","value":"Unified Memory"},{"label":"Hard drive size","value":"1 TB SSD"},{"label":"Hard drive speed","value":"Solid State Drive"},{"label":"Optical Drive","value":"No"},{"label":"SSD","value":"1 TB SSD"},{"label":"Type of harddrive","value":"Solid State Drive"},{"label":"Graphic Series","value":"20 - Core GPU"},{"label":"Dedicated graphics","value":"No"},{"label":"Graphics memory","value":"20 - Core GPU"},{"label":"Type of graphics memory","value":"Apple M5 Pro Chip"},{"label":"Switchable graphics","value":"20 - Core GPU"},{"label":"Graphics processor","value":"Apple M5 Pro Chip"},{"label":"Backlight","value":"LED"},{"label":"Screen size","value":"16.2-inch (diagonal) Liquid Retina XDR display;2 3456-by-2234 native resolution at 254 pixels per inch"},{"label":"Screen surface","value":"16.2-inch (diagonal) Liquid Retina XDR display;2 3456-by-2234 native resolution at 254 pixels per inch"},{"label":"Screen resolution","value":"3456 x 2234"},{"label":"Touchscreen","value":"No"},{"label":"Color","value":"Silver"},{"label":"RAM","value":"24GB"},{"label":"Operating System","value":"MAC OS"},{"label":"Weight","value":"4.7 pounds (2.15 kg)8"},{"label":"Fingerprint Reader","value":"No"},{"label":"Numeric keyboard","value":"No"},{"label":"Backlit keyboard","value":"Backlit Magic Keyboard with: 78 (ANSI) or 79 (ISO) keys including 12 full-height function keys Touch ID Ambient light sensor"},{"label":"Bluetooth","value":"BT 6.0"},{"label":"LAN","value":"No"},{"label":"Wireless/Wifi","value":"Yes"},{"label":"Type","value":"Wi-Fi 7 (802.11be)6"},{"label":"Condition","value":"New"},{"label":"USB","value":"Three Thunderbolt 5 (USB-C) ports with support for: Charging DisplayPort Thunderbolt 5 (up to 120Gb/s) USB 4 (up to 120Gb/s)"},{"label":"HDMI","value":"One HDMI port"},{"label":"Camera","value":"12MP Center Stage camera with support for Desk View 1080p HD video recording Advanced image signal processor with computational video"},{"label":"Operating system (Primary)","value":"MAC OS"},{"label":"Manual","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Product page","value":"https://www.apple.com/macbook-pro/specs/"},{"label":"Warranty","value":"International"}]'::jsonb
where not exists (
  select 1 from public.inventory_products where source_url = 'https://www.paklap.pk/apple-macbook-pro-14-mge44-m5-pro-chip-silver-2026-pakistan.html'
);
