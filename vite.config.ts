import { defineConfig } from 'vite';
import RubyPlugin from 'vite-plugin-ruby';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    RubyPlugin(),
    tailwindcss(),
    vue(),
  ],
  resolve: {
    alias: {
      components: new URL('./app/frontend/components', import.meta.url).pathname,
      api: new URL('./app/frontend/api', import.meta.url).pathname
    }
  }
})
