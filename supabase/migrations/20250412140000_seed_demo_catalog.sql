-- Demo catalog migrated from former src/data/products.ts (legacy slugs preserved for URLs).
-- Idempotent: skips rows that already have the same legacy_demo_id.

alter table public.inventory_products
  add column if not exists legacy_demo_id text;

alter table public.inventory_products
  add column if not exists is_featured boolean not null default false;

create unique index if not exists inventory_products_legacy_demo_id_key
  on public.inventory_products (legacy_demo_id)
  where legacy_demo_id is not null;

alter table public.inventory_products
  add column if not exists listing_badge text;

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK14 Tri-Mode Mechanical Keyboard',
  'Model: MK14 BLACK

Premium tri-mode mechanical keyboard with hot-swappable switches and RGB backlit.

• Wired + 2.4G + Bluetooth Tri-Mode
• OEM Profile Keycaps
• Hot-Swappable Switches
• Cloud Driver Support
• Silver-like Switches with POM Material
• RGB Backlit
• Two-Stage Adjustable Stand
• Multi-System Support: Win/Mac/iOS/Android
• 87% Layout, TKL Design
• 4000mAh Battery

Official product page: https://www.meetion.com/MT-MK14.html',
  9800.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-1.png',
  'mk14-black',
  true,
  'Best Seller'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk14-black'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK14 Tri-Mode Mechanical Keyboard',
  'Model: MK14 WHITE

Premium tri-mode mechanical keyboard in elegant white finish.

• Wired + 2.4G + Bluetooth Tri-Mode
• 87% Layout, TKL Design
• 4000mAh Battery
• Hot-Swappable Switches
• RGB Backlit

Official product page: https://www.meetion.com/MT-MK14.html',
  11200.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-2.png',
  'mk14-white',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk14-white'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK12 65% Mechanical Keyboard',
  'Model: MK12 WHITE

Compact 65% layout mechanical keyboard with premium features.

• ABS Plastic Construction
• Wired + 2.4G + 3 Bluetooth Channels
• OEM Height Keycaps
• Hot-Swappable Switches
• Cloud Driver + Local Driver
• Silver-Like Switches, POM Material
• RGB Backlight
• Two-Stage Height Feet
• 65% Layout
• 2000mAh Battery

Official product page: https://www.meetion.com/MT-MK12.html',
  10000.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-3.png',
  'mk12-white',
  true,
  'Compact'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk12-white'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK12 65% Mechanical Keyboard',
  'Model: MK12 BLACK

Compact 65% layout mechanical keyboard in sleek black.

• 65% Layout
• 2000mAh Battery
• Hot-Swappable Switches
• RGB Backlight

Official product page: https://www.meetion.com/MT-MK12.html',
  10000.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-4.png',
  'mk12-black',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk12-black'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK009 Pro Gaming Keyboard',
  'Model: MK009 Pro

Professional gaming keyboard with hot-swappable red switches.

• Red Switches Hot-Swappable
• USB-TypeC Connection
• RGB Backlighting
• Software Customizable Settings
• Detachable Wired Connection

Official product page: https://www.meetion.com/mt-MK009PRD-HOTSWAP.html',
  7800.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-5.png',
  'mk009-pro',
  true,
  'Pro Gaming'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk009-pro'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK009 Mechanical Keyboard',
  'Model: MK009RD

Hot-swappable mechanical keyboard with rainbow backlighting.

• Red Switches Hot-Swappable
• Rainbow Backlighting
• Detachable USB-TypeC
• Color Box Packaging

Official product page: https://www.meetion.com/mt-mk009.html',
  5300.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-6.png',
  'mk009rd',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk009rd'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK008 Pro 80% Gaming Keyboard',
  'Model: MK008 PRO

80% hot sale gaming mechanical keyboard with metal top cover.

• Metal Top Cover with Knob
• Double Injection Keycaps
• Detachable Characters with Backlit
• Red Switches Hot-Swappable
• RGB Backlighting
• Software Customizable Settings
• Detachable USB-TypeC

Official product page: https://www.meetion.com/MT-MK008Pro.html',
  6200.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-7.png',
  'mk008-pro',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk008-pro'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK006 Pro 75% Gaming Keyboard',
  'Model: MK006 PRO

75% gaming mechanical keyboard with metal top cover and knob.

• Metal Top Cover with Knob
• USB-TypeC
• Red Switches Hot-Swappable
• Wired RGB Backlighting
• Software Customizable Settings
• Detachable USB-TypeC

Official product page: https://www.meetion.com/MT-MK006Pro.html',
  5700.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-8.png',
  'mk006-pro',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk006-pro'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK005 60% Mechanical Keyboard',
  'Model: MK005 BLACK

