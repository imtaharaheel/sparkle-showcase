import { motion } from "framer-motion";

interface LogoProps {
  size?: "sm" | "md" | "lg";
  showText?: boolean;
}

export const Logo = ({ size = "md", showText = true }: LogoProps) => {
  const sizes = {
    sm: { icon: "h-8 w-8", text: "text-lg", subtext: "text-[8px]" },
    md: { icon: "h-10 w-10", text: "text-xl", subtext: "text-[10px]" },
    lg: { icon: "h-14 w-14", text: "text-2xl", subtext: "text-xs" },
  };

  return (
    <div className="flex items-center gap-3">
      <motion.div
        className={`relative ${sizes[size].icon} flex items-center justify-center`}
        whileHover={{ scale: 1.05, rotate: 5 }}
        whileTap={{ scale: 0.95 }}
      >
        {/* Modern Logo SVG - Abstract "S" with geometric shapes */}
        <svg
          viewBox="0 0 48 48"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          className="h-full w-full drop-shadow-md"
        >
          {/* Gradient Definitions */}
          <defs>
            <linearGradient id="brandGradient" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="hsl(348, 83%, 50%)" />
              <stop offset="50%" stopColor="hsl(348, 83%, 40%)" />
              <stop offset="100%" stopColor="hsl(348, 83%, 30%)" />
            </linearGradient>
            <linearGradient id="innerGlow" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="white" stopOpacity="0.4" />
              <stop offset="100%" stopColor="white" stopOpacity="0" />
            </linearGradient>
            <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
              <feDropShadow dx="0" dy="2" stdDeviation="3" floodColor="hsl(348, 83%, 30%)" floodOpacity="0.3"/>
            </filter>
          </defs>
          
          {/* Outer rounded square */}
          <rect 
            x="4" y="4" 
            width="40" height="40" 
            rx="12" 
            fill="url(#brandGradient)" 
            filter="url(#shadow)"
          />
          
          {/* Inner glow */}
          <rect 
            x="4" y="4" 
            width="40" height="40" 
            rx="12" 
            fill="url(#innerGlow)"
          />
          
          {/* Stylized "SE" monogram */}
          <path
            d="M17 16C17 16 20 14 24 14C28 14 31 16 31 19C31 22 28 24 24 24C20 24 17 26 17 29C17 32 20 34 24 34C28 34 31 32 31 32"
            stroke="white"
            strokeWidth="3"
            strokeLinecap="round"
            strokeLinejoin="round"
            fill="none"
          />
          
          {/* Accent lines */}
          <line x1="33" y1="14" x2="33" y2="22" stroke="white" strokeWidth="2.5" strokeLinecap="round" opacity="0.9"/>
          <line x1="33" y1="20" x2="38" y2="20" stroke="white" strokeWidth="2.5" strokeLinecap="round" opacity="0.9"/>
          
          {/* Decorative dots */}
          <circle cx="11" cy="24" r="1.5" fill="white" fillOpacity="0.6" />
          <circle cx="37" cy="28" r="1.5" fill="white" fillOpacity="0.6" />
        </svg>
      </motion.div>
      
      {showText && (
        <div className="flex flex-col leading-none">
          <span className={`font-display ${sizes[size].text} font-bold tracking-tight`}>
            <span className="gradient-brand-text">SAIM</span>
          </span>
          <span className={`${sizes[size].subtext} font-semibold uppercase tracking-[0.15em] text-muted-foreground`}>
            Enterprise
          </span>
        </div>
      )}
    </div>
  );
};
