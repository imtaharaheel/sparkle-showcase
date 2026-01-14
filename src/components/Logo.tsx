import { motion } from "framer-motion";

interface LogoProps {
  size?: "sm" | "md" | "lg";
  showText?: boolean;
}

export const Logo = ({ size = "md", showText = true }: LogoProps) => {
  const sizes = {
    sm: { icon: "h-9 w-9", text: "text-lg", subtext: "text-[8px]" },
    md: { icon: "h-11 w-11", text: "text-xl", subtext: "text-[10px]" },
    lg: { icon: "h-16 w-16", text: "text-2xl", subtext: "text-xs" },
  };

  return (
    <div className="flex items-center gap-3">
      <motion.div
        className={`relative ${sizes[size].icon} flex items-center justify-center`}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        {/* Modern Logo SVG - Abstract "S" with geometric flow */}
        <svg
          viewBox="0 0 56 56"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          className="h-full w-full"
        >
          {/* Gradient Definitions */}
          <defs>
            <linearGradient id="logoGradient1" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="#be185d" />
              <stop offset="50%" stopColor="#9f1239" />
              <stop offset="100%" stopColor="#881337" />
            </linearGradient>
            <linearGradient id="logoGradient2" x1="100%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" stopColor="#f43f5e" />
              <stop offset="100%" stopColor="#be185d" />
            </linearGradient>
            <linearGradient id="logoShine" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="white" stopOpacity="0.3" />
              <stop offset="50%" stopColor="white" stopOpacity="0.1" />
              <stop offset="100%" stopColor="white" stopOpacity="0" />
            </linearGradient>
            <filter id="logoShadow" x="-20%" y="-20%" width="140%" height="140%">
              <feDropShadow dx="0" dy="2" stdDeviation="2" floodColor="#9f1239" floodOpacity="0.4"/>
            </filter>
          </defs>
          
          {/* Background circle with gradient */}
          <circle 
            cx="28" 
            cy="28" 
            r="26" 
            fill="url(#logoGradient1)" 
            filter="url(#logoShadow)"
          />
          
          {/* Inner ring */}
          <circle 
            cx="28" 
            cy="28" 
            r="22" 
            fill="none"
            stroke="url(#logoGradient2)"
            strokeWidth="1.5"
            opacity="0.5"
          />
          
          {/* Stylized "S" - flowing design */}
          <path
            d="M36 18C36 18 32 14 26 14C20 14 16 18 16 22C16 26 20 28 26 29C32 30 38 32 38 38C38 44 32 48 26 48C20 48 16 44 16 44"
            stroke="white"
            strokeWidth="4"
            strokeLinecap="round"
            strokeLinejoin="round"
            fill="none"
          />
          
          {/* Accent dot top */}
          <circle cx="38" cy="16" r="3" fill="white" opacity="0.9" />
          
          {/* Accent dot bottom */}
          <circle cx="14" cy="46" r="2.5" fill="white" opacity="0.7" />
          
          {/* Shine overlay */}
          <circle 
            cx="28" 
            cy="28" 
            r="26" 
            fill="url(#logoShine)"
          />
        </svg>
      </motion.div>
      
      {showText && (
        <div className="flex flex-col leading-none">
          <span className={`font-display ${sizes[size].text} font-bold tracking-tight`}>
            <span className="gradient-brand-text">SAIM</span>
          </span>
          <span className={`${sizes[size].subtext} font-semibold uppercase tracking-[0.2em] text-muted-foreground`}>
            Enterprise
          </span>
        </div>
      )}
    </div>
  );
};
