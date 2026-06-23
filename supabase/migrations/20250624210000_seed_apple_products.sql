-- Apple Products catalog seed (Wi-Fi iPads, MacBook Neo, AirPods).
-- Idempotent: skips rows that already exist for the same legacy_demo_id.


insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple AirPods 4',
  'Model: Open-ear fit with USB-C charging and personalized spatial audio.

Experience the next generation of wireless listening with Apple AirPods 4. Built around the powerful H2 chip, they deliver rich, detailed sound with Personalized Spatial Audio that adapts to your ear shape. The refined open-ear design sits comfortably for hours, while the USB-C charging case keeps you powered for up to 30 hours of total listening time. Quick-charge support gives you about an hour of playback from just five minutes in the case. With IP54 dust and water resistance, Bluetooth 5.3 connectivity, and seamless one-tap setup for iPhone, iPad, and Mac, AirPods 4 are an ideal everyday companion for calls, music, and podcasts. Available at Saim Enterprise with genuine Apple stock.

Official product page: https://www.apple.com/airpods-4/',
  38500.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/airpods-4.png',
  'https://www.apple.com/airpods-4/',
  true,
  '[{"label":"Chip","value":"Apple H2"},{"label":"Audio","value":"Personalized Spatial Audio, dynamic head tracking"},{"label":"Battery (earbuds)","value":"Up to 5 hours listening"},{"label":"Battery (with case)","value":"Up to 30 hours total"},{"label":"Connectivity","value":"Bluetooth 5.3"},{"label":"Charging","value":"USB-C"},{"label":"Water resistance","value":"IP54 (earbuds and case)"},{"label":"Weight","value":"4.3 g per earbud"}]'::jsonb,
  null,
  'apple-airpods-4'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-airpods-4'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple AirPods 4 with Active Noise Cancellation',
  'Model: AirPods 4 with ANC, Transparency mode, and USB-C charging case.

Step up to Apple AirPods 4 with Active Noise Cancellation for a more immersive, focused listening experience. The H2 chip powers advanced ANC that reduces ambient noise on commutes and flights, while Transparency mode lets you stay aware of your surroundings when you need to. Adaptive Audio automatically blends ANC and Transparency, and Conversation Awareness lowers your media when you start speaking. The contoured open-ear fit, Personalized Spatial Audio, and USB-C charging case with up to 30 hours of total battery life make these the most capable open-form AirPods yet. IP54-rated durability and effortless Apple device pairing round out a premium everyday earbud. Shop genuine units at Saim Enterprise.

Official product page: https://www.apple.com/airpods-4/?variant=active-noise-cancellation',
  47500.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/airpods-4-anc.png',
  'https://www.apple.com/airpods-4/?variant=active-noise-cancellation',
  true,
  '[{"label":"Chip","value":"Apple H2"},{"label":"Noise control","value":"Active Noise Cancellation, Transparency, Adaptive Audio"},{"label":"Battery (earbuds)","value":"Up to 5 hours listening (up to 4 with ANC)"},{"label":"Battery (with case)","value":"Up to 30 hours total"},{"label":"Connectivity","value":"Bluetooth 5.3"},{"label":"Charging","value":"USB-C, wireless charging case"},{"label":"Water resistance","value":"IP54"}]'::jsonb,
  null,
  'apple-airpods-4-anc'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-airpods-4-anc'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple AirPods Pro (2nd Generation)',
  'Model: Pro-level ANC with USB-C MagSafe charging case.

Apple AirPods Pro (2nd generation) deliver the gold standard for in-ear wireless audio. The H2 chip drives up to 2× more Active Noise Cancellation than the original AirPods Pro, with Adaptive Audio that intelligently adjusts between noise cancellation and Transparency. Personalized Spatial Audio with dynamic head tracking places sound all around you, while the low-distortion custom driver brings clarity to every genre. The USB-C charging case supports MagSafe and Apple Watch chargers, and offers up to 30 hours of total listening time. IP54 sweat and water resistance, touch control, and a choice of silicone tip sizes ensure a secure, comfortable fit for all-day wear. Available at Saim Enterprise.

