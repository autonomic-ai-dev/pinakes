---
description: agstack-ui — UI design, pixel fidelity, responsive, and UI testing policy (companion to agstack core)
alwaysApply: true
---

# agstack-ui: UI Engineering Policy & Process Standards

`agstack-ui` carries the interface half of the agstack process. Install it alongside `agstack`; the core policy in `agstack/AGENTS.md` (immutability, boundary discipline, `.verify/` contract, no-comments) applies unchanged here.

---

## 1. UI Design, Pixel Fidelity & UI Testing (`ui-design-stitch`, `pixel-perfect-ui`, `responsive-ui`, `ui-testing`, `technical-product-site`)
- **Design first:** UI work starts from a Stitch design (`ui-design-stitch`). Export the screenshot and HTML as the reference before writing markup.
- **Pixel-perfect by measurement:** Implementation matches the reference through a captured diff within a recorded threshold (`pixel-perfect-ui`). Tokens only, no literal values.
- **Responsive by measurement:** Phone, tablet, and desktop captures pass the measured rules: no horizontal scroll, 16 px phone gutter, 44 px touch targets (`responsive-ui`).
- **Layered UI tests:** functional flows, visual regression, responsive, and accessibility, each run through the `.verify/` allowlist (`ui-testing`).
- **High-conviction developer sites:** Developer product pages ground every claim in verified repository facts (zero unverified marketing claims), employ an obsidian tactile bento grid with hairline borders, feature interactive evidence simulators (Hero Proof Inspector), minimalist evidence documentation, animated scroll-tracking changelogs, and rock-solid collapsible mobile/tablet drawer navigation (`technical-product-site`).

---

## 2. Playbooks
- `playbooks/ui-delivery.md` — a user interface built from a design.
- `playbooks/design-to-code.md` — converting a Stitch screen or HTML design into code, scored against the design until it matches (98% by default).
