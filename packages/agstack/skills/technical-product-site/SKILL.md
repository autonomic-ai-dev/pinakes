---
name: technical-product-site
description: "Design and build high-conviction, developer-targeted product websites and technical documentation (inspired by Caveman.so, Orca.dev, Memorable.sh, Autonomic AI). Covers evidence-grounded copy (zero unverified claims), obsidian tactile bento grids, interactive proof inspectors, caveman-style docs, animated scroll-tracking changelogs, and rock-solid responsive navigation."
---

# Technical Product Site: High-Conviction Developer Web Design

Engineers do not buy from marketing copy; they buy from evidence, ergonomics, and verifiable claims. A technical product website succeeds when every assertion is backed by the codebase, every code snippet works on copy-paste, and the interface exhibits the precise craft of the tools it sells.

This skill is the blueprint for creating developer-focused product websites and documentation in the style of **Caveman.so**, **Orca.dev**, **Memorable.sh**, **Tesser.sh**, and **Autonomic AI**.

---

## 1. Grounded Evidence Doctrine ("Show, Don't Tell")

Every claim on a developer landing page must be grounded in verified repository facts:

1. **Verify Before Writing:** Inspect the product repository (`git`, Cargo/package manifests, CLI source) before authoring copy.
2. **Exact Technical Terminology:** Reference exact file paths (`.verify/verify.toml`, `.verify/receipt.json`), CLI commands (`tekmor verify -- <cmd>`), exit codes (`0`, `1`), and hash formats (git tree SHA).
3. **No Phantom Capabilities:** Features in development belong under an explicit **"Honest Boundaries"** section (`references/trust-and-evidence.md`). Never present roadmap ideas as current features.
4. **Quantifiable Invariants:** Highlight numbers developers can check: execution duration (`0.38s`), model token cost (`0 model tokens`), and runtime dependencies (`0 external dependencies`).

---

## 2. Visual System: The Obsidian Aesthetic

High-conviction developer sites share a cohesive dark architectural palette:

- **Background Canvas:** `#070709` (Deep Obsidian); Elevated Surfaces: `#090a0d` (Bento Cards), `#0c0d10` (Code & Terminals).
- **Hairline Borders:** `rgba(255, 255, 255, 0.08)` to `rgba(255, 255, 255, 0.12)`.
- **Telemetry Accents:** Emerald (`#5fd39a`), Cyan (`#00f2fe`), Amber (`#f59e0b`), Crimson (`#ef4444`).
- **Typography:** Geometric sans-serif (*Geist Sans*) with tight negative letter tracking (`tracking-[-0.035em]`); monospace (*Geist Mono*) for commands, hashes, and schemas.
- **Tactile Bento Cards:** `18px` radius, subtle top-edge directional glow (`yc-card-glow`), and hairline dividers (`gap-[1px] bg-white/[0.08]`).
- **Ambient Lighting:** Top radial glow (`ellipse at center rgba(95,211,154,0.12) blur-3xl`) and pulsing green live beacons.

Details: [`references/visual-design-system.md`](./references/visual-design-system.md).

---

## 3. Key Interactive Components

### A. Interactive Hero Evidence Inspector
Replace static screenshots with an interactive state simulator:
- **State Selectors:** 2–3 realistic states (`Valid Receipt`, `Stale Pass`, `Command Refused`).
- **Hook Verdict Badge:** Live interception feedback (`PERMITTED`, `BLOCKED`, `REFUSED`).
- **Raw Evidence Viewer:** Live JSON receipt or terminal execution stream.
- **Architectural Rationale:** Concise explanation of the process guarantee.

### B. Unified Code Snippets (The "Four Steps" Style)
- Full-width dark surface (`#050608`) with 1px hairline border.
- Leading green monospace prompt (`$`).
- Click-to-copy across the entire container with inline `"Copied"` badge feedback.

Details: [`references/interactive-widgets.md`](./references/interactive-widgets.md).

---

## 4. Documentation & Animated Changelog

### A. Caveman-Style Documentation (`docs.caveman.so`)
- **Host Compatibility Matrix:** Tabulated host environments, active gate support, and implementation notes.
- **Command Reference:** Structured table of CLI flags, types, defaults, and usage recipes.
- **Architecture Diagrams:** Dark-themed Mermaid flowcharts showing execution cycles.

### B. Animated Scroll-Tracking Changelog
- **Vertical Timeline Rail:** 2px subtle rail with dynamic active progress beam (`from-[#5fd39a] to-emerald-400`).
- **Traveling Glowing Dot:** Scroll-following indicator dot tracking viewport progress.
- **Active Node Highlight:** Anchor rings illuminate as entries enter the viewport focus zone.
- **Categorized Change Tags:** `Added`, `Changed`, `Fixed`, `Security`, `Migration`.
- **Infinite Scroll:** `IntersectionObserver` sentinel loading historical releases seamlessly.

Details: [`references/caveman-docs-changelog.md`](./references/caveman-docs-changelog.md).

---

## 5. Responsive Architecture Standards

A developer site must hold across desktop, tablet, and mobile without squishing or broken overflowing elements:

1. **Desktop Nav Breakpoint:** Display full desktop navigation only at `lg:` (1024px+) or `xl:` (1280px+). Never crowd 7+ links on tablet viewports.
2. **Mobile & Tablet Drawer (`< lg`):** Provide a tactile hamburger button (`Menu` / `X`) opening a full slide-down sheet categorized by Products, Navigation, Resources, and Action buttons. Auto-close on route change.
3. **Mobile Docs Accordion:** On screens `< 768px`, replace desktop sidebars with a collapsible `Section: [Current Page] ▾` selector.
4. **Viewport Overflow Guard:** Apply `overflow-x-auto` to all `<pre>` blocks, terminal bodies, and tables. Wrap hero buttons cleanly (`flex-col sm:flex-row`).

Details: [`references/responsive-navigation.md`](./references/responsive-navigation.md).

---

## 6. Implementation Checklist

1. **Extract Truth:** Interrogate product CLI flags, manifests, and test suites for real invariants.
2. **Scaffold Theme:** Configure Obsidian palette tokens, Geist typography, and hairline bento cards.
3. **Build Hero & Inspector:** Implement headline tracking, live copy bar, and state-switching Proof Inspector.
4. **Author Caveman Docs & Changelog:** Create host matrix tables, Mermaid DAGs, and the animated timeline rail.
5. **Audit Responsiveness:** Verify 375px (mobile), 834px (tablet), and 1440px (desktop). Ensure mobile drawer toggles cleanly.
6. **Verify:** Run type checks (`bun run check`) and production build with zero warnings.