Compact 60% mechanical keyboard with OUTEMU Blue switches.

• USB Wired
• ABS Plastic, 292×102×38mm
• 60% Keyboard Layout
• OUTEMU Blue Switches, 50 Million
• Monochromatic Mixed Light
• TypeC-USB Cable: 1.8m

Official product page: https://www.meetion.com/mt-mk005.html',
  5500.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-9.png',
  'mk005-black',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk005-black'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MK005 Bluetooth Mechanical Keyboard',
  'Model: MK005BT

Wireless Bluetooth mechanical keyboard with 60% layout.

• TypeC-USB Bluetooth
• OUTEMU Blue Switches, 50 Million
• Monochromatic Mixed Light
• TypeC-USB Cable: 1.8m

Official product page: https://www.meetion.com/mt-mk005bt.html',
  8300.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-10.png',
  'mk005bt',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mk005bt'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'K9320 Rainbow Gaming Keyboard',
  'Model: K9320

Affordable membrane keyboard with rainbow backlight.

• USB Wired
• Membrane Type
• Rainbow Backlight
• 30 Million Keystrokes

Official product page: https://www.meetion.com/mt-K9320.html',
  2200.00,
  10,
  (select id from public.categories where slug = 'keyboard' limit 1),
  '/products/product-p1-11.png',
  'k9320',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'k9320'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'GM23 RGB Gaming Mouse',
  'Model: GM23

High-performance gaming mouse with adjustable weight.

• ABS Plastic, 128×81×40mm
• RGB Backlight
• 12800 DPI / 6000 FPS
• 15g Weight / 60 IPS
• 1000Hz Polling Rate
• 5+ Million Clicks
• Software Support
• Adjustable Weight

Official product page: https://www.meetion.com/mt-gm23_2023.html',
  3700.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-1.png',
  'gm23-2023',
  true,
  'High DPI'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'gm23-2023'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'GM21 RGB Gaming Mouse',
  'Model: GM21

Precision gaming mouse with RGB lighting.

• ABS Plastic, 119×65×39mm
• RGB Backlight
• 10000 DPI / 7000 FPS
• 20g Weight / 60 IPS
• 1000Hz Polling Rate
• 3+ Million Clicks
• Software Support

Official product page: https://www.meetion.com/MT-GM21.html',
  3000.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-2.png',
  'gm21-2023',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'gm21-2023'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'GM19 RGB Gaming Mouse',
  'Model: GM19

Ergonomic gaming mouse with high precision sensor.

• ABS Plastic, 123×67×43mm
• RGB Backlight
• 12000 DPI / 7000 FPS
• 20g Weight / 60 IPS
• 1000Hz Polling Rate
• 5+ Million Clicks
• Software Support

Official product page: https://www.meetion.com/MT-GM19.html',
  3300.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-3.png',
  'gm19-2023',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'gm19-2023'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'GM015 RGB Gaming Mouse',
  'Model: GM015

Affordable gaming mouse with RGB lighting.

• ABS Plastic, 123×62×42mm
• RGB Backlight
• 6400 DPI / 6000 FPS
• 22.5g Weight / 30 IPS
• 1000Hz Polling Rate
• 5+ Million Clicks
• Software Support

Official product page: https://www.meetion.com/MT-GM015.html',
  2400.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-4.png',
  'gm015',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'gm015'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'GW38 Tri-Mode Gaming Mouse',
  'Model: GW38 BLACK

Premium wireless gaming mouse with charging dock.

• Wired + 2.4G + Bluetooth Tri-Mode
• Medium to Large Hand Size
• Plug-and-Play Wired Connection
• Local Driver Support
• Charging Dock Included
• RGB LED
• Max 8000 DPI
• PAW3104 Sensor
• 650mAh Battery

Official product page: https://www.meetion.com/MT-GW38.html',
  6300.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-5.png',
  'gw38-black',
  true,
  'Wireless'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'gw38-black'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'GW32 Tri-Mode Gaming Mouse',
  'Model: GW32

Ergonomic wireless gaming mouse with long battery life.

• Wired + 2.4G + Bluetooth Tri-Mode
• Right-Hand Ergonomic
• Side Scroll Wheel
• RGB LED
• Max 8000 DPI
• PAW3220 Sensor
• 700mAh Battery
• 35 Hours Light ON / 115 Hours Light OFF

Official product page: https://www.meetion.com/MT-GW32.html',
  5500.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-6.png',
  'gw32',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'gw32'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'M930 Gaming Mouse',
  'Model: M930

Budget-friendly gaming mouse with 4-color backlight.

• ABS Plastic, 127×72×39mm
• 4-Color Backlight
• Max 3200 DPI
• 2+ Million Clicks
• PVC Cable

