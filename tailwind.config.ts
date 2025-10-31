import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './_includes/**/*.html',
    './_layouts/**/*.html',
    './_posts/**/*.{md,html}',
    './assets/js/**/*.{js,ts}',
    './docs/**/*.md',
    './index.md',
    './about.md',
    './longform.md',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};

export default config;
