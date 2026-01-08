import { useEffect, useRef, useState } from "react";
import { motion } from "framer-motion";

interface Particle {
  id: number;
  x: number;
  y: number;
  size: number;
  speedX: number;
  speedY: number;
  opacity: number;
}

interface ParticleBackgroundProps {
  particleCount?: number;
  interactive?: boolean;
}

export const ParticleBackground = ({ 
  particleCount = 50,
  interactive = true 
}: ParticleBackgroundProps) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const [particles, setParticles] = useState<Particle[]>([]);
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 });
  const animationRef = useRef<number>();

  useEffect(() => {
    // Initialize particles
    const initialParticles: Particle[] = Array.from({ length: particleCount }, (_, i) => ({
      id: i,
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: Math.random() * 3 + 1,
      speedX: (Math.random() - 0.5) * 0.05,
      speedY: (Math.random() - 0.5) * 0.05,
      opacity: Math.random() * 0.5 + 0.2,
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

  const handleMouseMove = (e: React.MouseEvent) => {
    if (!interactive || !containerRef.current) return;
    const rect = containerRef.current.getBoundingClientRect();
    setMousePos({
      x: ((e.clientX - rect.left) / rect.width) * 100,
      y: ((e.clientY - rect.top) / rect.height) * 100,
    });
  };

  return (
    <div 
      ref={containerRef}
      className="absolute inset-0 -z-10 overflow-hidden"
      onMouseMove={handleMouseMove}
    >
      {/* Base gradient */}
      <div className="absolute inset-0 bg-gradient-to-br from-secondary via-background to-accent/20" />
      
      {/* Animated gradient orbs */}
      <motion.div
        className="absolute h-[600px] w-[600px] rounded-full opacity-30"
        style={{
          background: "radial-gradient(circle, hsl(348 83% 40% / 0.3) 0%, transparent 70%)",
          left: "10%",
          top: "20%",
        }}
        animate={{
          x: [0, 50, 0],
          y: [0, 30, 0],
          scale: [1, 1.1, 1],
        }}
        transition={{ duration: 15, repeat: Infinity, ease: "easeInOut" }}
      />
      <motion.div
        className="absolute h-[500px] w-[500px] rounded-full opacity-20"
        style={{
          background: "radial-gradient(circle, hsl(348 60% 50% / 0.25) 0%, transparent 70%)",
          right: "15%",
          bottom: "10%",
        }}
        animate={{
          x: [0, -40, 0],
          y: [0, -50, 0],
          scale: [1, 0.9, 1],
        }}
        transition={{ duration: 18, repeat: Infinity, ease: "easeInOut", delay: 2 }}
      />
      
      {/* Particles */}
      <svg className="absolute inset-0 h-full w-full">
        {particles.map((particle) => {
          // Calculate distance from mouse for interactive effect
          const dx = interactive ? particle.x - mousePos.x : 0;
          const dy = interactive ? particle.y - mousePos.y : 0;
          const distance = Math.sqrt(dx * dx + dy * dy);
          const influence = interactive && distance < 20 ? (20 - distance) / 20 : 0;
          
          return (
            <motion.circle
              key={particle.id}
              cx={`${particle.x}%`}
              cy={`${particle.y}%`}
              r={particle.size + influence * 2}
              fill="hsl(348, 83%, 40%)"
              opacity={particle.opacity + influence * 0.3}
              initial={false}
            />
          );
        })}
        
        {/* Connection lines between nearby particles */}
        {particles.slice(0, 20).map((p1, i) => 
          particles.slice(i + 1, 20).map((p2) => {
            const dx = p1.x - p2.x;
            const dy = p1.y - p2.y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 15) {
              return (
                <line
                  key={`${p1.id}-${p2.id}`}
                  x1={`${p1.x}%`}
                  y1={`${p1.y}%`}
                  x2={`${p2.x}%`}
                  y2={`${p2.y}%`}
                  stroke="hsl(348, 83%, 40%)"
                  strokeOpacity={(15 - distance) / 15 * 0.15}
                  strokeWidth="1"
                />
              );
            }
            return null;
          })
        )}
      </svg>
      
      {/* Grid pattern overlay */}
      <div 
        className="absolute inset-0 opacity-[0.02]"
        style={{
          backgroundImage: `radial-gradient(hsl(var(--primary)) 1px, transparent 1px)`,
          backgroundSize: '40px 40px',
        }}
      />
      
      {/* Floating rings */}
      <motion.div
        className="absolute left-[10%] top-[30%] h-32 w-32 rounded-full border border-primary/10"
        animate={{ rotate: 360 }}
        transition={{ duration: 30, repeat: Infinity, ease: "linear" }}
      />
      <motion.div
        className="absolute right-[15%] bottom-[20%] h-48 w-48 rounded-full border border-primary/5"
        animate={{ rotate: -360 }}
        transition={{ duration: 40, repeat: Infinity, ease: "linear" }}
      />
    </div>
  );
};
