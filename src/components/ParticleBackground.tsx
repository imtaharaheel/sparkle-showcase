import { useEffect, useRef, useState, useCallback } from "react";
import { motion } from "framer-motion";

interface Particle {
  id: number;
  x: number;
  y: number;
  size: number;
  speedX: number;
  speedY: number;
  opacity: number;
  hue: number;
}

interface ParticleBackgroundProps {
  particleCount?: number;
  interactive?: boolean;
}

export const ParticleBackground = ({ 
  particleCount = 80,
  interactive = true 
}: ParticleBackgroundProps) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const [particles, setParticles] = useState<Particle[]>([]);
  const [mousePos, setMousePos] = useState({ x: 50, y: 50 });
  const animationRef = useRef<number>();

  useEffect(() => {
    // Initialize particles with varied properties
    const initialParticles: Particle[] = Array.from({ length: particleCount }, (_, i) => ({
      id: i,
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: Math.random() * 4 + 1,
      speedX: (Math.random() - 0.5) * 0.08,
      speedY: (Math.random() - 0.5) * 0.08,
      opacity: Math.random() * 0.6 + 0.2,
      hue: 348 + (Math.random() - 0.5) * 20, // Variation around primary hue
    }));
    setParticles(initialParticles);

    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, [particleCount]);

  useEffect(() => {
    const animate = () => {
      setParticles(prev => 
        prev.map(particle => ({
          ...particle,
          x: ((particle.x + particle.speedX + 100) % 100),
          y: ((particle.y + particle.speedY + 100) % 100),
        }))
      );
      animationRef.current = requestAnimationFrame(animate);
    };

    animationRef.current = requestAnimationFrame(animate);
    return () => {
      if (animationRef.current) {
        cancelAnimationFrame(animationRef.current);
      }
    };
  }, []);

  const handleMouseMove = useCallback((e: React.MouseEvent) => {
    if (!interactive || !containerRef.current) return;
    const rect = containerRef.current.getBoundingClientRect();
    setMousePos({
      x: ((e.clientX - rect.left) / rect.width) * 100,
      y: ((e.clientY - rect.top) / rect.height) * 100,
    });
  }, [interactive]);

  return (
    <div 
      ref={containerRef}
      className="absolute inset-0 -z-10 overflow-hidden"
      onMouseMove={handleMouseMove}
    >
      {/* Base gradient - light background */}
      <div className="absolute inset-0 bg-gradient-to-br from-rose-50/80 via-white to-pink-50/60" />
      
      {/* Large animated gradient orbs */}
      <motion.div
        className="absolute h-[800px] w-[800px] rounded-full blur-3xl"
        style={{
          background: "radial-gradient(circle, hsl(348 83% 60% / 0.15) 0%, hsl(348 83% 50% / 0.05) 50%, transparent 70%)",
          left: "-10%",
          top: "-20%",
        }}
        animate={{
          x: [0, 100, 50, 0],
          y: [0, 50, 100, 0],
          scale: [1, 1.2, 0.9, 1],
        }}
        transition={{ duration: 25, repeat: Infinity, ease: "easeInOut" }}
      />
      
      <motion.div
        className="absolute h-[600px] w-[600px] rounded-full blur-3xl"
        style={{
          background: "radial-gradient(circle, hsl(348 70% 55% / 0.12) 0%, hsl(330 60% 50% / 0.05) 50%, transparent 70%)",
          right: "-5%",
          top: "30%",
        }}
        animate={{
          x: [0, -80, -40, 0],
          y: [0, 60, -40, 0],
          scale: [1, 0.85, 1.15, 1],
        }}
        transition={{ duration: 20, repeat: Infinity, ease: "easeInOut", delay: 3 }}
      />
      
      <motion.div
        className="absolute h-[500px] w-[500px] rounded-full blur-3xl"
        style={{
          background: "radial-gradient(circle, hsl(340 75% 45% / 0.1) 0%, transparent 60%)",
          left: "30%",
          bottom: "-10%",
        }}
        animate={{
          x: [0, 60, -30, 0],
          y: [0, -80, -40, 0],
          scale: [1, 1.1, 0.95, 1],
        }}
        transition={{ duration: 22, repeat: Infinity, ease: "easeInOut", delay: 5 }}
      />
      
      {/* Flowing wave effect */}
      <motion.div
        className="absolute inset-0 opacity-30"
        style={{
          background: "linear-gradient(135deg, transparent 40%, hsl(348 83% 60% / 0.08) 50%, transparent 60%)",
        }}
        animate={{
          backgroundPosition: ["0% 0%", "100% 100%", "0% 0%"],
        }}
        transition={{ duration: 15, repeat: Infinity, ease: "linear" }}
      />
      
      {/* Interactive particles with SVG */}
      <svg className="absolute inset-0 h-full w-full">
        <defs>
          <radialGradient id="particleGlow" cx="50%" cy="50%" r="50%">
            <stop offset="0%" stopColor="hsl(348, 83%, 50%)" stopOpacity="0.8" />
            <stop offset="100%" stopColor="hsl(348, 83%, 50%)" stopOpacity="0" />
          </radialGradient>
        </defs>
        
        {/* Connection lines between nearby particles */}
        {particles.slice(0, 30).map((p1, i) => 
          particles.slice(i + 1, 30).map((p2) => {
            const dx = p1.x - p2.x;
            const dy = p1.y - p2.y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 12) {
              return (
                <motion.line
                  key={`line-${p1.id}-${p2.id}`}
                  x1={`${p1.x}%`}
                  y1={`${p1.y}%`}
                  x2={`${p2.x}%`}
                  y2={`${p2.y}%`}
                  stroke="hsl(348, 83%, 50%)"
                  strokeOpacity={(12 - distance) / 12 * 0.2}
                  strokeWidth="1"
                />
              );
            }
            return null;
          })
        )}
        
        {/* Particles */}
        {particles.map((particle) => {
          const dx = interactive ? particle.x - mousePos.x : 0;
          const dy = interactive ? particle.y - mousePos.y : 0;
          const distance = Math.sqrt(dx * dx + dy * dy);
          const influence = interactive && distance < 15 ? (15 - distance) / 15 : 0;
          
          return (
            <g key={particle.id}>
              {/* Glow effect */}
              <circle
                cx={`${particle.x}%`}
                cy={`${particle.y}%`}
                r={particle.size * 3 + influence * 5}
                fill={`hsl(${particle.hue}, 83%, 50%)`}
                opacity={particle.opacity * 0.15 + influence * 0.1}
              />
              {/* Core particle */}
              <motion.circle
                cx={`${particle.x}%`}
                cy={`${particle.y}%`}
                r={particle.size + influence * 3}
                fill={`hsl(${particle.hue}, 83%, 50%)`}
                opacity={particle.opacity + influence * 0.4}
              />
            </g>
          );
        })}
      </svg>
      
      {/* Grid pattern overlay */}
      <div 
        className="absolute inset-0 opacity-[0.015]"
        style={{
          backgroundImage: `radial-gradient(hsl(348, 83%, 40%) 1px, transparent 1px)`,
          backgroundSize: '50px 50px',
        }}
      />
      
      {/* Floating geometric shapes */}
      <motion.div
        className="absolute left-[8%] top-[25%] h-24 w-24 rounded-full border-2 border-primary/10"
        animate={{ 
          rotate: 360,
          scale: [1, 1.1, 1],
        }}
        transition={{ 
          rotate: { duration: 40, repeat: Infinity, ease: "linear" },
          scale: { duration: 8, repeat: Infinity, ease: "easeInOut" }
        }}
      />
      <motion.div
        className="absolute right-[12%] top-[15%] h-16 w-16 rounded-full border border-primary/15"
        animate={{ 
          rotate: -360,
          y: [0, 20, 0],
        }}
        transition={{ 
          rotate: { duration: 30, repeat: Infinity, ease: "linear" },
          y: { duration: 6, repeat: Infinity, ease: "easeInOut" }
        }}
      />
      <motion.div
        className="absolute right-[20%] bottom-[20%] h-32 w-32 rounded-full border border-primary/8"
        animate={{ 
          rotate: 360,
          x: [0, 15, 0],
        }}
        transition={{ 
          rotate: { duration: 50, repeat: Infinity, ease: "linear" },
          x: { duration: 10, repeat: Infinity, ease: "easeInOut" }
        }}
      />
      <motion.div
        className="absolute left-[25%] bottom-[15%] h-20 w-20 rounded-full border-2 border-primary/12"
        animate={{ 
          rotate: -360,
          scale: [1, 0.9, 1],
        }}
        transition={{ 
          rotate: { duration: 35, repeat: Infinity, ease: "linear" },
          scale: { duration: 7, repeat: Infinity, ease: "easeInOut" }
        }}
      />
      
      {/* Shimmer effect overlay */}
      <motion.div
        className="absolute inset-0 pointer-events-none"
        style={{
          background: "linear-gradient(105deg, transparent 40%, hsl(348 83% 90% / 0.1) 45%, hsl(348 83% 95% / 0.15) 50%, hsl(348 83% 90% / 0.1) 55%, transparent 60%)",
          backgroundSize: "200% 200%",
        }}
        animate={{
          backgroundPosition: ["-100% -100%", "200% 200%"],
        }}
        transition={{ duration: 8, repeat: Infinity, ease: "linear", repeatDelay: 4 }}
      />
    </div>
  );
};
