# Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link]
**Input**: Feature specification from `/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

[Extract from feature spec: primary requirement + technical approach from research]

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]
**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION]  
**Primary Dependencies**: [e.g., FastAPI, UIKit, LLVM or NEEDS CLARIFICATION]  
**Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]  
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION]  
**Target Platform**: [e.g., Linux server, iOS 15+, WASM or NEEDS CLARIFICATION]
**Project Type**: [single/web/mobile - determines source structure]  
**Performance Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION]  
**Constraints**: [domain-specific, e.g., <200ms p95, <100MB memory, offline-capable or NEEDS CLARIFICATION]  
**Scale/Scope**: [domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Principle I – Markdown canon**: List every Markdown file/post this plan touches, required front matter updates, and confirm `_site/` stays untouched.
- **Principle II – Dual-runtime parity**: Spell out the Bundler + pnpm commands that will run (`bundle exec jekyll serve`, `bundle exec jekyll build --config _config.yml,_config.ci.yml`, `pnpm dev`, `pnpm run build`, `bundle exec htmlproofer …`) and any config-sync work.
- **Principle III – Mobile-first single-hand experience**: Detail thumb-zone layout decisions, tap-target sizing (≥48 px), mobile-first typography/spacing tokens, and how you will capture Lighthouse Mobile or equivalent metrics (LCP ≤2 s, input delay ≤100 ms, payload ≤150 KB) plus one-handed usability evidence (screenshots/video).
- **Principle IV – CI-grade verification**: Commit to running `bundle exec jekyll build --config _config.yml,_config.ci.yml`, `bundle exec htmlproofer ./_site --assume-extension --check-html --disable-external --no-enforce-https`, and `npx markdownlint-cli2 "**/*.md"` before any review request.
- **Principle V – Living documentation & plan discipline**: Identify which docs (`docs/work-plan.md`, `docs/theme-spec.md`, `docs/dev-environment-inventory.md`) must be updated as part of this feature and who owns the updates.
- **Principle VI – AI-agent-first workflow**: Explain how agents will execute this plan remotely (scripts, CI jobs, staging deploy steps) and how outputs (logs, preview URLs, screenshots) stay reviewable from a smartphone.

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
```text
repo/
├── index.md               # landing content (Principle I)
├── about.md               # profile page
├── longform.md            # curated essays
├── _posts/                # dated blog posts in YYYY-MM-DD-slug.md format
├── assets/
│   ├── css/               # Tailwind/Vite styles compiled via pnpm
│   ├── js/                # TypeScript entry points
│   └── dist/              # generated bundles (gitignored, never edited)
├── _layouts/, _includes/, _sass/   # theme overrides for Jekyll
├── bin/                   # bundler binstubs + helper scripts
├── docs/
│   └── myblog/
│       ├── .specify/      # constitution, templates, automation prompts
│       │   └── scripts/   # agent-executable workflows (plan → tasks → deploy)
│       └── .codex/        # agent prompt set
├── .github/workflows/     # CI mirrors local verification commands
└── _site/                 # disposable build output
```

**Structure Decision**: Document which of the paths above (or additional ones you add) will change and how they respect Principle I (content placement) and Principle II (tooling parity).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
