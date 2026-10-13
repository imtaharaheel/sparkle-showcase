-- Meetion: corrected key features and specification tables (2026-10-13).
-- Rebuilds tables scrambled on import (C490, C505, C4120, iKey C230, HP020, HP021), fixes labels and typos,
-- and replaces key features that were copied spec rows with readable points from the same data.

update public.inventory_products set
  features = array['40mm audio driver', 'Omni-directional microphone', 'Type-C cable, 1.2m', 'Weighs about 135g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-bth002';  -- Meetion BTH002 Bluetooth Call Center Headset

update public.inventory_products set
  features = array['40mm audio drivers', 'Omni-directional microphone', 'Type-C cable, 1.2m', 'Weighs about 180g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-bth003mic';  -- Meetion BTH003MIC Bluetooth Headset with Mic

update public.inventory_products set
  features = array['Wired + 2.4G + Bluetooth 5.3, Tri-mode, plug-and-play connection', 'Detachable noise-cancelling microphone', 'Rotatable ear cups', 'Adjustable headband', '1200mAh battery, 40 hours of working time', 'USB + Type-C combo receiver', 'Speaker size: 50mm', 'Frequency response: 20 Hz - 20 kHz']::text[]
where legacy_demo_id = 'meetion-bth013';  -- Meetion BTH013 Tri-Mode Wireless Gaming Headset

update public.inventory_products set
  specifications = '[{"label": "Operation Mode", "value": "Opto-electronic"}, {"label": "Type", "value": "2.4GHz & Bluetooth Dual Mode"}, {"label": "Power Type", "value": "Rechargeable"}, {"label": "Interface", "value": "Type-C"}, {"label": "Key life", "value": "5 million times"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Weight", "value": "95±5g"}, {"label": "Product Size", "value": "104*83*55mm"}, {"label": "Resolution", "value": "2400DPI (800-1200-1800-2400)"}, {"label": "Number of buttons", "value": "7+1"}, {"label": "Feature", "value": "Right-handed Wireless Ergonomic Vertical Design"}, {"label": "Battery capacity", "value": "500mAh"}, {"label": "Charging time", "value": "1.5H"}, {"label": "Working time", "value": "100H"}]'::jsonb
where legacy_demo_id = 'meetion-btm008';  -- Meetion BTM008 Vertical Ergonomic Wireless Mouse

update public.inventory_products set
  features = array['2.4G and Bluetooth dual mode', 'Adjustable DPI: 800 / 1200 / 1600 / 2400 / 3200', 'Silent switches rated 3 million clicks', 'Wireless range 10m', 'Runs on 1 x AA battery, about 220 hours', 'Weighs about 66g']::text[]
where legacy_demo_id = 'meetion-btm185';  -- Meetion BTM185 Dual-Mode Silent Wireless Mouse

update public.inventory_products set
  features = array['Wired keyboard and mouse set', '104-key keyboard and 3-button mouse', '1200 DPI mouse', 'USB cable, 1.5m', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-c235';  -- Meetion C235 Wired Keyboard & Mouse Combo

update public.inventory_products set
  features = array['2.4GHz wireless keyboard and mouse set', '104/105-key keyboard and 4-button mouse', 'Mouse DPI: 800 / 1200 / 1600', 'USB nano receiver', 'Keyboard runs on 1 x AAA battery, mouse on 1 x AA', 'Works with Windows and Mac']::text[],
  specifications = '[{"label": "Set", "value": "Wireless keyboard and mouse"}, {"label": "Connection", "value": "2.4GHz wireless, USB nano receiver"}, {"label": "Keyboard: keys", "value": "104/105"}, {"label": "Keyboard: battery", "value": "1 x AAA"}, {"label": "Keyboard: size", "value": "433 x 133 x 23.5 mm"}, {"label": "Keyboard: weight", "value": "415 ±5 g"}, {"label": "Mouse: buttons", "value": "4"}, {"label": "Mouse: resolution", "value": "800 / 1200 / 1600 DPI"}, {"label": "Mouse: battery", "value": "1 x AA"}, {"label": "Mouse: size", "value": "110 x 60 x 37 mm"}, {"label": "Mouse: weight", "value": "60 ±2 g"}, {"label": "Compatible systems", "value": "Windows XP/Vista/7/8/10/11, Mac OS"}]'::jsonb
where legacy_demo_id = 'meetion-c4120-little';  -- Meetion C4120 Wireless Keyboard & Mouse Combo

update public.inventory_products set
  features = array['4-in-1 set: keyboard, mouse, headset and mouse pad', '104/105-key keyboard with 12 shortcut keys', '4-button mouse, 800 / 1600 / 2400 DPI', 'Headset with 40mm speakers and omni-directional microphone', 'Mouse pad: 280 x 200 x 3 mm', 'Works with Windows and Mac']::text[],
  specifications = '[{"label": "Set", "value": "Keyboard, mouse, headset and mouse pad"}, {"label": "Keyboard: layout", "value": "104/105 keys"}, {"label": "Keyboard: shortcut keys", "value": "12"}, {"label": "Keyboard: key life", "value": "More than 10 million presses"}, {"label": "Keyboard: interface", "value": "USB"}, {"label": "Keyboard: cable length", "value": "180 cm"}, {"label": "Keyboard: size", "value": "470 x 188.5 x 34.5 mm (approx.)"}, {"label": "Mouse: buttons", "value": "4"}, {"label": "Mouse: resolution", "value": "800 / 1600 / 2400 DPI"}, {"label": "Mouse: polling rate", "value": "Up to 250 Hz"}, {"label": "Mouse: frame rate", "value": "Up to 4000 fps"}, {"label": "Mouse: tracking speed", "value": "Up to 30 ips"}, {"label": "Mouse: acceleration", "value": "Up to 8 g"}, {"label": "Mouse: cable length", "value": "180 cm"}, {"label": "Mouse: size", "value": "120 x 60 x 38.5 mm (approx.)"}, {"label": "Headset: speaker", "value": "40 mm"}, {"label": "Headset: impedance", "value": "32Ω ±15%"}, {"label": "Headset: frequency response", "value": "20 Hz – 20 kHz"}, {"label": "Headset: microphone", "value": "Omni-directional"}, {"label": "Headset: mic sensitivity", "value": "-38 ±3 dB"}, {"label": "Mouse pad: size", "value": "280 x 200 x 3 mm"}, {"label": "Mouse pad: weight", "value": "90 ±5 g"}, {"label": "Compatible systems", "value": "Windows XP/Vista/7/8/10/11, Mac OS"}]'::jsonb
where legacy_demo_id = 'meetion-c490';  -- Meetion C490 4-in-1 Gaming Kit

update public.inventory_products set
  features = array['4-in-1 set: keyboard, mouse, headset and mouse pad', '104/105-key keyboard with 12 shortcut keys', '6-button mouse, 800 / 1600 / 2400 / 3200 DPI', 'Headset with 40mm speakers and omni-directional microphone', 'Mouse pad: 320 x 240 x 5 mm', 'Works with Windows and Mac']::text[],
  specifications = '[{"label": "Set", "value": "Keyboard, mouse, headset and mouse pad"}, {"label": "Keyboard: layout", "value": "104/105 keys"}, {"label": "Keyboard: shortcut keys", "value": "12"}, {"label": "Keyboard: key life", "value": "More than 10 million presses"}, {"label": "Keyboard: interface", "value": "USB"}, {"label": "Keyboard: cable length", "value": "180 cm"}, {"label": "Keyboard: size", "value": "480 x 198 x 34 mm (approx.)"}, {"label": "Mouse: buttons", "value": "6"}, {"label": "Mouse: resolution", "value": "800 / 1600 / 2400 / 3200 DPI"}, {"label": "Mouse: polling rate", "value": "Up to 250 Hz"}, {"label": "Mouse: frame rate", "value": "Up to 4000 fps"}, {"label": "Mouse: tracking speed", "value": "Up to 30 ips"}, {"label": "Mouse: acceleration", "value": "Up to 8 g"}, {"label": "Mouse: cable length", "value": "180 cm"}, {"label": "Mouse: size", "value": "130 x 69 x 41.5 mm (approx.)"}, {"label": "Headset: speaker", "value": "40 mm"}, {"label": "Headset: sensitivity", "value": "120 ±3 dB"}, {"label": "Headset: impedance", "value": "32Ω"}, {"label": "Headset: frequency response", "value": "10 Hz – 20 kHz"}, {"label": "Headset: microphone", "value": "Omni-directional"}, {"label": "Mouse pad: size", "value": "320 x 240 x 5 mm"}, {"label": "Mouse pad: weight", "value": "146 ±5 g"}, {"label": "Compatible systems", "value": "Windows XP/Vista/7/8/10/11, Mac OS"}]'::jsonb
where legacy_demo_id = 'meetion-c505';  -- Meetion C505 4-in-1 Gaming Kit

update public.inventory_products set
  features = array['Adjustable armrests', 'Extendable footrest', 'Headrest with 45° rotation', 'Reclines up to 126°', 'Nylon mesh back', 'Chair height 114–122cm']::text[]
where legacy_demo_id = 'meetion-chr-31';  -- Meetion CHR31 Gaming Chair

update public.inventory_products set
  features = array['Adjustable armrests', 'Extendable footrest', 'Three-level backrest height adjustment', 'Headrest with 45° rotation', 'Reclines up to 126°', 'Nylon mesh back', 'Chair height 114–122cm']::text[]
where legacy_demo_id = 'meetion-chr-32';  -- Meetion CHR32 Gaming Chair

update public.inventory_products set
  features = array['Fits 9–14" laptops', '15° operating angle', 'Two USB ports', '60cm cable', 'Weighs about 440g']::text[]
where legacy_demo_id = 'meetion-cp2020';  -- Meetion CP2020 Laptop Cooling Pad

update public.inventory_products set
  features = array['Fits 9–15.6" laptops', 'Adjustable angle: 6.5–40°', 'Two USB ports', '60cm cable', 'Weighs about 740g']::text[]
where legacy_demo_id = 'meetion-cp3030';  -- Meetion CP3030 Laptop Cooling Pad

update public.inventory_products set
  features = array['Fits 9–17" laptops', 'Adjustable angle: 6.5–45°', 'Two USB ports', '60cm cable', 'Weighs about 740g']::text[]
where legacy_demo_id = 'meetion-cp4040';  -- Meetion CP4040 Laptop Cooling Pad

update public.inventory_products set
  features = array['Fits 9–19" laptops', 'Adjustable angle: 6.5–45°', 'Two USB ports', '60cm cable', 'Weighs about 1150g']::text[]
where legacy_demo_id = 'meetion-cp5050';  -- Meetion CP5050 Laptop Cooling Pad

update public.inventory_products set
  specifications = '[{"label": "Product name", "value": "MT-CW216"}, {"label": "Battery", "value": "Keyboard: AAA*2 Mouse: AA*1"}, {"label": "Model", "value": "CW216"}, {"label": "Working Time", "value": "Keyboard: About 1200H Mouse: About 250H"}, {"label": "Number of keys", "value": "Keyboard: 105 keys Mouse: 4 keys"}, {"label": "Weight", "value": "Keyboard: 380±5g Mouse: 64.2g ±5 g"}, {"label": "Connection method", "value": "2.4G"}, {"label": "Size", "value": "Keyboard: 438*126*28mm Mouse: 107*63*40mm"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "WIN7/8/10/11/Vista/MacOS"}, {"label": "Keyboard Type", "value": "Membrane"}, {"label": "Multimedia Keys", "value": "Yes"}, {"label": "Color", "value": "Black"}, {"label": "Keyboard Tilt Angle", "value": "6°"}, {"label": "Storage Temperature", "value": "-20° to 60°"}, {"label": "Working Temperature", "value": "0-40°"}]'::jsonb
where legacy_demo_id = 'meetion-cw216';  -- Meetion CW216 Wireless Keyboard & Mouse Combo

update public.inventory_products set
  specifications = '[{"label": "Product name", "value": "MT- CW235"}, {"label": "Battery", "value": "Keyboard: AAA*1 Mouse: AA*1"}, {"label": "Model", "value": "CW235"}, {"label": "Charging time", "value": "None"}, {"label": "Number of keys", "value": "Keyboard: 104 keys Mouse: 3 Buttons"}, {"label": "Working time", "value": "Keyboard: About 480H Mouse: About 100H"}, {"label": "Connection method", "value": "2.4G Wireless"}, {"label": "Multi-media Keys", "value": "Yes"}, {"label": "Transmission distance", "value": "10m"}, {"label": "System compatibility", "value": "Win XP/7/8/10/11, Vista, MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Weight", "value": "Keyboard: 383±5g Mouse: 45±5g"}, {"label": "Keyboard type", "value": "Membrane"}, {"label": "Size", "value": "Keyboard: 450*135*25mm Mouse: 105*60*40mm"}, {"label": "Color", "value": "Black"}, {"label": "DPI", "value": "1200"}, {"label": "Storage Temperature", "value": "-20~60°"}, {"label": "Operation Temperature", "value": "0~40°"}]'::jsonb
where legacy_demo_id = 'meetion-cw235';  -- Meetion CW235 Wireless Keyboard & Mouse Combo

update public.inventory_products set
  features = array['Up to 6400 CPI', '7 + 1 buttons', 'RGB lighting', 'Polling rate 125–1000 Hz', 'USB cable, 1.8m', 'Works with Windows and Mac']::text[],
  specifications = '[{"label": "Model", "value": "GM015"}, {"label": "Color", "value": "Black"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "123 * 66 * 42mm"}, {"label": "Resolution", "value": "6400CPI"}, {"label": "Weight", "value": "122±5g"}, {"label": "Buttons", "value": "7 + 1 Keys"}, {"label": "Game Type", "value": "FPS / MMORPG / MOBA / RTS"}, {"label": "Polling Rate", "value": "125-1000 Hz / ms"}, {"label": "Frame Rate", "value": "Max 6000 fps"}, {"label": "Max Tracking Speed", "value": "30ips"}, {"label": "Max Acceleration", "value": "22.5G"}, {"label": "Compatible systems", "value": "Win XP / Vista / 7 / 8 / 10 / MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable Length", "value": "1.8 ± 0.1m"}]'::jsonb
where legacy_demo_id = 'meetion-gm015';  -- Meetion GM015 Honeycomb RGB Gaming Mouse

update public.inventory_products set
  features = array['Up to 6400 DPI', '6 + 1 buttons', 'RGB lighting', 'Polling rate 125 Hz', 'Teflon feet', 'USB cable, 1.8m']::text[]
where legacy_demo_id = 'meetion-gm19';  -- Meetion GM19 RGB Gaming Mouse

update public.inventory_products set
  features = array['Up to 12000 CPI', '6 + 1 buttons', 'RGB lighting', 'Polling rate 125–1000 Hz', 'USB cable, 1.8m', 'Works with Windows and Mac']::text[],
  specifications = '[{"label": "Model", "value": "GM21_2023"}, {"label": "Color", "value": "Black"}, {"label": "Back light", "value": "RGB Colorful"}, {"label": "Dimension", "value": "127 * 65 * 49mm"}, {"label": "Resolution", "value": "12000CPI"}, {"label": "Weight", "value": "119±5g"}, {"label": "Buttons", "value": "6 + 1 Keys"}, {"label": "Game Type", "value": "FPS / MMORPG / MOBA / RTS"}, {"label": "Polling Rate", "value": "125-1000 Hz / ms"}, {"label": "Frame Rate", "value": "Max 7000 fps"}, {"label": "Max Tracking Speed", "value": "60ips"}, {"label": "Max Acceleration", "value": "20G"}, {"label": "Compatible systems", "value": "Win XP / Vista / 7 / 8 / 10 / MAC OS"}, {"label": "Interface", "value": "USB"}, {"label": "Cable Length", "value": "1.8 ± 0.1m"}]'::jsonb
where legacy_demo_id = 'meetion-gm21';  -- Meetion GM21 RGB Gaming Mouse

update public.inventory_products set
  features = array['Up to 12800 CPI', '5 + 1 buttons', 'RGB lighting', 'Polling rate 125–1000 Hz', 'USB cable, 1.8m', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-gm23';  -- Meetion GM23 RGB Gaming Mouse

update public.inventory_products set
  features = array['40mm audio driver', 'Omni-directional microphone', '3.5mm plug, 1.2m cable', 'Weighs about 155g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-hp002';  -- Meetion HP002 3.5mm Call Center Headset

update public.inventory_products set
  features = array['USB call-centre headset', '40mm audio driver', 'Omni-directional microphone', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-hp002u';  -- Meetion HP002U USB Call Center Headset

update public.inventory_products set
  features = array['40mm audio drivers', 'Omni-directional microphone', '3.5mm plug, 1.2m cable', 'Weighs about 195g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-hp003';  -- Meetion HP003 3.5mm Office Headset

update public.inventory_products set
  features = array['40mm audio drivers', 'Omni-directional microphone', 'USB plug, 1.2m cable', 'Weighs about 200g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-hp003u';  -- Meetion HP003U USB Office Headset

update public.inventory_products set
  features = array['40mm audio drivers', 'Omni-directional microphone', 'Two 3.5mm audio plugs', '2m cable', 'Weighs about 264g']::text[]
where legacy_demo_id = 'meetion-hp010';  -- Meetion HP010 Wired Gaming Headset

update public.inventory_products set
  features = array['50mm audio drivers', 'Omni-directional microphone', '3.5mm stereo jack plus USB', '2.4m cable', 'Weighs about 290g']::text[],
  specifications = '[{"label": "Model", "value": "MT-HP020"}, {"label": "Color", "value": "Black"}, {"label": "Speaker", "value": "φ50mm"}, {"label": "Dimension", "value": "185*110*210mm"}, {"label": "Sensitivity", "value": "120±3db"}, {"label": "Weight", "value": "290±5g"}, {"label": "Impedance", "value": "32Ω"}, {"label": "Frequency response", "value": "10~20,000Hz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Interface", "value": "φ3.5mm stereo jack plus USB"}, {"label": "Cable length", "value": "2.4±0.01m"}]'::jsonb
where legacy_demo_id = 'meetion-hp020';  -- Meetion HP020 Gaming Headset

update public.inventory_products set
  features = array['50mm audio drivers', 'Omni-directional microphone', '3.5mm stereo jack plus USB', '2.2m cable']::text[],
  specifications = '[{"label": "Model", "value": "MT-HP021"}, {"label": "Speaker", "value": "φ50mm"}, {"label": "Sensitivity", "value": "120±3db"}, {"label": "Impedance", "value": "32Ω"}, {"label": "Frequency response", "value": "20~20,000Hz"}, {"label": "Microphone", "value": "Omni-directional"}, {"label": "Mic unit diameter", "value": "φ6.0±5.0mm"}, {"label": "Mic sensitivity", "value": "-35±3db"}, {"label": "Interface", "value": "φ3.5mm stereo jack plus USB"}, {"label": "Cable length", "value": "2.20±0.01m"}, {"label": "Dimensions", "value": "206*93*226mm"}]'::jsonb
where legacy_demo_id = 'meetion-hp021';  -- Meetion HP021 Gaming Headset

update public.inventory_products set
  features = array['40mm audio drivers', 'USB plug, 1.8m cable', 'PU and fabric finish', 'Works with Windows, macOS and Android', 'Weighs about 211g']::text[]
where legacy_demo_id = 'meetion-hp022';  -- Meetion HP022 Gaming Headset

update public.inventory_products set
  features = array['50mm audio drivers', 'Omni-directional microphone', 'Gold-plated USB plug', '2.2m cable', 'Weighs about 298g']::text[]
where legacy_demo_id = 'meetion-hp030';  -- Meetion HP030 7.1 USB Gaming Headset

update public.inventory_products set
  features = array['Slim keyboard and mouse set', '109-key keyboard with silent scissor keys', '2.4G wireless plus three Bluetooth channels', 'Rechargeable 300mAh battery, about 150 hours of use', 'Charges in about 2–3 hours (Type-C)', 'Works with Mac, iOS, Windows and Android']::text[],
  specifications = '[{"label": "Model", "value": "iKey C230"}, {"label": "Set", "value": "Keyboard and mouse"}, {"label": "Keyboard keys", "value": "109 keys, silent scissor switches"}, {"label": "Connection", "value": "2.4G + three Bluetooth channels"}, {"label": "Wireless range", "value": "10 m"}, {"label": "Charging port", "value": "Type-C"}, {"label": "Battery", "value": "300mAh rechargeable"}, {"label": "Charging time", "value": "About 2–3 hours"}, {"label": "Battery life", "value": "About 150 hours"}, {"label": "Multimedia keys", "value": "Yes"}, {"label": "Colour options", "value": "Black grey / Rose gold / Silver white / Purple"}, {"label": "Compatible systems", "value": "Mac, iOS, Windows and Android"}]'::jsonb
where legacy_demo_id = 'meetion-ikey-c230';  -- Meetion iKey C230 Slim Wireless Keyboard & Mouse Combo

update public.inventory_products set
  specifications = '[{"label": "Model", "value": "iKey K230"}, {"label": "Color", "value": "Black grey/Rose gold/Silver white/Purple"}, {"label": "Type", "value": "2.4GHz & Bluetooth Dual Mode"}, {"label": "Dimension", "value": "421*117*12mm"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Weight", "value": "563±5g"}, {"label": "No. of Keys", "value": "109 Keys"}, {"label": "Compatible Systems", "value": "Support Mac/iOS/Win/Android four systems"}, {"label": "Keys", "value": "Silent scissor feet"}, {"label": "Interface", "value": "Type-C"}, {"label": "Battery", "value": "300mAh"}, {"label": "Charging time", "value": "About 2-3H"}, {"label": "Battery life", "value": "About 150H"}, {"label": "Key function", "value": "Support multimedia function keys"}]'::jsonb
where legacy_demo_id = 'meetion-ikey-k230';  -- Meetion iKey K230 Slim Rechargeable Wireless Keyboard

update public.inventory_products set
  features = array['104/105 keys', 'USB cable, 1.8m', 'Weighs about 415g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-k200';  -- Meetion K200 USB Keyboard

update public.inventory_products set
  features = array['104/105-key membrane keyboard', 'USB cable, 1.5m', 'Weighs about 640g', 'Works with Windows and Mac']::text[],
  specifications = '[{"label": "Model", "value": "MT-K9320"}, {"label": "Color", "value": "Black"}, {"label": "No. of keys", "value": "104/105"}, {"label": "Dimension", "value": "465*171*35mm"}, {"label": "Keyboard type", "value": "Membrane"}, {"label": "Weight", "value": "640±5g"}, {"label": "Cable length", "value": "1.50±0.01m"}, {"label": "Interface", "value": "USB"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/11/MAC OS"}]'::jsonb
where legacy_demo_id = 'meetion-k9320';  -- Meetion K9320 Rainbow Backlit Gaming Keyboard

update public.inventory_products set
  features = array['1000 DPI', '2 + 1 buttons', 'USB cable, 1.5m', 'Weighs about 75g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-m360';  -- Meetion M360 Wired Mouse

update public.inventory_products set
  features = array['Adjustable DPI: 800 / 1200 / 1600 / 2400', '5 + 1 buttons (with scroll wheel)', 'Polling rate 250 Hz', 'USB cable, 1.6m', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-m915';  -- Meetion M915 Backlit Wired Gaming Mouse

update public.inventory_products set
  features = array['Adjustable DPI: 800 / 1200 / 2400 / 3200', '5 + 1 buttons (with scroll wheel)', 'Polling rate up to 250 Hz', 'Weighs about 95g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-m930';  -- Meetion M930 Wired Gaming Mouse

update public.inventory_products set
  features = array['USB capacitive microphone', 'Omnidirectional pickup', 'Frequency range 50Hz – 10kHz', '2.2m cable', 'Weighs about 145g']::text[]
where legacy_demo_id = 'meetion-mc13';  -- Meetion MC13 Desktop Microphone

update public.inventory_products set
  features = array['USB Type-C capacitive microphone', 'Frequency range 40Hz – 18kHz', '1m cable', 'Weighs about 480g']::text[]
where legacy_demo_id = 'meetion-mc20';  -- Meetion MC20 Gaming Microphone

update public.inventory_products set
  features = array['61/62-key mechanical keyboard', 'Full-key anti-ghosting', 'Type-C to USB cable, 1.8m', 'Weighs about 555g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-mk005';  -- Meetion MK005 60% Mechanical Keyboard

update public.inventory_products set
  features = array['61/62-key mechanical keyboard', 'Full-key anti-ghosting', 'Type-C to USB cable, 1.8m', 'Weighs about 555g', 'Works with Windows, Mac, iOS, Android and HarmonyOS']::text[],
  specifications = '[{"label": "Model", "value": "MT-MK005BT"}, {"label": "Color", "value": "Black\\White"}, {"label": "No. of keys", "value": "61/62"}, {"label": "Dimension", "value": "292*102*38mm"}, {"label": "Anti-Ghosting", "value": "Full keys"}, {"label": "Weight", "value": "555±5g"}, {"label": "Keyboard type", "value": "Mechanical"}, {"label": "Interface", "value": "Type-C - USB Cable"}, {"label": "Compatible Systems", "value": "Win XP/Vista/7/8/10/MAC OS/ iOS/Android/HarmonyOS"}, {"label": "Cable length", "value": "1.8±0.01m"}]'::jsonb
where legacy_demo_id = 'meetion-mk005bt';  -- Meetion MK005BT 60% Bluetooth Mechanical Keyboard

update public.inventory_products set
  features = array['80/81 + 1 key mechanical keyboard', 'Red switches rated 50 million keystrokes', 'RGB backlight', 'ABS double-shot keycaps', 'Full-key anti-ghosting', 'Type-C cable, 1.8m']::text[]
where legacy_demo_id = 'meetion-mk006-pro';  -- Meetion MK006 Pro 75% RGB Mechanical Keyboard

update public.inventory_products set
  features = array['87/88 + 1 key mechanical keyboard', 'Red switches rated 50 million keystrokes', 'RGB backlight', 'ABS double-shot keycaps', 'Full-key anti-ghosting', 'Type-C cable, 1.8m']::text[]
where legacy_demo_id = 'meetion-mk008-pro';  -- Meetion MK008 Pro 80% RGB Mechanical Keyboard

update public.inventory_products set
  features = array['104/105 + 1 key mechanical keyboard', 'Red switches rated 50 million keystrokes', 'RGB backlight', 'ABS double-shot keycaps', 'Full-key anti-ghosting', 'Type-C cable, 1.8m']::text[]
where legacy_demo_id = 'meetion-mk009-pro';  -- Meetion MK009 Pro RGB Mechanical Keyboard with Knob

update public.inventory_products set
  features = array['Extended size: 790 x 345 x 5 mm', 'Fabric surface', 'Rubber base', 'Weighs about 650g']::text[]
where legacy_demo_id = 'meetion-p100';  -- Meetion P100 Extended Gaming Mouse Pad

update public.inventory_products set
  features = array['RGB LED lighting', 'Size: 355 x 265 x 4 mm', 'Rubber base with fibre surface', 'USB powered (Micro USB cable)']::text[]
where legacy_demo_id = 'meetion-pd120';  -- Meetion PD120 RGB Gaming Mouse Pad

update public.inventory_products set
  features = array['RGB LED lighting', 'Large size: 880 x 310 x 4 mm', 'Rubber base with fibre surface', 'USB powered (Micro USB cable)']::text[]
where legacy_demo_id = 'meetion-pd121';  -- Meetion PD121 Large RGB Gaming Mouse Pad

update public.inventory_products set
  features = array['2.4GHz wireless with USB receiver', '1600 DPI', 'Wireless range 10m', 'Runs on 1 x AA battery', 'Weighs about 70g']::text[],
  specifications = '[{"label": "Model", "value": "R545"}, {"label": "Color", "value": "Black\\Blue\\White\\Pink\\Cyan"}, {"label": "Operation Mode", "value": "Opto-electronic"}, {"label": "Dimension", "value": "100 * 60 * 39mm"}, {"label": "Type", "value": "2.4GHz Wireless"}, {"label": "Weight", "value": "70±5g"}, {"label": "Power Type", "value": "Battery AA*1"}, {"label": "Receiver", "value": "USB"}, {"label": "Key life", "value": "5 million times"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Resolution", "value": "1600dpi"}, {"label": "Rated voltage / current", "value": "3.7V / 8mA"}]'::jsonb
where legacy_demo_id = 'meetion-r545';  -- Meetion R545 Wireless Mouse

update public.inventory_products set
  features = array['2.4GHz wireless', 'Adjustable DPI: 800 / 1200 / 1600', 'Silent switches rated 3 million clicks', 'Wireless range 10m', 'Runs on 2 x AAA batteries, about 200 hours', 'Weighs about 55g']::text[]
where legacy_demo_id = 'meetion-r546';  -- Meetion R546 Wireless Mouse

update public.inventory_products set
  features = array['2.4GHz wireless with USB receiver', '1600 DPI', 'Wireless range 10m', 'Runs on 1 x AA battery', 'Weighs about 58g']::text[],
  specifications = '[{"label": "Model", "value": "R547"}, {"label": "Color", "value": "Black\\Gray\\Red\\Green\\Blue"}, {"label": "Operation Mode", "value": "Opto-electronic"}, {"label": "Dimension", "value": "106 * 60 * 34mm"}, {"label": "Type", "value": "2.4GHz Wireless"}, {"label": "Weight", "value": "58±2g"}, {"label": "Power Type", "value": "Battery AA*1"}, {"label": "Receiver", "value": "USB"}, {"label": "Key life", "value": "5 million times"}, {"label": "Wireless distance", "value": "10m"}, {"label": "Resolution", "value": "1600dpi"}, {"label": "Rated voltage / current", "value": "3.7V / 8mA"}]'::jsonb
where legacy_demo_id = 'meetion-r547';  -- Meetion R547 Wireless Mouse

update public.inventory_products set
  features = array['2.4GHz wireless with USB nano receiver', 'Adjustable DPI: 800 / 1200 / 1600', '4 buttons', 'Runs on 1 x AA battery', 'Weighs about 60g', 'Works with Windows and Mac']::text[]
where legacy_demo_id = 'meetion-r560';  -- Meetion R560 Wireless Mouse

update public.inventory_products set
  features = array['2.4G plus two Bluetooth channels', 'Adjustable DPI: 800 / 1200 / 1600 / 2400 / 3200', 'Switches rated 3 million clicks', 'Rechargeable 300mAh battery, about 60 hours of use', 'Charges in about 1 hour (Type-C)', 'Wireless range 10m']::text[]
where legacy_demo_id = 'meetion-r571';  -- Meetion R571 Silent Wireless Mouse
