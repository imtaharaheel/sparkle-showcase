import { motion } from "framer-motion";

interface LogoProps {
  size?: "sm" | "md" | "lg";
  showText?: boolean;
}

export const Logo = ({ size = "md", showText = true }: LogoProps) => {
  const sizes = {
    sm: { icon: "h-8 w-8", text: "text-lg" },
    md: { icon: "h-10 w-10", text: "text-xl" },
    lg: { icon: "h-14 w-14", text: "text-2xl" },
  };

  return (
    <div className="flex items-center gap-2">
      <motion.div
        className={`relative ${sizes[size].icon} flex items-center justify-center`}
        whileHover={{ scale: 1.05, rotate: 5 }}
        whileTap={{ scale: 0.95 }}
      >
        {/* Logo SVG - Stylized "S" with tech elements */}
        <svg
          viewBox="0 0 48 48"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          className="h-full w-full"
        >
          {/* Background Circle with Gradient */}
          <defs>
            <linearGradient id="logoGradient" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="hsl(348, 83%, 47%)" />
              <stop offset="100%" stopColor="hsl(348, 83%, 30%)" />
            </linearGradient>
            <linearGradient id="shineGradient" x1="0%" y1="0%" x2="100%" y2="100%">
              <stop offset="0%" stopColor="white" stopOpacity="0.3" />
              <stop offset="50%" stopColor="white" stopOpacity="0" />
            </linearGradient>
          </defs>
          
          {/* Main circle */}
          <circle cx="24" cy="24" r="22" fill="url(#logoGradient)" />
          
          {/* Shine effect */}
          <circle cx="24" cy="24" r="22" fill="url(#shineGradient)" />
          
          {/* Stylized "S" letter */}
          <path
            d="M30 16C30 16 27 13 22 13C17 13 14 16 14 19C14 22 16 24 20 25L28 27C32 28 34 31 34 34C34 37 31 40 25 40C19 40 16 37 16 37"
            stroke="white"
            strokeWidth="3.5"
            strokeLinecap="round"
            strokeLinejoin="round"
            fill="none"
          />
          
          {/* Tech accent dots */}
          <circle cx="10" cy="24" r="2" fill="white" fillOpacity="0.6" />
          <circle cx="38" cy="24" r="2" fill="white" fillOpacity="0.6" />
          
          {/* Inner ring */}
          <circle cx="24" cy="24" r="18" stroke="white" strokeOpacity="0.2" strokeWidth="1" fill="none" />
        </svg>
      </motion.div>
      
      {showText && (
        <div className="flex flex-col leading-none">
          <span className={`font-display ${sizes[size].text} font-bold tracking-tight`}>
            <span className="gradient-brand-text">SAIM</span>
          </span>
          <span className="text-[10px] font-medium uppercase tracking-[0.2em] text-muted-foreground">
            Enterprise
          </span>
        </div>
      )}
    </div>
  );
};
