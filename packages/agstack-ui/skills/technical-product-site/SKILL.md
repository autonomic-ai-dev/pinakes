---
name: technical-product-site
description: "Design and build high-conviction, developer-targeted product websites and docs. Covers evidence-grounded copy (zero unverified claims), obsidian tactile bento grids, continuous conduit & runner badge motion, bidirectional scroll reactivity, rolling animated numbers, spring pill tabs, single-rail changelogs, and solid responsive navigation."
version: 0.1.0
---

# Technical Product Site: High-Conviction Developer Web Design

Engineers do not buy from marketing copy; they buy from evidence, ergonomics, verifiable claims, and flawless visual performance. A technical product website succeeds when every assertion is backed by the codebase, every code snippet works on copy-paste, and the interface exhibits the precise craft of the tools it sells.

This skill is the master blueprint for creating developer-focused product websites and documentation, synthesizing architecture, motion, and interaction standards for high-conviction developer and platform engineering tools.

---

## 1. Grounded Evidence Doctrine ("Show, Don't Tell")

Every claim on a developer landing page must be grounded in verified repository facts:

1. **Verify Before Writing:** Inspect the product repository (`git`, Cargo/Go/package manifests, CLI source) before authoring copy.
2. **Exact Technical Terminology:** Reference exact file paths (`.verify/receipt.json`, `anode.lock.json`), CLI commands (`anode inspect`, `anode dev`), exit codes (`0`, `1`), and hash formats (SHA256, git tree SHA).
3. **No Phantom Capabilities:** Features in development belong under an explicit **"Honest Boundaries"** section ([trust-and-evidence.md](./references/trust-and-evidence.md)). Never present roadmap ideas as current features.
4. **Quantifiable Invariants:** Highlight numbers developers can check: execution duration (`12 ms`), memory usage (`14 MB`), and model token cost (`0 model tokens`).

---

## 2. Visual System: Obsidian & Telemetry Palette

High-conviction developer sites share a cohesive dark architectural palette with purposeful semantic accents:

- **Background Canvas:** `#000000` to `#070709` (Deep Obsidian); Elevated Surfaces: `#090a0d` (Bento Cards), `#0c0d10` (Code & Terminals).
- **Hairline Borders:** `rgba(255, 255, 255, 0.08)` to `rgba(255, 255, 255, 0.14)`.
- **Continuous Conduit Tokens:**
  - Core Laser Thread: `#ff7a4a` / `#ff6a3a`
  - High-Energy Glow Halo: `#ff531a` (`rgba(255, 83, 26, 0.85)`)
  - Razor Highlight Accent: `#ffd9c7`
- **Semantic Accents Only:**
  - Emerald (`#22c55e` / `#5fd39a`): Determinism proofs, active states, verification passes.
  - Amber / Yellow (`#f59e0b` / `#eab308`): Diagnostic warnings, fallback notices.
  - Crimson / Red (`#ef4444`): Failure traps, Docker port collisions, schema drift.
- **Typography:** Geometric sans-serif (*Geist Sans*) with tight negative letter tracking (`tracking-[-0.035em]`); monospace (*Geist Mono*) for commands, hashes, and schemas.
- **Tactile Bento Cards:** `18px` radius, subtle top-edge directional glow (`yc-card-glow`), and cursor-following spotlights.

Details: [`references/visual-design-system.md`](./references/visual-design-system.md).

---

## 3. Continuous Conduit & Runner Arrow Architecture

Replace artificial segmented section dividers with **an uninterrupted, glowing physical conduit** that guides the engineer down the page.

### A. The 3-Layer Optical Glow
1. **Wide Ambient Halo:** `16px` width, `blur-[8px]`, opacity `0.20`, `#ff531a`.
2. **Focused Mid Halo:** `6px` width, `blur-[3px]`, opacity `0.60`, `#ff531a`.
3. **Razor Laser Core:** `2.5px` width, gradient `from-[#ffd9c7] via-[#ff7a4a] to-[#ff531a]`, shadow `0 0 10px #ff531a`.

### B. The Main Arrow Runner
- **Prominent Arrow Head:** Downward-pointing chevron badge (`↓`) riding the leading tip of the line.
- **240px Ambient Radial Glow Aura:** `radial-gradient(circle, rgba(255, 83, 26, 0.42) 0%, transparent 70%)`.
- **Neon Bloom Box Shadow:** `box-shadow: 0 0 16px 5px rgba(255, 83, 26, 0.85), 0 0 32px 10px rgba(255, 83, 26, 0.4)`.

### C. Layout Margin Framing (Zero Character Clipping)
- Position the thread in the container's margin zone (`left-1.5 sm:left-2.5 lg:left-3 xl:-left-6 2xl:-left-10`).
- Ensure all text headings and bento cards retain ample left clearance so the line never cuts across copy.

Details: [`references/continuous-conduit-motion.md`](./references/continuous-conduit-motion.md).

---

## 4. Bidirectional Scroll Reactivity & Section Transitions

Developer audiences demand responsive, physical motion that behaves consistently in both directions:

- **Bidirectional Viewport Triggers:** Configure `viewport: { once: false, amount: 0.15 }`.
- **Scrolling Down:** Elements slide and fade into view (`y: 24 → 0`, custom cubic-bezier `[0.16, 1, 0.3, 1]`).
- **Scrolling Up:** Elements gracefully reverse back to initial state as they leave the viewport.
- **Re-entering:** Sections and empirical counters freshly re-animate on every subsequent pass.

---

## 5. SSR-First Animated Numbers & Empirical Counters

Never use static numbers for empirical claims, and never trigger full React component re-renders during number counting.

- **SSR & SEO First:** Pre-render the final formatted value (`98%`, `350x`, `850 MB`, `14 MB`, `4,200 ms`, `12 ms`) directly in the static server HTML for instant search engine indexing and zero Cumulative Layout Shift (CLS).
- **Direct DOM Updates (60/120 FPS):** Mutate `ref.current.textContent` during animation frames using `motion/react` `animate()`.
- **Bidirectional Reset:** Count up smoothly on scroll down into view; reset to 0 when scrolled away; re-animate on return.
- **Synchronized Bar Expansion:** Pair the count-up counter with an expanding Framer Motion progress bar (`width: 0% → 100%`).

Details: [`references/animated-numbers.md`](./references/animated-numbers.md).

---

## 6. Key Interactive Components

### A. Sliding Spring Pill Tabs (`layoutId`)
- Use Framer Motion's shared `layoutId` pill for install switchers (`brew tap` / `curl` / `source`) and interactive terminal modes (`01 inspect` / `02 dev` / `03 lockfile` / `04 deploy`).
- Spring physics: `stiffness: 450, damping: 32` for zero-latency, tactile gliding.

### B. Interactive Terminal & Vector Conduits
- Simulate real CLI execution passes with blinking prompts, syntax coloring, and copy buttons.
- Connect sequential execution stages using animated SVG vector conduits with traveling light beacons.

Details: [`references/interactive-widgets.md`](./references/interactive-widgets.md).

---

## 7. Documentation, FAQ Exclusivity & Single-Rail Changelog

### A. FAQ Section Placement (Homepage Exclusivity)
- Render `<FAQSection />` **strictly on the primary homepage** before the footer.
- Purge redundant FAQ sections from comparison subpages (`/vs/*`), deploy guides (`/deploy/*`), and framework guides (`/guides/*`).

### B. Single-Rail Changelog Timeline
- Center the vertical timeline rail (`left-[15px]`) and the active traveling progress dot on the exact same axis.
- Purge disconnected anchor rings styled with negative offsets (`-left-[27px]`) to eliminate floating dots.

Details: [`references/developer-docs-changelog.md`](./references/developer-docs-changelog.md).

---

## 8. Responsive Architecture Standards

A developer site must hold across desktop, tablet, and mobile without squishing or broken overflowing elements:

1. **Desktop Nav Breakpoint:** Display full desktop navigation only at `lg:` (1024px+) or `xl:` (1280px+). Never crowd 7+ links on tablet viewports.
2. **Mobile & Tablet Drawer (`< lg`):** Provide a tactile hamburger button (`Menu` / `X`) opening a full slide-down sheet categorized by Products, Navigation, Resources, and Action buttons. Auto-close on route change.
3. **Mobile Docs Accordion:** On screens `< 768px`, replace desktop sidebars with a collapsible `Section: [Current Page] ▾` selector.
4. **Viewport Overflow Guard:** Apply `overflow-x-auto` to all `<pre>` blocks, terminal bodies, and tables. Wrap hero buttons cleanly (`flex-col sm:flex-row`).

Details: [`references/responsive-navigation.md`](./references/responsive-navigation.md).

---

## 9. Static SSR, Metadata & SEO First Standards

- **Static Pre-rendering:** Generate all routes statically via Next.js SSG / Partial Prerendering with zero hydration mismatches.
- **Rich Structured Data:** Inject valid JSON-LD schemas for `Organization`, `SoftwareApplication`, and `FAQPage`.
- **Machine Readability:** Expose `/llms.txt` and `/llms-full.txt` alongside standard `/robots.txt` and `/sitemap.xml`.

---

## 10. Complete Implementation & Audit Checklist

1. **Extract Repository Truth:** Interrogate product CLI flags, manifests, and test suites for real invariants.
2. **Scaffold Obsidian Theme:** Configure canvas tokens, Geist typography, and hairline bento cards.
3. **Deploy Continuous Conduit:** Mount `<MainOrangeArrow />` with multi-tier glow strokes, 240px halo runner, and outer margin framing.
4. **Integrate Bidirectional Animations:** Apply `viewport: { once: false, amount: 0.15 }` and cubic bezier `[0.16, 1, 0.3, 1]` across sections.
5. **Implement Animated Numbers:** Wrap all empirical benchmarks in `<AnimatedNumber />` for bidirectional count-up and zero CLS.
6. **Integrate Spring Pill Tabs:** Use `layoutId` on installation selectors and terminal mode switchers.
7. **Audit FAQ Placement:** Ensure FAQ is rendered solely on homepage.
8. **Verify Single-Rail Changelog:** Confirm only one indicator dot travels the timeline rail.
9. **Responsive Audit:** Test 375px (mobile), 834px (tablet), and 1440px (desktop).
10. **Verify Production Build:** Run `bun run build` ensuring all static routes pass with zero errors.