Official product page: https://www.apple.com/airpods-pro/',
  54500.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/airpods-pro-2.png',
  'https://www.apple.com/airpods-pro/',
  true,
  '[{"label":"Chip","value":"Apple H2"},{"label":"Noise control","value":"Active Noise Cancellation (2×), Adaptive Audio, Transparency"},{"label":"Battery (earbuds)","value":"Up to 6 hours listening (up to 4.5 with ANC)"},{"label":"Battery (with case)","value":"Up to 30 hours total"},{"label":"Connectivity","value":"Bluetooth 5.3"},{"label":"Charging","value":"USB-C case, MagSafe, Apple Watch charger"},{"label":"Water resistance","value":"IP54"}]'::jsonb,
  null,
  'apple-airpods-pro-2'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-airpods-pro-2'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple iPad Air M4',
  'Model: Thin, light iPad Air with M4 chip — Wi-Fi models in 11-inch and 13-inch.

The iPad Air with M4 chip brings pro-level performance to Apple’s most portable Air design. The M4 delivers fast CPU and GPU performance for creative apps, multitasking, and Apple Intelligence features, while the stunning Liquid Retina display makes photos, video, and drawing look incredible. Available in 11-inch and 13-inch sizes with Wi-Fi connectivity, iPad Air supports Apple Pencil Pro and Magic Keyboard for serious productivity. An all-day battery, USB-C port, and Center Stage front camera make it perfect for students, professionals, and creators who want iPad flexibility without Pro pricing. Choose your screen size and storage below — all units are Wi-Fi only. Genuine stock at Saim Enterprise.

Official product page: https://www.apple.com/ipad-air/?chip=m4',
  199999.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/ipad-air-m4.png',
  'https://www.apple.com/ipad-air/?chip=m4',
  true,
  '[{"label":"Chip","value":"Apple M4"},{"label":"Display","value":"11-inch or 13-inch Liquid Retina"},{"label":"Connectivity","value":"Wi-Fi 6E (Wi-Fi models only)"},{"label":"Port","value":"USB-C"},{"label":"Apple Pencil","value":"Apple Pencil Pro support"},{"label":"Camera","value":"12MP Wide back, 12MP Center Stage front"}]'::jsonb,
  '{"dimensions":["size","storage"],"choices":{"size":["11-inch","13-inch"],"storage":["128GB","256GB","512GB","1TB"]},"options":[{"id":"m4-11-128","size":"11-inch","storage":"128GB","price":199999},{"id":"m4-11-256","size":"11-inch","storage":"256GB","price":234999},{"id":"m4-11-512","size":"11-inch","storage":"512GB","price":289999},{"id":"m4-11-1tb","size":"11-inch","storage":"1TB","price":349999},{"id":"m4-13-128","size":"13-inch","storage":"128GB","price":267999},{"id":"m4-13-256","size":"13-inch","storage":"256GB","price":294999},{"id":"m4-13-512","size":"13-inch","storage":"512GB","price":359999},{"id":"m4-13-1tb","size":"13-inch","storage":"1TB","price":419999}],"defaultOptionId":"m4-11-128"}'::jsonb,
  'apple-ipad-air-m4'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-ipad-air-m4'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple iPad Air M3',
  'Model: Previous-generation iPad Air with M3 — excellent value, Wi-Fi only.

The iPad Air with M3 chip offers outstanding performance for everyday work, study, and entertainment at a compelling price point. The M3 handles demanding apps, gaming, and creative workflows with ease, paired with a beautiful Liquid Retina display in your choice of 11-inch or 13-inch size. Wi-Fi connectivity keeps things simple — no cellular contracts — while USB-C, all-day battery life, and support for Apple Pencil Pro make this one of the most versatile tablets you can buy. Select your preferred screen size and storage below. All models listed are Wi-Fi only and available through Saim Enterprise.

Official product page: https://www.apple.com/ipad-air/?chip=m3',
  185999.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/ipad-air-m3.png',
  'https://www.apple.com/ipad-air/?chip=m3',
  true,
  '[{"label":"Chip","value":"Apple M3"},{"label":"Display","value":"11-inch or 13-inch Liquid Retina"},{"label":"Connectivity","value":"Wi-Fi 6E (Wi-Fi models only)"},{"label":"Port","value":"USB-C"},{"label":"Apple Pencil","value":"Apple Pencil Pro support"}]'::jsonb,
  '{"dimensions":["size","storage"],"choices":{"size":["11-inch","13-inch"],"storage":["128GB","256GB","512GB","1TB"]},"options":[{"id":"m3-11-128","size":"11-inch","storage":"128GB","price":185999},{"id":"m3-11-256","size":"11-inch","storage":"256GB","price":218999},{"id":"m3-11-512","size":"11-inch","storage":"512GB","price":269999},{"id":"m3-11-1tb","size":"11-inch","storage":"1TB","price":329999},{"id":"m3-13-128","size":"13-inch","storage":"128GB","price":249999},{"id":"m3-13-256","size":"13-inch","storage":"256GB","price":279999},{"id":"m3-13-512","size":"13-inch","storage":"512GB","price":339999},{"id":"m3-13-1tb","size":"13-inch","storage":"1TB","price":389999}],"defaultOptionId":"m3-11-128"}'::jsonb,
  'apple-ipad-air-m3'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-ipad-air-m3'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple iPad 11th Generation (A16)',
  'Model: Affordable 11-inch iPad with A16 chip — Wi-Fi models.