Official product page: https://www.meetion.com/MT-M930.html',
  1900.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-7.png',
  'm930-v23',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'm930-v23'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'M915 Wired Mouse',
  'Model: M915

Comfortable wired mouse with backlight.

• ABS Plastic, 135×73×42mm
• 4-Color Backlight
• Max 2400 DPI
• 3+ Million Clicks
• PVC Cable

Official product page: https://www.meetion.com/MT-M915.html',
  1400.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-p2-8.png',
  'm915',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'm915'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'BTH013 Tri-Mode Gaming Headset',
  'Model: BTH013

Premium wireless gaming headset with 40-hour battery.

• Wired + 2.4G + Bluetooth 5.3 Tri-Mode
• Detachable Noise-Cancelling Microphone
• Rotatable Ear Cups
• Adjustable Headband
• 1200mAh Battery, 40 Hours
• 285g Weight
• USB + Type-C Combo Receiver
• 50mm Speaker Size
• 20Hz - 20kHz Frequency',
  8600.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-p3-1.png',
  'bth013',
  true,
  'Premium'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'bth013'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'HP099 7.1 Surround Gaming Headset',
  'Model: HP099

USB gaming headset with 7.1 HiFi surround sound.

• ABS Plastic, 210×230×95mm
• φ50mm Speaker Unit
• 32Ω±15% / 118±3db
• 10-20,000Hz Frequency
• φ6.0mm Microphone
• USB Stereo
• 1.80m Cable
• HiFi 7.1 Surround

Official product page: https://www.meetion.com/MT-HP099.html',
  4800.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-p3-2.png',
  'hp099',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'hp099'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'HP030 USB Gaming Headset',
  'Model: HP030

Comfortable USB gaming headset with volume control.

• ABS Plastic, 200×115×220mm
• Volume Control on Headset
• 32Ω / 10-20,000Hz
• φ6.0mm Microphone
• USB Stereo
• 1.80m Cable

Official product page: https://www.meetion.com/MT-HP030.html',
  4100.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-p3-3.png',
  'hp030',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'hp030'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'HP022 Gaming Headset',
  'Model: HP022

Versatile gaming headset with dual connectivity.

• ABS Plastic
• 32Ω / 10-20,000Hz
• φ6.0mm Microphone
• φ3.5mm Stereo Jack×2 + USB×1
• 1.80m Cable

Official product page: https://www.meetion.com/MT-HP022.html',
  2900.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-p3-4.png',
  'hp022',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'hp022'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'HP021 Gaming Headset',
  'Model: HP021

Entry-level gaming headset with clear audio.

• ABS Plastic
• 32Ω / 10-20,000Hz
• φ6.0mm Microphone
• φ3.5mm Stereo Jack×2 + USB×1
• 1.80m Cable

Official product page: https://www.meetion.com/MT-HP021.html',
  2600.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-p3-5.png',
  'hp021',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'hp021'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'HP020 USB Gaming Headset',
  'Model: HP020

Comfortable gaming headset with volume control.

• ABS Plastic, 185×210×110mm
• Volume Control on Headset
• 32Ω / 10-20,000Hz
• φ6.0mm Microphone
• φ3.5mm Stereo Jack×2 + USB×1
• 1.80m Cable

Official product page: https://www.meetion.com/MT-HP020.html',
  3300.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-p3-6.png',
  'hp020',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'hp020'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'HP010 Wired Headset',
  'Model: HP010

Budget-friendly wired headset for gaming.

• ABS Plastic, 250×88×75mm
• Volume Control on Wire
• 32Ω / 10-20,000Hz
• φ6.0mm Microphone
• φ3.5mm Stereo Jack×2
• 1.80m Cable

Official product page: https://www.meetion.com/MT-HP010.html',
  2300.00,
  10,
  (select id from public.categories where slug = 'headset' limit 1),
  '/products/product-1.png',
  'hp010',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'hp010'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'C490 4-in-1 Gaming Kit',
  'Model: C490

Complete gaming kit with mouse, keyboard, headset and mousepad.

• Mouse: 6D/3200DPI/4000FPS/30IPS
• Keyboard: Membrane/Rainbow Backlight
• Headset: RGB/φ3.5 Stereo+USB
• MousePad: Soft Cloth with Rubber Base

Official product page: https://www.meetion.com/mt-C490.html',
  5300.00,
  10,
  (select id from public.categories where slug = 'combo' limit 1),
  '/products/product-2.png',
  'c490',
  true,
  'Value Pack'
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'c490'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'C505 4-in-1 Gaming Kit',
  'Model: C505

Premium gaming kit with enhanced components.

