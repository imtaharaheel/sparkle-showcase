import { motion } from "framer-motion";

interface AnimatedBackgroundProps {
  variant?: "hero" | "featured" | "categories" | "gradient";
}

export const AnimatedBackground = ({ variant = "hero" }: AnimatedBackgroundProps) => {
  if (variant === "hero") {
    return (
      <div className="absolute inset-0 -z-10 overflow-hidden">
        {/* Base gradient */}
        <div className="absolute inset-0 bg-gradient-to-br from-secondary via-background to-accent/30" />
        
        {/* Animated blobs */}
        <motion.div
          className="absolute -top-40 -right-40 h-96 w-96 rounded-full bg-primary/10 blur-3xl"
          animate={{
            x: [0, 30, 0],
            y: [0, -20, 0],
            scale: [1, 1.1, 1],
          }}
          transition={{ duration: 8, repeat: Infinity, ease: "easeInOut" }}
        />
        <motion.div
          className="absolute top-1/2 -left-40 h-80 w-80 rounded-full bg-primary/5 blur-3xl"
          animate={{
            x: [0, 20, 0],
            y: [0, 30, 0],
            scale: [1, 0.9, 1],
          }}
          transition={{ duration: 10, repeat: Infinity, ease: "easeInOut", delay: 1 }}
        />
        <motion.div
          className="absolute bottom-0 right-1/4 h-72 w-72 rounded-full bg-accent/20 blur-3xl"
          animate={{
            x: [0, -25, 0],
            y: [0, -15, 0],
          }}
          transition={{ duration: 12, repeat: Infinity, ease: "easeInOut", delay: 2 }}
        />
        
        {/* Floating particles */}
        {[...Array(6)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute h-2 w-2 rounded-full bg-primary/20"
            style={{
              left: `${15 + i * 15}%`,
              top: `${20 + (i % 3) * 25}%`,
            }}
            animate={{
              y: [0, -30, 0],
              opacity: [0.2, 0.6, 0.2],
            }}
            transition={{
              duration: 4 + i,
              repeat: Infinity,
              ease: "easeInOut",
              delay: i * 0.5,
            }}
          />
        ))}
        
        {/* Grid pattern overlay */}
        <div 
          className="absolute inset-0 opacity-[0.03]"
          style={{
            backgroundImage: `radial-gradient(hsl(var(--primary)) 1px, transparent 1px)`,
            backgroundSize: '30px 30px',
          }}
        />
      </div>
    );
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
            background: "linear-gradient(180deg, transparent 0%, hsl(var(--primary) / 0.03) 100%)",
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