The 11-inch iPad with A16 chip is the perfect entry point into the iPad lineup. The A16 Bionic delivers smooth performance for apps, games, video calls, and note-taking, while the vibrant Liquid Retina display makes content shine. Wi-Fi models keep costs down without sacrificing capability — ideal for students and families. USB-C charging, all-day battery, and support for Apple Pencil (USB-C) and Magic Keyboard Folio make this iPad ready for school, home, and travel. Pick your storage below; all units are Wi-Fi only. In stock at Saim Enterprise.

Official product page: https://www.apple.com/ipad-11/',
  124999.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/ipad-11-a16.png',
  'https://www.apple.com/ipad-11/',
  true,
  '[{"label":"Chip","value":"Apple A16 Bionic"},{"label":"Display","value":"11-inch Liquid Retina"},{"label":"Connectivity","value":"Wi-Fi 6 (Wi-Fi models only)"},{"label":"Port","value":"USB-C"},{"label":"Apple Pencil","value":"Apple Pencil (USB-C) support"}]'::jsonb,
  '{"dimensions":["storage"],"choices":{"storage":["128GB","256GB","512GB"]},"options":[{"id":"a16-128","storage":"128GB","price":124999},{"id":"a16-256","storage":"256GB","price":149999},{"id":"a16-512","storage":"512GB","price":189999}],"defaultOptionId":"a16-128"}'::jsonb,
  'apple-ipad-11-a16'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-ipad-11-a16'
);

insert into public.inventory_products (
  name, description, price, stock_quantity, category_id,
  image_path, source_url, is_online, specifications, variants, legacy_demo_id
)
select
  'Apple MacBook Neo',
  'Model: Apple’s most affordable MacBook — 13-inch, A18 Pro chip, Wi-Fi only.

Meet MacBook Neo — Apple’s entry-level laptop designed for students, first-time Mac users, and everyday productivity. Powered by the A18 Pro chip with a 6-core CPU and 5-core GPU, it handles browsing, documents, video calls, and light creative work with impressive efficiency. The 13-inch Liquid Retina display is sharp and bright, while the fanless design stays silent. With up to 16 hours of battery life, Wi-Fi 6E, two USB-C ports, MagSafe charging, and macOS out of the box, MacBook Neo is the easiest way into the Apple ecosystem. Choose 256GB or 512GB SSD below. Available at Saim Enterprise.

Official product page: https://www.apple.com/macbook-neo/',
  225000.00,
  10,
  (select id from public.categories where slug = 'apple-products' limit 1),
  '/products/apple/macbook-neo.png',
  'https://www.apple.com/macbook-neo/',
  true,
  '[{"label":"Chip","value":"Apple A18 Pro"},{"label":"CPU","value":"6-core (2 performance, 4 efficiency)"},{"label":"GPU","value":"5-core"},{"label":"Memory","value":"8GB unified memory"},{"label":"Display","value":"13-inch Liquid Retina, 500 nits"},{"label":"Battery","value":"Up to 16 hours"},{"label":"Connectivity","value":"Wi-Fi 6E, Bluetooth 6"},{"label":"Ports","value":"2× USB-C, MagSafe 3, 3.5mm headphone"},{"label":"Weight","value":"1.23 kg (2.7 lb)"}]'::jsonb,
  '{"dimensions":["storage"],"choices":{"storage":["256GB","512GB"]},"options":[{"id":"neo-256","storage":"256GB","price":225000},{"id":"neo-512","storage":"512GB","price":255000}],"defaultOptionId":"neo-256"}'::jsonb,
  'apple-macbook-neo'
where not exists (
  select 1 from public.inventory_products where legacy_demo_id = 'apple-macbook-neo'
);
