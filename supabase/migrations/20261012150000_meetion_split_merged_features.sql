-- Six Meetion products had several key features run together into one line
-- (a numbered list lost its line breaks on import). Split them apart; no content change.

update public.inventory_products set features = array[
  'Wired + 2.4G + Bluetooth Tri-Mode',
  'OEM Profile Keycaps',
  'Hot-Swappable Switches',
  'Cloud Driver',
  'Silver-like Switches/Silent Switches with POM Material and Self-Lubricating',
  'RGB Backlit',
  'Two-Stage Adjustable stand',
  'Multi-System Support: Win/Mac/iOS/Android',
  '87% Layout, TKL (Tenkeyless) Design',
  '4000mAh Battery'
]::text[]
where legacy_demo_id = 'meetion-mk14';

update public.inventory_products set features = array[
  'ABS Plastic',
  'Wired + 2.4G + 3 Bluetooth channels, Tri-Mode',
  'OEM Height Keycaps',
  'Hot-Swappable Switches',
  'Cloud Driver + Local Driver',
  'Silver-Like Switches, POM Material Pivot, Self-Lubricating',
  'RGB Backlight',
  'Two-Stage Height Feet',
  'Multi-System Support: Windows/Mac/iOS/Android',
  '65% Layout',
  '2000mAh Battery'
]::text[]
where legacy_demo_id = 'meetion-mk12';

update public.inventory_products set features = array[
  'Wired + 2.4G + Bluetooth 5.3, Tri-mode, plug-and-play connection',
  'Detachable noise-cancelling microphone',
  'Rotatable ear cups',
  'Adjustable headband',
  '1200mAh battery, 40 hours of working time',
  'Weight: 285g',
  'USB + Type-C combo receiver',
  'Speaker size: 50mm',
  'Frequency response: 20 Hz - 20 kHz'
]::text[]
where legacy_demo_id = 'meetion-bth013';

update public.inventory_products set features = array[
  'ABS Plastic',
  'Scissor structure keyboard',
  'Battery capacity 300mAh',
  '78 keys',
  'Compatible with Mac/Win system',
  'Apple keyboard layout'
]::text[]
where legacy_demo_id = 'meetion-ikey-k210';

update public.inventory_products set features = array[
  'ABS Plastic',
  'Scissor structure keyboard',
  'Battery capacity 300mAh',
  '108 keys',
  'Compatible with Mac/Win system',
  'Apple keyboard layout'
]::text[]
where legacy_demo_id = 'meetion-ikey-k230';

update public.inventory_products set features = array[
  'Battery-Powered Dual-Mode Wireless Keyboard and Mouse Combo',
  'Made of ABS Material',
  '75% Keyboard',
  'Includes: 1 AA Battery, 1 AAA Battery and a User Manual'
]::text[]
where legacy_demo_id = 'meetion-mini5000';
