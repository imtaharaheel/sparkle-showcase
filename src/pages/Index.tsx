import { Navbar } from "@/components/Navbar";
import { GamingHeroSection } from "@/components/GamingHeroSection";
import { QuickSections } from "@/components/QuickSections";
import { TrustSection } from "@/components/TrustSection";
import { MinimalFooter } from "@/components/MinimalFooter";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { StickyWhatsAppCTA } from "@/components/StickyWhatsAppCTA";

const Index = () => {
  return (
    <div className="min-h-screen bg-[#0a0a0f]">
      <Navbar variant="dark" />
      <main>
        <GamingHeroSection />
        <QuickSections />
        <TrustSection />
      </main>
      <MinimalFooter />
      <WhatsAppButton />
      <StickyWhatsAppCTA />
    </div>
  );
};

export default Index;
