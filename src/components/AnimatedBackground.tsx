import { motion } from "framer-motion";
import { ParticleBackground } from "./ParticleBackground";

interface AnimatedBackgroundProps {
  variant?: "hero" | "featured" | "categories" | "gradient" | "particles";
}

export const AnimatedBackground = ({ variant = "hero" }: AnimatedBackgroundProps) => {
  if (variant === "hero" || variant === "particles") {
    return <ParticleBackground particleCount={60} interactive={true} />;
  }

  if (variant === "featured") {
    return (
      <div className="absolute inset-0 -z-10 overflow-hidden">
        {/* Animated gradient background */}
        <div className="absolute inset-0 bg-gradient-to-b from-background via-secondary/50 to-background" />
        
        {/* Moving wave shapes */}
        <motion.div
          className="absolute -bottom-20 left-0 right-0 h-40"
          style={{
            background: "linear-gradient(180deg, transparent 0%, hsl(var(--primary) / 0.05) 100%)",
            borderRadius: "100% 100% 0 0",
          }}
          animate={{ y: [0, -10, 0] }}
          transition={{ duration: 6, repeat: Infinity, ease: "easeInOut" }}
        />
        
        {/* Subtle floating circles */}
        <motion.div
          className="absolute right-10 top-20 h-64 w-64 rounded-full border border-primary/10"
          animate={{ 
            rotate: 360,
            scale: [1, 1.05, 1],
          }}
          transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
        />
        <motion.div
          className="absolute left-10 bottom-20 h-48 w-48 rounded-full border border-primary/5"
          animate={{ 
            rotate: -360,
          }}
          transition={{ duration: 25, repeat: Infinity, ease: "linear" }}
        />
        
        {/* Floating particles */}
        {[...Array(8)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute h-2 w-2 rounded-full bg-primary/20"
            style={{
              left: `${10 + i * 12}%`,
              top: `${20 + (i % 4) * 20}%`,
            }}
            animate={{
              y: [0, -40, 0],
              opacity: [0.2, 0.6, 0.2],
            }}
            transition={{
              duration: 4 + i * 0.5,
              repeat: Infinity,
              ease: "easeInOut",
              delay: i * 0.3,
            }}
          />
        ))}
      </div>
    );
  }

  if (variant === "categories") {
    return (
      <div className="absolute inset-0 -z-10 overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-t from-secondary/30 via-background to-background" />
        
        {/* Animated mesh gradient */}
        <motion.div
          className="absolute inset-0 opacity-30"
          style={{
            background: `
              radial-gradient(ellipse at 20% 30%, hsl(var(--primary) / 0.1) 0%, transparent 50%),
              radial-gradient(ellipse at 80% 70%, hsl(var(--primary) / 0.08) 0%, transparent 50%),
              radial-gradient(ellipse at 50% 50%, hsl(var(--accent) / 0.1) 0%, transparent 60%)
            `,
          }}
          animate={{
            opacity: [0.2, 0.4, 0.2],
          }}
          transition={{ duration: 8, repeat: Infinity, ease: "easeInOut" }}
        />
        
        {/* Horizontal lines animation */}
        {[...Array(3)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute h-px w-full bg-gradient-to-r from-transparent via-primary/10 to-transparent"
            style={{ top: `${30 + i * 20}%` }}
            animate={{ x: ["-100%", "100%"] }}
            transition={{
              duration: 15 + i * 5,
              repeat: Infinity,
              ease: "linear",
              delay: i * 2,
            }}
          />
        ))}
        
        {/* Animated orbs */}
        <motion.div
          className="absolute -top-20 right-[20%] h-96 w-96 rounded-full bg-primary/5 blur-3xl"
          animate={{
            y: [0, 30, 0],
            x: [0, -20, 0],
          }}
          transition={{ duration: 12, repeat: Infinity, ease: "easeInOut" }}
        />
      </div>
    );
  }

  // Gradient variant
  return (
    <div className="absolute inset-0 -z-10 overflow-hidden">
      <motion.div
        className="absolute inset-0"
        style={{
          background: "linear-gradient(45deg, hsl(var(--secondary)), hsl(var(--background)), hsl(var(--accent)))",
          backgroundSize: "400% 400%",
        }}
        animate={{
          backgroundPosition: ["0% 50%", "100% 50%", "0% 50%"],
        }}
        transition={{ duration: 15, repeat: Infinity, ease: "easeInOut" }}
      />
    </div>
  );
};
