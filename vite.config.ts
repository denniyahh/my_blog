import { defineConfig } from 'vite';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const projectRoot = fileURLToPath(new URL('.', import.meta.url));

export default defineConfig({
  root: '.',
  server: {
    host: '0.0.0.0',
    port: 5173,
    strictPort: true,
  },
  build: {
    outDir: 'assets/dist',
    emptyOutDir: true,
    assetsDir: '',
    rollupOptions: {
      input: {
        main: path.resolve(projectRoot, 'assets/js/main.ts'),
      },
      output: {
        entryFileNames: 'js/[name].js',
        chunkFileNames: 'js/[name]-[hash].js',
        assetFileNames: ({ name }) => {
          if (!name) return 'assets/[name]-[hash][extname]';
          if (name.endsWith('.css')) {
            return 'css/[name][extname]';
          }
          return 'assets/[name][extname]';
        },
      },
    },
  },
  css: {
    devSourcemap: true,
    preprocessorOptions: {
      scss: {
        includePaths: [path.resolve(projectRoot, '_sass')],
        silenceDeprecations: ['import'],
      },
    },
  },
});
