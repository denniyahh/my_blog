# Theme Rebuild Tech Spec

## 1. Goals & Constraints
- **Primary aim**: replace the stock Minima aesthetic with a bespoke, modern interface tailored for personal storytelling and long-form writing.
- **Secondary aims**: improved readability on mobile, easier navigation across longform and blog content, accessible color contrast, lightweight page loads (<200 KB critical).
- **Non-goals**: redesigning content structure or switching off Jekyll; focus strictly on presentation.
- **Constraints**: must remain compatible with GitHub Pages’ build pipeline, avoid heavy JavaScript frameworks, prioritize maintainability for a solo developer.

## 2. Audience & Core Journeys
- **Personas**: casual visitors discovering via social links, returning readers following longform essays, tech peers browsing updates.
- **Key flows**:
  - Landing → quick scan of latest posts → drill into article.
  - About → social/contact links.
  - Longform index → pick highlighted essay → read comfortably on tablet/phone.

## 3. Visual Identity
- **Mood**: calm, editorial, minimalist with typographic emphasis.
- **Palettes**: TODO – define base, accent, semantic colors; capture hex values and contrast targets.
- **Typography**: TODO – choose heading/body font pairings (serif for body?); note font sources (Google Fonts or self-hosted).
- **Spacing scale**: TODO – create rem-based scale (e.g. 0.5 → 4rem) for layout rhythm.
- **Iconography/imagery**: TODO – decide on simple line icons vs. none, hero imagery guidelines.

## 4. Layout System
- **Breakpoints**: TODO – specify mobile-first breakpoints (e.g. 0–640, 641–1024, 1025+).
- **Grid**: TODO – define column grid, container widths, gutters.
- **Core layouts**:
  - Landing page with hero, featured post, post list modules.
  - Post template with sticky table of contents and readable column.
  - Longform index with category filters.
- **Components inventory**:
  - Navigation (desktop/mobile)
  - Footer with social links + newsletter stub
  - Post cards, featured hero, tag badges
  - Callouts, code blocks, footnotes

## 5. Accessibility & Performance
- Target WCAG AA contrast ratios.
- Ensure focus states on all interactive elements.
- Provide prefers-reduced-motion support.
- Keep cumulative layout shift minimal; preload fonts carefully.
- TODO – set performance budgets (lighthouse targets, critical CSS approach).

## 6. Implementation Plan
- **Tooling**:
  - Continue Jekyll build with `theme: nil` and local assets.
  - Add SCSS pipeline (`assets/css/theme.scss`) compiled via Jekyll’s Sass.
  - Optional: Tailwind or custom utility layer (decide in Section 3).
  - HTML/CSS linting via `markdownlint`, `stylelint`, html-proofer.
  - Neovim setup with Treesitter, LSP (html, css-ls, tailwindcss if used), Codex integration.
- **Milestones**:
  1. Finalize design tokens (colors, type, spacing) + update spec.
  2. Rebuild layout structure (navigation, footer, page wrappers).
  3. Implement components (cards, callouts, longform index).
  4. Polish interactions (hover states, transitions, dark mode?).
  5. QA pass (accessibility, responsive checks, html-proofer).
- **Risks & mitigations**:
  - Scope creep → keep backlog in spec, ship incrementally.
  - Cross-browser issues → test in Chrome/Safari/Firefox; note issues in spec.
  - Performance regressions → run `bundle exec jekyll build` + lighthouse snapshots.

## 7. Design Assets & References
- **Design file**: TODO – link to Figma/Penpot board (e.g. `https://www.figma.com/file/...`).
- **Inspiration**: TODO – list sites or references influencing the aesthetic.
- **Changelog**:
  - YYYY-MM-DD – initialized spec.

## 8. Open Questions
- Should dark mode be supported in v1?
- Will Tailwind accelerate iteration or add overhead?
- Do we need a logo/wordmark refresh alongside UI?

