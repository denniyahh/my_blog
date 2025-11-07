---

description: "Task list template for feature implementation"
---

# Tasks: [FEATURE NAME]

**Input**: Design documents from `/specs/[###-feature-name]/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Always include the build verification trio from Principle IV (`bundle exec jekyll build --config _config.yml,_config.ci.yml`, `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`, `npx markdownlint-cli2 "**/*.md"`). Story-specific tests are optional unless the feature spec demands them.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Constitution Hooks

- **Principle I – Markdown canon**: Add tasks that specify exact Markdown files (`index.md`, `about.md`, `_posts/YYYY-MM-DD-slug.md`, `longform.md`) and their front matter updates; never touch `_site/`.
- **Principle II – Dual-runtime parity**: Include tasks for `bundle install`, `pnpm install`, `pnpm dev`, `pnpm run build`, and keeping `_config.yml` / `_config.ci.yml` in sync when needed.
- **Principle III – Mobile-first single-hand experience**: Capture tasks for updating thumb-zone grids in `docs/theme-spec.md`, enforcing ≥48 px targets, taking one-hand usability videos, and collecting Lighthouse Mobile metrics (LCP ≤2 s, payload ≤150 KB).
- **Principle IV – CI-grade verification**: Reserve tasks for the command trio listed above plus attaching screenshots/logs to PRs.
- **Principle V – Living documentation & plan discipline**: Add explicit tasks for refreshing `docs/work-plan.md`, `docs/theme-spec.md`, `docs/dev-environment-inventory.md`, and linking evidence in PRs.
- **Principle VI – AI-agent-first workflow**: Define tasks for scripting agent-friendly commands, provisioning staging previews, collecting logs/screenshots automatically, and reporting status via chat so work can be supervised from a phone.

## Path Conventions

- Markdown pages at the repository root (`index.md`, `about.md`, `longform.md`).
- Blog posts live in `_posts/YYYY-MM-DD-slug.md` with YAML front matter.
- Theme overrides live in `_layouts/`, `_includes/`, `_sass/`.
- Assets and TypeScript live under `assets/css/` and `assets/js/`; generated bundles go to `assets/dist/` (gitignored).
- Tooling + automation touch `_config.yml`, `_config.ci.yml`, `.github/workflows/`, and `bin/`.
- Documentation and automation inputs sit in `docs/` (notably `docs/work-plan.md`, `docs/theme-spec.md`, `docs/dev-environment-inventory.md`, `.specify/`).
- `_site/` is disposable build output—never target it in tasks.

<!-- 
  ============================================================================
  IMPORTANT: The tasks below are SAMPLE TASKS for illustration purposes only.
  
  The /speckit.tasks command MUST replace these with actual tasks based on:
  - User stories from spec.md (with their priorities P1, P2, P3...)
  - Feature requirements from plan.md
  - Entities from data-model.md
  - Endpoints from contracts/
  
  Tasks MUST be organized by user story so each story can be:
  - Implemented independently
  - Tested independently
  - Delivered as an MVP increment
  
  DO NOT keep these sample tasks in the generated tasks.md file.
  ============================================================================
-->

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare tooling, documentation, and automation guardrails.

- [ ] T001 Run `bundle install` and capture Ruby/Bundler versions in `docs/dev-environment-inventory.md`.
- [ ] T002 Run `pnpm install` (or `corepack pnpm install`) and note any script changes.
- [ ] T003 Ensure `/specs/.../plan.md` Constitution Check answers (Principles I–VI) are filled before coding.
- [ ] T004 Update `docs/work-plan.md` with scope, branch, and next steps.
- [ ] T005 Verify `.gitignore` keeps `_site/` and `assets/dist/` clean; remove stray artifacts.
- [ ] T006 Document/update `.specify/scripts/agent-run.*` (or equivalent) so AI agents can execute plan → tasks → tests → staging from a smartphone-only chat session, including default status messages.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Align theme scaffolding, configs, and shared components before story work.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

Examples of foundational tasks (adjust based on your project):

- [ ] T007 Sync `_config.yml` and `_config.ci.yml` changes (Principle II).
- [ ] T008 Refresh design tokens/layout decisions in `docs/theme-spec.md` with thumb-zone grids, 360–428 px breakpoints, and single-column flows (Principle III).
- [ ] T009 Implement shared wrappers in `_layouts/default.html` and `_includes/head.html`, biasing navigation/actions toward bottom-of-screen reach.
- [ ] T010 Build/update `assets/css/theme.scss` (or Tailwind config) with mobile-first typography, spacing, and animation budgets.
- [ ] T011 Wire asset entry points in `assets/js/main.ts` (or equivalent) and ensure Vite build succeeds.
- [ ] T012 Add accessibility/performance instrumentation (focus outlines, prefers-reduced-motion classes, mobile Lighthouse scripts, preload hints) and expose them via `.specify/scripts` so agents can run them unattended.

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - [Title] (Priority: P1) 🎯 MVP

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 1 (MANDATORY per Principle IV) ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T013 [US1] Run `bundle exec jekyll build --config _config.yml,_config.ci.yml` and confirm only intended pages changed.
- [ ] T014 [US1] Run `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`, scoping warnings to the touched pages.
- [ ] T015 [US1] Run `npx markdownlint-cli2 "**/*.md"` (or limited globs) and attach the results + Lighthouse Mobile reports + one-hand demo video/GIF to the PR.

### Implementation for User Story 1

- [ ] T016 [US1] Update the relevant Markdown file (e.g., `_posts/YYYY-MM-DD-slug.md`, `index.md`, `about.md`) with required front matter.
- [ ] T017 [P] [US1] Adjust theme markup in `_layouts/` or `_includes/` (cite exact file) with semantic HTML, mobile thumb zones, and accessibility annotations.
- [ ] T018 [P] [US1] Implement supporting styles in `assets/css/theme.scss` or `_sass/_components.scss`.
- [ ] T019 [US1] Wire any interactive behavior in `assets/js/[feature].ts` (optional if story is static).
- [ ] T020 [US1] Update `docs/theme-spec.md`, capture screenshots/video, and trigger the agent staging script/CI job so a preview URL + logs are posted for smartphone review.

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - [Title] (Priority: P2)

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 2 (MANDATORY per Principle IV) ⚠️

- [ ] T021 [US2] Re-run `bundle exec jekyll build --config _config.yml,_config.ci.yml` after merging US2 work with US1.
- [ ] T022 [US2] Run `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https` focusing on the new navigation/flow.
- [ ] T023 [US2] Validate `npx markdownlint-cli2 "**/*.md"` (or targeted globs) plus Lighthouse Mobile runs + one-hand usability screenshots to satisfy Principle III.

### Implementation for User Story 2

- [ ] T024 [US2] Update navigation or listing partials in `_includes/` (e.g., `_includes/nav.html`, `_includes/post-card.html`).
- [ ] T025 [P] [US2] Extend `_sass/_layout.scss` or `assets/css/theme.scss` with layout changes and document them in `docs/theme-spec.md`.
- [ ] T026 [P] [US2] Wire supporting JS (if needed) in `assets/js/[feature].ts` and ensure `pnpm dev` reflects it.
- [ ] T027 [US2] Adjust content sources (`index.md`, `_posts/...`) to expose the new story slice.
- [ ] T028 [US2] Update `docs/work-plan.md`, attach screenshots/GIFs, and ensure the staging deploy shares a refreshed preview link/log bundle via the agent channel.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - [Title] (Priority: P3)

**Goal**: [Brief description of what this story delivers]

**Independent Test**: [How to verify this story works on its own]

### Tests for User Story 3 (MANDATORY per Principle IV) ⚠️

- [ ] T029 [US3] Run `bundle exec jekyll build --config _config.yml,_config.ci.yml` after rebasing on prior stories.
- [ ] T030 [US3] Run `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https` for the new flow.
- [ ] T031 [US3] Run `npx markdownlint-cli2 "**/*.md"` and attach accessibility/performance notes (contrast checks, payload measurements, Lighthouse Mobile run, single-hand video).

### Implementation for User Story 3

- [ ] T032 [US3] Create or update Markdown content (e.g., `_posts/...`, `longform.md`) plus alt text for assets in `assets/`.
- [ ] T033 [P] [US3] Extend `_sass/_components.scss` or `assets/css/theme.scss` for the new UI surface.
- [ ] T034 [P] [US3] Adjust `_layouts/` / `_includes/` to route users into the new journey while keeping critical actions within thumb reach.
- [ ] T035 [US3] Capture screenshots or recordings, update `docs/theme-spec.md`, and have the agent redeploy staging + post the link/log recap for approval.

**Checkpoint**: All user stories should now be independently functional

---

[Add more user story phases as needed, following the same pattern]

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] TXXX [P] Refresh `docs/work-plan.md`, `docs/theme-spec.md`, `docs/dev-environment-inventory.md`, and `.specify` artifacts.
- [ ] TXXX Clean up `_layouts/`, `_includes/`, `_sass/`, and `assets/` to remove dead code while preserving Principle I.
- [ ] TXXX Run the verification trio again (`bundle exec jekyll build --config _config.yml,_config.ci.yml`, `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`, `npx markdownlint-cli2 "**/*.md"`).
- [ ] TXXX Capture accessibility/performance evidence (WCAG contrast report, Lighthouse Mobile payload sizes, single-hand walkthrough video).
- [ ] TXXX Script/verify agent-run staging + production deploy commands (or GitHub Actions workflows) so a phone-based reviewer can trigger them with a single instruction.
- [ ] TXXX [P] Screenshot or record UI changes and attach to PR.
- [ ] TXXX Ensure `_site/` and `assets/dist/` remain untracked and clean.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - May integrate with US1 but should be independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - May integrate with US1/US2 but should be independently testable

### Within Each User Story

- Verification tasks (build + htmlproofer + markdownlint) MUST fail before implementation so regressions are visible.
- Update Markdown/front matter first, then `_layouts/` + `_includes/`, then `_sass/` / `assets/css/`, and finally any `assets/js/`.
- Record accessibility/performance evidence, staging links, and documentation updates before marking the story done.
- Ensure `.specify/scripts/agent-run` (or CI) posts smartphone-friendly status/logs + preview URLs before calling the story complete.
- Keep each story independently demoable before moving to the next priority.

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel.
- All Foundational tasks marked [P] can run in parallel (within Phase 2).
- Once Foundational completes, user stories can run in parallel if they touch different Markdown pages or theme partials.
- Verification commands can be scripted to run concurrently after each story, but capture outputs separately.
- Markdown edits and `_sass`/`assets/css` updates can happen in parallel if they reference different files; coordinate when touching `_layouts/` or `_includes/`.
- Different user stories can be owned by different people so long as Principle V documentation stays in sync.

---

## Parallel Example: User Story 1

```bash
# Launch all verification commands for User Story 1:
bundle exec jekyll build --config _config.yml,_config.ci.yml
bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https
npx markdownlint-cli2 "**/*.md"

# Launch all content/theming edits for User Story 1 together:
Task: "Update _posts/YYYY-MM-DD-sample.md with new front matter"
Task: "Adjust assets/css/theme.scss + _includes/post-card.html"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
3. Stories complete and integrate independently

---

## Notes

- [P] tasks touch different files (e.g., `_posts/` vs `_sass/`) so they can run in parallel without merge pain.
- Always label tasks with their story (US1/US2/US3) and cite exact file paths plus command outputs/logs or preview links.
- Each story must be independently demoable; stop after every checkpoint to re-run the verification trio.
- Document decisions/screenshots in `docs/` before landing code; link them from the PR and the agent status message.
- Never modify `_site/` or commit generated assets; rerun builds instead.
- Keep commits small and reversible—one principle violation per commit at most, and justify it in the message.
- Staging/production deploys must remain agent-triggerable (scripts or CI dispatch) so you can supervise entirely from a phone.
