export interface Product {
  id: string;
  model: string;
  name: string;
  category: 'keyboard' | 'mouse' | 'headset' | 'combo' | 'speaker' | 'microphone' | 'accessory';
  price: number;
  description: string;
  features: string[];
  image: string;
  webLink?: string;
  featured?: boolean;
  badge?: string;
}

export const products: Product[] = [
  // Mechanical Keyboards
  {
    id: "mk14-black",
    model: "MK14 BLACK",
    name: "MK14 Tri-Mode Mechanical Keyboard",
    category: "keyboard",
    price: 11213,
    description: "Premium tri-mode mechanical keyboard with hot-swappable switches and RGB backlit.",
    features: [
      "Wired + 2.4G + Bluetooth Tri-Mode",
      "OEM Profile Keycaps",
      "Hot-Swappable Switches",
      "Cloud Driver Support",
      "Silver-like Switches with POM Material",
      "RGB Backlit",
      "Two-Stage Adjustable Stand",
      "Multi-System Support: Win/Mac/iOS/Android",
      "87% Layout, TKL Design",
      "4000mAh Battery"
    ],
    image: "/products/mk14.png",
    webLink: "www.meetion.com/MT-MK14.html",
    featured: true,
    badge: "Best Seller"
  },
  {
    id: "mk14-white",
    model: "MK14 WHITE",
    name: "MK14 Tri-Mode Mechanical Keyboard",
    category: "keyboard",
    price: 11213,
    description: "Premium tri-mode mechanical keyboard in elegant white finish.",
    features: [
      "Wired + 2.4G + Bluetooth Tri-Mode",
      "87% Layout, TKL Design",
      "4000mAh Battery",
      "Hot-Swappable Switches",
      "RGB Backlit"
    ],
    image: "/products/mk14-white.png",
    webLink: "www.meetion.com/MT-MK14.html"
  },
  {
    id: "mk12-white",
    model: "MK12 WHITE",
    name: "MK12 65% Mechanical Keyboard",
    category: "keyboard",
    price: 10005,
    description: "Compact 65% layout mechanical keyboard with premium features.",
    features: [
      "ABS Plastic Construction",
      "Wired + 2.4G + 3 Bluetooth Channels",
      "OEM Height Keycaps",
      "Hot-Swappable Switches",
      "Cloud Driver + Local Driver",
      "Silver-Like Switches, POM Material",
      "RGB Backlight",
      "Two-Stage Height Feet",
      "65% Layout",
      "2000mAh Battery"
    ],
    image: "/products/mk12.png",
    webLink: "www.meetion.com/MT-MK12.html",
    featured: true,
    badge: "Compact"
  },
  {
    id: "mk12-black",
    model: "MK12 BLACK",
    name: "MK12 65% Mechanical Keyboard",
    category: "keyboard",
    price: 10005,
    description: "Compact 65% layout mechanical keyboard in sleek black.",
    features: [
      "65% Layout",
      "2000mAh Battery",
      "Hot-Swappable Switches",
      "RGB Backlight"
    ],
    image: "/products/mk12-black.png",
    webLink: "www.meetion.com/MT-MK12.html"
  },
  {
    id: "mk009-pro",
    model: "MK009 Pro",
    name: "MK009 Pro Gaming Keyboard",
    category: "keyboard",
    price: 7843,
    description: "Professional gaming keyboard with hot-swappable red switches.",
    features: [
      "Red Switches Hot-Swappable",
      "USB-TypeC Connection",
      "RGB Backlighting",
      "Software Customizable Settings",
      "Detachable Wired Connection"
    ],
    image: "/products/mk009-pro.png",
    webLink: "www.meetion.com/mt-MK009PRD-HOTSWAP.html",
    featured: true,
    badge: "Pro Gaming"
  },
  {
    id: "mk009rd",
    model: "MK009RD",
    name: "MK009 Mechanical Keyboard",
    category: "keyboard",
    price: 5348,
    description: "Hot-swappable mechanical keyboard with rainbow backlighting.",
    features: [
      "Red Switches Hot-Swappable",
      "Rainbow Backlighting",
      "Detachable USB-TypeC",
      "Color Box Packaging"
    ],
    image: "/products/mk009.png",
    webLink: "www.meetion.com/mt-mk009.html"
  },
  {
    id: "mk008-pro",
    model: "MK008 PRO",
    name: "MK008 Pro 80% Gaming Keyboard",
    category: "keyboard",
    price: 6153,
    description: "80% hot sale gaming mechanical keyboard with metal top cover.",
    features: [
      "Metal Top Cover with Knob",
      "Double Injection Keycaps",
      "Detachable Characters with Backlit",
      "Red Switches Hot-Swappable",
      "RGB Backlighting",
      "Software Customizable Settings",
      "Detachable USB-TypeC"
    ],
    image: "/products/mk008-pro.png",
    webLink: "www.meetion.com/MT-MK008Pro.html"
  },
  {
    id: "mk006-pro",
    model: "MK006 PRO",
    name: "MK006 Pro 75% Gaming Keyboard",
    category: "keyboard",
    price: 5727,
    description: "75% gaming mechanical keyboard with metal top cover and knob.",
    features: [
      "Metal Top Cover with Knob",
      "USB-TypeC",
      "Red Switches Hot-Swappable",
      "Wired RGB Backlighting",
      "Software Customizable Settings",
      "Detachable USB-TypeC"
    ],
    image: "/products/mk006-pro.png",
    webLink: "www.meetion.com/MT-MK006Pro.html"
  },
  {
    id: "mk005-black",
    model: "MK005 BLACK",
    name: "MK005 60% Mechanical Keyboard",
    category: "keyboard",
    price: 5520,
    description: "Compact 60% mechanical keyboard with OUTEMU Blue switches.",
    features: [
      "USB Wired",
      "ABS Plastic, 292×102×38mm",
      "60% Keyboard Layout",
      "OUTEMU Blue Switches, 50 Million",
      "Monochromatic Mixed Light",
      "TypeC-USB Cable: 1.8m"
    ],
    image: "/products/mk005.png",
    webLink: "www.meetion.com/mt-mk005.html"
  },
  {
    id: "mk005bt",
    model: "MK005BT",
    name: "MK005 Bluetooth Mechanical Keyboard",
    category: "keyboard",
    price: 8280,
    description: "Wireless Bluetooth mechanical keyboard with 60% layout.",
    features: [
      "TypeC-USB Bluetooth",
      "OUTEMU Blue Switches, 50 Million",
      "Monochromatic Mixed Light",
      "TypeC-USB Cable: 1.8m"
    ],
    image: "/products/mk005bt.png",
    webLink: "www.meetion.com/mt-mk005bt.html"
  },
  {
    id: "k9320",
    model: "K9320",
    name: "K9320 Rainbow Gaming Keyboard",
    category: "keyboard",
    price: 2168,
    description: "Affordable membrane keyboard with rainbow backlight.",
    features: [
      "USB Wired",
      "Membrane Type",
      "Rainbow Backlight",
      "30 Million Keystrokes"
    ],
    image: "/products/k9320.png",
    webLink: "www.meetion.com/mt-K9320.html"
  },
  
  // Gaming Mice
  {
    id: "gm23-2023",
    model: "GM23",
    name: "GM23 RGB Gaming Mouse",
    category: "mouse",
    price: 3680,
    description: "High-performance gaming mouse with adjustable weight.",
    features: [
      "ABS Plastic, 128×81×40mm",
      "RGB Backlight",
      "12800 DPI / 6000 FPS",
      "15g Weight / 60 IPS",
      "1000Hz Polling Rate",
      "5+ Million Clicks",
      "Software Support",
      "Adjustable Weight"
    ],
    image: "/products/gm23.png",
    webLink: "www.meetion.com/mt-gm23_2023.html",
    featured: true,
    badge: "High DPI"
  },
  {
    id: "gm21-2023",
    model: "GM21",
    name: "GM21 RGB Gaming Mouse",
    category: "mouse",
    price: 3048,
    description: "Precision gaming mouse with RGB lighting.",
    features: [
      "ABS Plastic, 119×65×39mm",
      "RGB Backlight",
      "10000 DPI / 7000 FPS",
      "20g Weight / 60 IPS",
      "1000Hz Polling Rate",
      "3+ Million Clicks",
      "Software Support"
    ],
    image: "/products/gm21.png",
    webLink: "www.meetion.com/MT-GM21.html"
  },
  {
    id: "gm19-2023",
    model: "GM19",
    name: "GM19 RGB Gaming Mouse",
    category: "mouse",
    price: 3335,
    description: "Ergonomic gaming mouse with high precision sensor.",
    features: [
      "ABS Plastic, 123×67×43mm",
      "RGB Backlight",
      "12000 DPI / 7000 FPS",
      "20g Weight / 60 IPS",
      "1000Hz Polling Rate",
      "5+ Million Clicks",
      "Software Support"
    ],
    image: "/products/gm19.png",
    webLink: "www.meetion.com/MT-GM19.html"
  },
  {
    id: "gm015",
    model: "GM015",
    name: "GM015 RGB Gaming Mouse",
    category: "mouse",
    price: 2415,
    description: "Affordable gaming mouse with RGB lighting.",
    features: [
      "ABS Plastic, 123×62×42mm",
      "RGB Backlight",
      "6400 DPI / 6000 FPS",
      "22.5g Weight / 30 IPS",
      "1000Hz Polling Rate",
      "5+ Million Clicks",
      "Software Support"
    ],
    image: "/products/gm015.png",
    webLink: "www.meetion.com/MT-GM015.html"
  },
  {
    id: "gw38-black",
    model: "GW38 BLACK",
    name: "GW38 Tri-Mode Gaming Mouse",
    category: "mouse",
    price: 6325,
    description: "Premium wireless gaming mouse with charging dock.",
    features: [
      "Wired + 2.4G + Bluetooth Tri-Mode",
      "Medium to Large Hand Size",
      "Plug-and-Play Wired Connection",
      "Local Driver Support",
      "Charging Dock Included",
      "RGB LED",
      "Max 8000 DPI",
      "PAW3104 Sensor",
      "650mAh Battery"
    ],
    image: "/products/gw38.png",
    webLink: "www.meetion.com/MT-GW38.html",
    featured: true,
    badge: "Wireless"
  },
  {
    id: "gw32",
    model: "GW32",
    name: "GW32 Tri-Mode Gaming Mouse",
    category: "mouse",
    price: 5520,
    description: "Ergonomic wireless gaming mouse with long battery life.",
    features: [
      "Wired + 2.4G + Bluetooth Tri-Mode",
      "Right-Hand Ergonomic",
      "Side Scroll Wheel",
      "RGB LED",
      "Max 8000 DPI",
      "PAW3220 Sensor",
      "700mAh Battery",
      "35 Hours Light ON / 115 Hours Light OFF"
    ],
    image: "/products/gw32.png",
    webLink: "www.meetion.com/MT-GW32.html"
  },
  {
    id: "m930-v23",
    model: "M930",
    name: "M930 Gaming Mouse",
    category: "mouse",
    price: 1898,
    description: "Budget-friendly gaming mouse with 4-color backlight.",
    features: [
      "ABS Plastic, 127×72×39mm",
      "4-Color Backlight",
      "Max 3200 DPI",
      "2+ Million Clicks",
      "PVC Cable"
    ],
    image: "/products/m930.png",
    webLink: "www.meetion.com/MT-M930.html"
  },
  {
    id: "m915",
    model: "M915",
    name: "M915 Wired Mouse",
    category: "mouse",
    price: 1380,
    description: "Comfortable wired mouse with backlight.",
    features: [
      "ABS Plastic, 135×73×42mm",
      "4-Color Backlight",
      "Max 2400 DPI",
      "3+ Million Clicks",
      "PVC Cable"
    ],
    image: "/products/m915.png",
    webLink: "www.meetion.com/MT-M915.html"
  },
  
  // Headsets
  {
    id: "bth013",
    model: "BTH013",
    name: "BTH013 Tri-Mode Gaming Headset",
    category: "headset",
    price: 8625,
    description: "Premium wireless gaming headset with 40-hour battery.",
    features: [
      "Wired + 2.4G + Bluetooth 5.3 Tri-Mode",
      "Detachable Noise-Cancelling Microphone",
      "Rotatable Ear Cups",
      "Adjustable Headband",
      "1200mAh Battery, 40 Hours",
      "285g Weight",
      "USB + Type-C Combo Receiver",
      "50mm Speaker Size",
      "20Hz - 20kHz Frequency"
    ],
    image: "/products/bth013.png",
    featured: true,
    badge: "Premium"
  },
  {
    id: "hp099",
    model: "HP099",
    name: "HP099 7.1 Surround Gaming Headset",
    category: "headset",
    price: 4830,
    description: "USB gaming headset with 7.1 HiFi surround sound.",
    features: [
      "ABS Plastic, 210×230×95mm",
      "φ50mm Speaker Unit",
      "32Ω±15% / 118±3db",
      "10-20,000Hz Frequency",
      "φ6.0mm Microphone",
      "USB Stereo",
      "1.80m Cable",
      "HiFi 7.1 Surround"
    ],
    image: "/products/hp099.png",
    webLink: "www.meetion.com/MT-HP099.html"
  },
  {
    id: "hp030",
    model: "HP030",
    name: "HP030 USB Gaming Headset",
    category: "headset",
    price: 4140,
    description: "Comfortable USB gaming headset with volume control.",
    features: [
      "ABS Plastic, 200×115×220mm",
      "Volume Control on Headset",
      "32Ω / 10-20,000Hz",
      "φ6.0mm Microphone",
      "USB Stereo",
      "1.80m Cable"
    ],
    image: "/products/hp030.png",
    webLink: "www.meetion.com/MT-HP030.html"
  },
  {
    id: "hp022",
    model: "HP022",
    name: "HP022 Gaming Headset",
    category: "headset",
    price: 2875,
    description: "Versatile gaming headset with dual connectivity.",
    features: [
      "ABS Plastic",
      "32Ω / 10-20,000Hz",
      "φ6.0mm Microphone",
      "φ3.5mm Stereo Jack×2 + USB×1",
      "1.80m Cable"
    ],
    image: "/products/hp022.png",
    webLink: "www.meetion.com/MT-HP022.html"
  },
  {
    id: "hp021",
    model: "HP021",
    name: "HP021 Gaming Headset",
    category: "headset",
    price: 2645,
    description: "Entry-level gaming headset with clear audio.",
    features: [
      "ABS Plastic",
      "32Ω / 10-20,000Hz",
      "φ6.0mm Microphone",
      "φ3.5mm Stereo Jack×2 + USB×1",
      "1.80m Cable"
    ],
    image: "/products/hp021.png",
    webLink: "www.meetion.com/MT-HP021.html"
  },
  {
    id: "hp020",
    model: "HP020",
    name: "HP020 USB Gaming Headset",
    category: "headset",
    price: 3261,
    description: "Comfortable gaming headset with volume control.",
    features: [
      "ABS Plastic, 185×210×110mm",
      "Volume Control on Headset",
      "32Ω / 10-20,000Hz",
      "φ6.0mm Microphone",
      "φ3.5mm Stereo Jack×2 + USB×1",
      "1.80m Cable"
    ],
    image: "/products/hp020.png",
    webLink: "www.meetion.com/MT-HP020.html"
  },
  {
    id: "hp010",
    model: "HP010",
    name: "HP010 Wired Headset",
    category: "headset",
    price: 2254,
    description: "Budget-friendly wired headset for gaming.",
    features: [
      "ABS Plastic, 250×88×75mm",
      "Volume Control on Wire",
      "32Ω / 10-20,000Hz",
      "φ6.0mm Microphone",
      "φ3.5mm Stereo Jack×2",
      "1.80m Cable"
    ],
    image: "/products/hp010.png",
    webLink: "www.meetion.com/MT-HP010.html"
  },

  // Gaming Combos
  {
    id: "c490",
    model: "C490",
    name: "C490 4-in-1 Gaming Kit",
    category: "combo",
    price: 5336,
    description: "Complete gaming kit with mouse, keyboard, headset and mousepad.",
    features: [
      "Mouse: 6D/3200DPI/4000FPS/30IPS",
      "Keyboard: Membrane/Rainbow Backlight",
      "Headset: RGB/φ3.5 Stereo+USB",
      "MousePad: Soft Cloth with Rubber Base"
    ],
    image: "/products/c490.png",
    webLink: "www.meetion.com/mt-C490.html",
    featured: true,
    badge: "Value Pack"
  },
  {
    id: "c505",
    model: "C505",
    name: "C505 4-in-1 Gaming Kit",
    category: "combo",
    price: 5980,
    description: "Premium gaming kit with enhanced components.",
    features: [
      "Mouse: 6D/3200DPI/4000FPS/30IPS",
      "Keyboard: Membrane/Rainbow Backlight",
      "Headset: RGB/φ3.5 Stereo+USB",
      "MousePad: Soft Cloth with Rubber Base, 3mm"
    ],
    image: "/products/c505.png",
    webLink: "www.meetion.com/mt-C505.html"
  },

  // Speakers
  {
    id: "sp2011",
    model: "SP2011",
    name: "SP2011 2.0 Desktop Speaker",
    category: "speaker",
    price: 2093,
    description: "Compact 2.0 desktop speaker system.",
    features: [
      "RMS: 3W×2",
      "2-inch Driver Unit×2",
      "150Hz-20KHz Frequency",
      ">30dB Separation",
      "DC 5V Power Input",
      "Volume Control",
      "Size: 67×79×98mm"
    ],
    image: "/products/sp2011.png",
    webLink: "www.meetion.com/MT-SP2011.html"
  },
  {
    id: "sp2111",
    model: "SP2111",
    name: "SP2111 2.1 Speaker System",
    category: "speaker",
    price: 5578,
    description: "Powerful 2.1 speaker system with subwoofer.",
    features: [
      "RMS: 5W + 3W×2",
      "3-inch + 2-inch×2 Driver Units",
      "150Hz-20KHz Frequency",
      ">30dB Separation",
      "DC 5V Power Input",
      "Volume Control",
      "Subwoofer: 110×131×158mm"
    ],
    image: "/products/sp2111.png",
    webLink: "www.meetion.com/MT-SP2111.html"
  },

  // Microphones
  {
    id: "mc20",
    model: "MC20",
    name: "MC20 Gaming Microphone",
    category: "microphone",
    price: 5980,
    description: "USB-C gaming/streaming microphone with RGB.",
    features: [
      "ABS Plastic",
      "Game/Live Mic",
      "φ16.1×7.0mm Mic Unit",
      "40Hz-18KHz Frequency",
      "Omnidirectional",
      "USB-TypeC, 2.20m Cable"
    ],
    image: "/products/mc20.png",
    webLink: "www.meetion.com/MT-MC20.html"
  },
  {
    id: "mc13",
    model: "MC13",
    name: "MC13 Desktop Microphone",
    category: "microphone",
    price: 2668,
    description: "Compact desktop microphone with ON/OFF switch.",
    features: [
      "ABS Plastic",
      "Mic Switch ON/OFF",
      "φ6×5mm Mic Unit",
      "50Hz-10KHz Frequency",
      "Omnidirectional",
      "USB 2.0, 2.20m Cable"
    ],
    image: "/products/mc13.png",
    webLink: "www.meetion.com/MT-MC13.html"
  },

  // Office Combos
  {
    id: "cw295",
    model: "CW295",
    name: "CW295 Wireless Keyboard & Mouse Combo",
    category: "combo",
    price: 3220,
    description: "Battery-powered 2.4G wireless office combo.",
    features: [
      "2.4G Wireless",
      "ABS Material",
      "Full-Size Keyboard",
      "Ergonomic Ambidextrous Mouse",
      "1 AA + 1 AAA Battery Included"
    ],
    image: "/products/cw295.png",
    webLink: "www.meetion.com/MT-CW295.html"
  },
  {
    id: "mini5000",
    model: "Mini5000",
    name: "Mini5000 75% Wireless Combo",
    category: "combo",
    price: 3680,
    description: "Compact dual-mode wireless keyboard and mouse combo.",
    features: [
      "Battery-Powered Dual-Mode",
      "ABS Material",
      "75% Keyboard Layout",
      "1 AA + 1 AAA Battery Included"
    ],
    image: "/products/mini5000.png"
  },

  // Wireless Mice
  {
    id: "r545-black",
    model: "R545 BLACK",
    name: "R545 Wireless Mouse",
    category: "mouse",
    price: 1093,
    description: "Compact wireless mouse for everyday use.",
    features: [
      "2.4G Wireless",
      "2+1 Buttons",
      "Max 1600 DPI",
      "AA×1 Battery"
    ],
    image: "/products/r545.png"
  },
  {
    id: "r547-black",
    model: "R547 BLACK",
    name: "R547 Wireless Mouse",
    category: "mouse",
    price: 1265,
    description: "Ergonomic wireless mouse with extra button.",
    features: [
      "2.4G Wireless",
      "3+1 Buttons",
      "Max 1600 DPI",
      "AA×1 Battery"
    ],
    image: "/products/r547.png"
  },
  {
    id: "m360",
    model: "M360",
    name: "M360 Silent Wired Mouse",
    category: "mouse",
    price: 978,
    description: "Silent wired mouse for quiet environments.",
    features: [
      "Wired USB",
      "5 Million Silent Switch",
      "1200 DPI",
      "1.5m Cable"
    ],
    image: "/products/m360.png"
  }
];

export const categories = [
  { id: 'keyboard', name: 'Keyboards', icon: '⌨️' },
  { id: 'mouse', name: 'Gaming Mice', icon: '🖱️' },
  { id: 'headset', name: 'Headsets', icon: '🎧' },
  { id: 'combo', name: 'Gaming Combos', icon: '🎮' },
  { id: 'speaker', name: 'Speakers', icon: '🔊' },
  { id: 'microphone', name: 'Microphones', icon: '🎤' },
] as const;

export const featuredProducts = products.filter(p => p.featured);

export const getProductsByCategory = (category: string) => 
  products.filter(p => p.category === category);

export const getProductById = (id: string) => 
  products.find(p => p.id === id);

export const formatPrice = (price: number) => 
  `Rs. ${price.toLocaleString('en-PK')}`;
