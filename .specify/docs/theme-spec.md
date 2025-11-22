# Theme Rebuild Tech Spec

## 1. Goals & Constraints
- **Primary aim**: ship the `001-mobile-first-redesign` spec-mobile-first layouts, nicer visuals, and better readability without changing site structure.
- **Secondary aims**: minimize bounce on phones, keep long-form reading comfortable, ensure single-handed navigation, and document every change for agents.
- **Non-goals**: altering content IA, swapping out Jekyll/GitHub Pages, or inventing a new color palette (existing brand colors stay in place).
- **Constraints**: GitHub Pages-compatible dependencies only, avoid JS-heavy frameworks, target assets <=150 KB for hero/feature imagery, ship work incrementally (per spec's user stories).

## 2. Audience & Core Journeys
- **Personas**: first-time mobile visitors, returning blog readers, collaborators reviewing on desktop.
- **Key flows**:
  - Mobile landing -> scan hero + featured posts -> tap CTA/cards with one thumb.
  - Post page -> read long-form text -> access related links/drawer nav without losing scroll position.
  - Desktop reviewer -> resize window to verify progressive enhancement and desktop grid state.

## 3. Visual Identity
- **Mood**: calm, editorial, typographic focus with subtle accents.
- **Colors (palette unchanged, re-mapped to new roles)**:
  - Base background `#fdfdfd`
  - Surface background `#ffffff`
  - Primary text `#111111`
  - Accent / link `#2a7ae2`
  - Muted text `#828282`
  - Success `#2e8555`, Warning `#c27c1a`, Error `#c0392b` (borrowed from existing Minima partials)
  - Document in `_data/theme.json` + `_sass/_tokens.scss` so Markdown/layouts share definitions.
- **Typography**:
  - Headings: `"Fraunces", "Georgia", serif` with scale (h1 2.5rem/1.1, h2 2rem/1.15, h3 1.5rem/1.2).
  - Body: `"Inter", "Helvetica Neue", sans-serif` at 1rem (16px) with 1.5 line-height.
  - Code: `"JetBrains Mono", monospace` at 0.9375rem.
  - Load via Google Fonts (self-host later) and define fallbacks in `_sass/_typography.scss`.
- **Spacing scale (4pt system)**: `0, 0.25rem, 0.5rem, 0.75rem, 1rem, 1.5rem, 2rem, 3rem, 4rem` -> map to tokens `space-0`...`space-8`.
- **Iconography/imagery**: minimal line icons via existing SVGs; hero/featured imagery exported as WebP <=150 KB, fallback JPG referenced in front matter.

## 4. Layout System
- **Breakpoints (mobile-first)**:
  - Base: 0-599px (single column, 20px gutters)
  - Tablet: 600-1023px (`@media (min-width: 600px)`), introduce two-column grids and side-by-side hero text/media.
  - Desktop: >=1024px (`@media (min-width: 1024px)`), max-width 1100px centered + three-column card grid for archives.
- **Grid**:
  - Root container uses CSS clamp to keep padding 1rem-2.5rem depending on viewport.
  - Cards stack vertically on base breakpoint; switch to CSS Grid at tablet+ (`grid-template-columns: repeat(auto-fit, minmax(280px, 1fr))`).
- **Core layouts**:
  - Landing: hero (copy + CTA + supporting image), featured posts carousel (horizontal scroll on mobile), standard post list.
  - Post template: sticky header w/drawer, max body width 70ch, collapsible ToC under hero, media scaled to 100% width with optional captions.
  - About/longform: same tokens, add highlight callouts for key facts.
  - Landing page with hero, featured post, post list modules.
  - Post template with sticky table of contents and readable column.
  - Longform index with category filters.
- **Components inventory**:
  - Navigation (desktop/mobile)
  - Footer with social links + newsletter stub
  - Post cards, featured hero, tag badges
  - Callouts, code blocks, footnotes
- Landing: hero (copy + CTA + supporting image), featured posts carousel (horizontal scroll on mobile), standard post list.
- Post template: sticky header w/drawer, max body width 70ch, collapsible ToC under hero, media scaled to 100% width with optional captions.
- About/longform: same tokens, add highlight callouts for key facts.
- Persistent nav affordances: social icon stack anchored to the bottom-right corner (desktop aligns with nav gutter, mobile floats just above the bottom edge) and the hamburger trigger anchored bottom-left on palm breakpoints so both controls are reachable with one thumb.
- **Components inventory** (prioritized):
  - Sticky header + drawer nav (hamburger -> overlay) with 48px tap targets.
  - CTA button styles (primary/accent, full-width on mobile, inline on desktop).
  - Post card variations (featured vs. standard) with image aspect ratio helpers.
  - Alert/callout blocks for longform writing.
  - Footer with social links + contact CTA.

## 5. Accessibility & Performance
- Maintain WCAG AA contrast using the affirmed palette; run `npx @axe-core/cli` before sign-off if possible.
- Enforce focus rings and escape key handling on the mobile drawer.
- Support `prefers-reduced-motion` by disabling hero transitions.
- Performance budgets:
  - Lighthouse Mobile >=85 performance / >=95 accessibility (per spec success criteria).
  - FCP improvement >=20% vs. current production measurement.
  - Image assets <=150 KB, fonts preloaded with `rel="preload"` + swap strategy.

## 6. Implementation Plan
- **Tooling**:
  - Continue Bundler workflow; add `npx @lhci/cli collect --url http://127.0.0.1:4000` to verification commands.
  - Draft `.specify/scripts/bash/build-mobile-preview.sh` to wrap `bundle exec jekyll build`, htmlproofer, markdownlint, and Lighthouse capture, then echo artifact locations.
  - Add optional `bin/compress-images` helper (ImageMagick `mogrify` or `cwebp`) to keep hero assets under budget.
- **Milestones**:
  1. Document tokens + typography in this spec and wire them into `_sass/_tokens.scss`.
  2. Ship P1 hero/nav mobile layout + CTA improvements.
  3. Complete `_posts` responsive refinements + utility classes.
  4. Implement tablet/desktop enhancements + regression testing.
  5. Final QA run (build + htmlproofer + markdownlint + Lighthouse evidence) and attach assets/screenshots to PR.
- **Risks & mitigations**:
  - Font loading regressions -> use `font-display: swap` + preconnect to fonts.gstatic.com.
  - Drawer JS complexity -> keep it CSS-first (checkbox hack) or minimal vanilla JS, document fallback behavior.
  - Tooling drift -> document every CLI dependency in `docs/dev-environment-inventory.md`.

## 7. Design Assets & References
- **Design file**: Placeholder Figma board (`https://www.figma.com/file/TBD/mobile-first-redesign`) - update link once artifacts exist.
- **Inspiration**: [Stripe Press](https://press.stripe.com/), [smashingmagazine.com](https://www.smashingmagazine.com/) mobile layout, Apple Newsroom typography.
- **Changelog**:
  - 2025-11-06 - updated with mobile-first tokens, breakpoints, palette decision, tooling expectations.

## 8. Open Questions
- Should hero imagery include illustration overlays or stay photography-only? (impact on asset budget)
- Will we introduce dark mode immediately after mobile-first GA, or backlog it?
- Do we need a dedicated utility partial for Markdown authors (e.g., `.callout-info`) or rely on kramdown classes?
