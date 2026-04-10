import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";

// https://vitejs.dev/config/
// GitHub Pages project sites: set VITE_BASE=/repo-name/ in CI (see .github/workflows/deploy.yml).
// Vercel / Netlify at domain root: leave unset (defaults to /).
export default defineConfig(({ mode }) => ({
  base: process.env.VITE_BASE ?? "/",
  server: {
    host: "::",
    port: 8080,
  },
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  build: {
    outDir: "dist",
    assetsDir: "assets",
    rollupOptions: {
      output: {
        // Ensure proper file extensions for better MIME type detection
        entryFileNames: "assets/[name].[hash].js",
        chunkFileNames: "assets/[name].[hash].js",
        assetFileNames: "assets/[name].[hash].[ext]",
      },
    },
  },
}));
