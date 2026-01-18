import { motion } from "framer-motion";
import { MapPin, Phone, Mail, Clock, Award, Users, Truck, Shield } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { Footer } from "@/components/Footer";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { AnimatedBackground } from "@/components/AnimatedBackground";
import { Logo } from "@/components/Logo";

const stats = [
  { icon: Award, value: "10+", label: "Years Experience" },
  { icon: Users, value: "5000+", label: "Happy Customers" },
  { icon: Truck, value: "50+", label: "Products" },
  { icon: Shield, value: "100%", label: "Quality Assured" },
];

const team = [
  {
    name: "Saim Saudagar",
    role: "Founder & CEO",
    description: "Visionary leader with 10+ years in the tech industry",
  },
  {
    name: "Technical Team",
    role: "Product Specialists",
    description: "Expert team for product consultation and support",
  },
  {
    name: "Sales Team",
    role: "Customer Relations",
    description: "Dedicated team ensuring best customer experience",
  },
];

const About = () => {
  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      
      <main className="pt-20 md:pt-24">
        {/* Hero Section */}
        <section className="relative overflow-hidden py-20 md:py-32">
          <AnimatedBackground variant="particles" />
          
          <div className="container mx-auto px-4">
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6 }}
              className="mx-auto max-w-3xl text-center"
            >
              <span className="mb-4 inline-block rounded-full border border-primary/30 bg-primary/10 px-4 py-1.5 text-sm font-medium text-primary">
                About Us
              </span>
              <h1 className="mb-6 font-display text-4xl font-bold text-foreground md:text-5xl lg:text-6xl">
                Your Trusted Partner for{" "}
                <span className="gradient-brand-text">Premium Gaming Gear</span>
              </h1>
              <p className="text-lg text-muted-foreground md:text-xl">
                Saim Enterprise has been serving Pakistan's gaming community since 2016, 
                providing top-quality peripherals at competitive prices.
              </p>
            </motion.div>
          </div>
        </section>

        {/* Stats Section */}
        <section className="border-y border-border bg-secondary/30 py-16">
          <div className="container mx-auto px-4">
            <div className="grid grid-cols-2 gap-8 md:grid-cols-4">
              {stats.map((stat, index) => (
                <motion.div
                  key={stat.label}
                  initial={{ opacity: 0, y: 20 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: index * 0.1 }}
                  className="text-center"
                >
                  <div className="mx-auto mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-primary/10">
                    <stat.icon className="h-7 w-7 text-primary" />
                  </div>
                  <div className="font-display text-3xl font-bold text-foreground md:text-4xl">
                    {stat.value}
                  </div>
                  <div className="text-sm text-muted-foreground">{stat.label}</div>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        {/* Our Story Section */}
        <section className="py-20 md:py-28">
          <div className="container mx-auto px-4">
            <div className="grid gap-12 lg:grid-cols-2 lg:items-center">
              <motion.div
                initial={{ opacity: 0, x: -30 }}
                whileInView={{ opacity: 1, x: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6 }}
              >
                <h2 className="mb-6 font-display text-3xl font-bold text-foreground md:text-4xl">
                  Our Story
                </h2>
                <div className="space-y-4 text-muted-foreground">
                  <p>
                    Founded in 2016, Saim Enterprise started with a simple mission: to bring 
                    world-class gaming peripherals to Pakistani gamers at affordable prices.
                  </p>
                  <p>
                    What began as a small operation has grown into one of Pakistan's most trusted 
                    distributors of gaming gear. We partner directly with manufacturers like 
                    Meetion to ensure authentic products and competitive pricing.
                  </p>
                  <p>
                    Our commitment to quality, customer service, and fair pricing has earned us 
                    the trust of thousands of customers across Pakistan. Whether you're a casual 
                    gamer or a professional esports player, we have the gear you need to elevate 
                    your gaming experience.
                  </p>
                </div>
              </motion.div>
              
              <motion.div
                initial={{ opacity: 0, x: 30 }}
                whileInView={{ opacity: 1, x: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.6 }}
                className="relative"
              >
                <div className="aspect-video overflow-hidden rounded-2xl bg-gradient-to-br from-primary/20 to-accent/20 p-8">
                  <div className="flex h-full items-center justify-center">
                    <motion.div
                      className="text-center"
                      animate={{ y: [0, -10, 0] }}
                      transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                    >
                      <div className="flex justify-center mb-4">
                        <Logo size="lg" showText={false} />
                      </div>
                      <span className="font-display text-3xl font-bold gradient-brand-text md:text-5xl">
                        SAIM ENTERPRISE
                      </span>
                      <p className="mt-2 text-lg text-muted-foreground">Est. 2016</p>
                    </motion.div>
                  </div>
                </div>
              </motion.div>
            </div>
          </div>
        </section>

        {/* Team Section */}
        <section className="relative overflow-hidden py-20 md:py-28">
          <AnimatedBackground variant="featured" />
          
          <div className="container mx-auto px-4">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="mb-12 text-center"
            >
              <h2 className="mb-4 font-display text-3xl font-bold text-foreground md:text-4xl">
                Our Team
              </h2>
              <p className="mx-auto max-w-2xl text-muted-foreground">
                A dedicated team working to bring you the best gaming peripherals
              </p>
            </motion.div>

            <div className="grid gap-8 md:grid-cols-3">
              {team.map((member, index) => (
                <motion.div
                  key={member.name}
                  initial={{ opacity: 0, y: 30 }}
                  whileInView={{ opacity: 1, y: 0 }}
                  viewport={{ once: true }}
                  transition={{ delay: index * 0.1 }}
                  whileHover={{ y: -5 }}
                  className="rounded-2xl border border-border bg-card p-8 text-center shadow-sm transition-shadow hover:shadow-lg"
                >
                  <div className="mx-auto mb-4 flex h-20 w-20 items-center justify-center rounded-full bg-gradient-to-br from-primary/20 to-accent/20">
                    <Users className="h-10 w-10 text-primary" />
                  </div>
                  <h3 className="mb-1 font-display text-xl font-semibold text-foreground">
                    {member.name}
                  </h3>
                  <p className="mb-3 text-sm font-medium text-primary">{member.role}</p>
                  <p className="text-sm text-muted-foreground">{member.description}</p>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        {/* Location Section */}
        <section className="py-20 md:py-28">
          <div className="container mx-auto px-4">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="mb-12 text-center"
            >
              <h2 className="mb-4 font-display text-3xl font-bold text-foreground md:text-4xl">
                Visit Us
              </h2>
              <p className="mx-auto max-w-2xl text-muted-foreground">
                Located in the heart of Karachi, we're always ready to serve you
              </p>
            </motion.div>

            <div className="grid gap-8 lg:grid-cols-2">
              <motion.div
                initial={{ opacity: 0, x: -30 }}
                whileInView={{ opacity: 1, x: 0 }}
                viewport={{ once: true }}
                className="space-y-6"
              >
                <div className="flex items-start gap-4 rounded-xl border border-border bg-card p-6">
                  <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-primary/10">
                    <MapPin className="h-6 w-6 text-primary" />
                  </div>
                  <div>
                    <h3 className="mb-1 font-semibold text-foreground">Address</h3>
                    <p className="text-muted-foreground">
                      Computer Market, Saddar<br />
                      Karachi, Sindh, Pakistan
                    </p>
                  </div>
                </div>

                <div className="flex items-start gap-4 rounded-xl border border-border bg-card p-6">
                  <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-primary/10">
                    <Phone className="h-6 w-6 text-primary" />
                  </div>
                  <div>
                    <h3 className="mb-1 font-semibold text-foreground">Phone</h3>
                    <p className="text-muted-foreground">+92 334 2914563</p>
                    <a 
                      href="https://wa.me/9233442914563" 
                      className="text-sm text-primary hover:underline"
                      target="_blank"
                      rel="noopener noreferrer"
                    >
                      Chat on WhatsApp →
                    </a>
                  </div>
                </div>

                <div className="flex items-start gap-4 rounded-xl border border-border bg-card p-6">
                  <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-primary/10">
                    <Mail className="h-6 w-6 text-primary" />
                  </div>
                  <div>
                    <h3 className="mb-1 font-semibold text-foreground">Email</h3>
                    <p className="text-muted-foreground">contact@saimenterprise.com</p>
                  </div>
                </div>

                <div className="flex items-start gap-4 rounded-xl border border-border bg-card p-6">
                  <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-primary/10">
                    <Clock className="h-6 w-6 text-primary" />
                  </div>
                  <div>
                    <h3 className="mb-1 font-semibold text-foreground">Business Hours</h3>
                    <p className="text-muted-foreground">
                      Monday - Saturday: 10:00 AM - 8:00 PM<br />
                      Sunday: 12:00 PM - 6:00 PM
                    </p>
                  </div>
                </div>
              </motion.div>

              <motion.div
                initial={{ opacity: 0, x: 30 }}
                whileInView={{ opacity: 1, x: 0 }}
                viewport={{ once: true }}
                className="overflow-hidden rounded-2xl border border-border bg-card"
              >
                <iframe
                  src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3620.2763915666!2d67.0299!3d24.8615!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMjTCsDUxJzQxLjQiTiA2N8KwMDEnNDcuNiJF!5e0!3m2!1sen!2s!4v1234567890"
                  width="100%"
                  height="100%"
                  style={{ border: 0, minHeight: "400px" }}
                  allowFullScreen
                  loading="lazy"
                  referrerPolicy="no-referrer-when-downgrade"
                  title="Saim Enterprise Location"
                />
              </motion.div>
            </div>
          </div>
        </section>
      </main>

      <Footer />
      <WhatsAppButton />
    </div>
  );
};

export default About;