• Mouse: 6D/3200DPI/4000FPS/30IPS
• Keyboard: Membrane/Rainbow Backlight
• Headset: RGB/φ3.5 Stereo+USB
• MousePad: Soft Cloth with Rubber Base, 3mm

Official product page: https://www.meetion.com/mt-C505.html',
  6000.00,
  10,
  (select id from public.categories where slug = 'combo' limit 1),
  '/products/product-3.png',
  'c505',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'c505'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'SP2011 2.0 Desktop Speaker',
  'Model: SP2011

Compact 2.0 desktop speaker system.

• RMS: 3W×2
• 2-inch Driver Unit×2
• 150Hz-20KHz Frequency
• >30dB Separation
• DC 5V Power Input
• Volume Control
• Size: 67×79×98mm

Official product page: https://www.meetion.com/MT-SP2011.html',
  2100.00,
  10,
  (select id from public.categories where slug = 'speaker' limit 1),
  '/products/product-4.png',
  'sp2011',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'sp2011'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'SP2111 2.1 Speaker System',
  'Model: SP2111

Powerful 2.1 speaker system with subwoofer.

• RMS: 5W + 3W×2
• 3-inch + 2-inch×2 Driver Units
• 150Hz-20KHz Frequency
• >30dB Separation
• DC 5V Power Input
• Volume Control
• Subwoofer: 110×131×158mm

Official product page: https://www.meetion.com/MT-SP2111.html',
  5600.00,
  10,
  (select id from public.categories where slug = 'speaker' limit 1),
  '/products/product-5.png',
  'sp2111',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'sp2111'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MC20 Gaming Microphone',
  'Model: MC20

USB-C gaming/streaming microphone with RGB.

• ABS Plastic
• Game/Live Mic
• φ16.1×7.0mm Mic Unit
• 40Hz-18KHz Frequency
• Omnidirectional
• USB-TypeC, 2.20m Cable

Official product page: https://www.meetion.com/MT-MC20.html',
  6000.00,
  10,
  (select id from public.categories where slug = 'microphone' limit 1),
  '/products/product-6.png',
  'mc20',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mc20'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'MC13 Desktop Microphone',
  'Model: MC13

Compact desktop microphone with ON/OFF switch.

• ABS Plastic
• Mic Switch ON/OFF
• φ6×5mm Mic Unit
• 50Hz-10KHz Frequency
• Omnidirectional
• USB 2.0, 2.20m Cable

Official product page: https://www.meetion.com/MT-MC13.html',
  2700.00,
  10,
  (select id from public.categories where slug = 'microphone' limit 1),
  '/products/product-7.png',
  'mc13',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mc13'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'CW295 Wireless Keyboard & Mouse Combo',
  'Model: CW295

Battery-powered 2.4G wireless office combo.

• 2.4G Wireless
• ABS Material
• Full-Size Keyboard
• Ergonomic Ambidextrous Mouse
• 1 AA + 1 AAA Battery Included

Official product page: https://www.meetion.com/MT-CW295.html',
  3200.00,
  10,
  (select id from public.categories where slug = 'combo' limit 1),
  '/products/product-8.png',
  'cw295',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'cw295'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'Mini5000 75% Wireless Combo',
  'Model: Mini5000

Compact dual-mode wireless keyboard and mouse combo.

• Battery-Powered Dual-Mode
• ABS Material
• 75% Keyboard Layout
• 1 AA + 1 AAA Battery Included',
  3700.00,
  10,
  (select id from public.categories where slug = 'combo' limit 1),
  '/products/product-9.png',
  'mini5000',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'mini5000'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'R545 Wireless Mouse',
  'Model: R545 BLACK

Compact wireless mouse for everyday use.

• 2.4G Wireless
• 2+1 Buttons
• Max 1600 DPI
• AA×1 Battery',
  1100.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-10.png',
  'r545-black',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'r545-black'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'R547 Wireless Mouse',
  'Model: R547 BLACK

Ergonomic wireless mouse with extra button.

• 2.4G Wireless
• 3+1 Buttons
• Max 1600 DPI
• AA×1 Battery',
  1300.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-11.png',
  'r547-black',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'r547-black'
);

insert into public.inventory_products (name, description, price, stock_quantity, category_id, image_path, legacy_demo_id, is_featured, listing_badge)
select
  'M360 Silent Wired Mouse',
  'Model: M360

Silent wired mouse for quiet environments.

• Wired USB
• 5 Million Silent Switch
• 1200 DPI
• 1.5m Cable',
  1000.00,
  10,
  (select id from public.categories where slug = 'mouse' limit 1),
  '/products/product-12.png',
  'm360',
  false,
  null
where not exists (
  select 1 from public.inventory_products d where d.legacy_demo_id = 'm360'
);

