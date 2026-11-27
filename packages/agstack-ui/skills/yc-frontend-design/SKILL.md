---
name: yc-frontend-design
description: "Architect and build high-end, animation-rich SaaS product websites with the aesthetic and quality of top YC startups (Resend, Vercel, Linear). Use when designing frontend landing pages, interactive product demos, tactile dark-mode interfaces, or documentation hubs."
---

# YC Frontend Design — The Tactile SaaS Playbook

High-end developer SaaS websites succeed because their interfaces are **tactile, interactive demonstrations of the product's core technical value**, not passive marketing brochures.

This skill codifies the complete engineering and design thinking process used to build premier developer tool frontends (like Resend, Vercel, Linear, and Anode).

---

## 1. Core Principles

### Principle 1: The Product Is The Hero (Tactile Proof)
* **Never use generic stock illustrations or abstract corporate blobs.**
* The centerpiece of the hero section must be an **interactive simulation of the product in action**:
  - For CLIs / DevOps tools: An interactive terminal with tab switching (`inspect`, `dev`, `lockfile`), syntax typing, and copyable commands.
  - For APIs: An interactive code playground with live payload previews.
  - For data platforms: Live query benches with real-time visual results.

### Principle 2: Obsidian Dark Surfaces & Radial Depth
* Use a 3-tier surface elevation system:
  - Base canvas: `#08090b` with a subtle 32px grid mesh (`linear-gradient` with 3% white opacity).
  - Resting panels: `#0c0e14` with a 1px border (`border-white/[0.08]`).
  - Elevated hover states: `#11141d` with subtle cyan/purple edge glows.
* Atmospheric depth: Place oversized, heavily blurred radial gradient blooms behind the hero headline (`bg-gradient-to-tr from-cyan-500/20 via-purple-600/15 blur-[120px]`).

### Principle 3: Authentic Technical Monospace Accents
* Pair a clean, tight sans-serif display font (Geist, Inter Display with `tracking-tight`) with authentic monospace code styling (`ui-monospace`, `Geist Mono`).
* Use monospace for status chips, execution times (`18ms`), port bindings (`127.0.0.1:54329`), and command snippets.

### Principle 4: Frictionless Micro-Interactions
* **Spring physics over linear CSS**: Use spring transitions (`stiffness: 400, damping: 30`) for snappy, tactile UI feel.
* **Cursor-following Spotlight cards**: Track relative `clientX` and `clientY` over Bento cards and render a dynamic `radial-gradient` beam on hover.
* **Instant copy with particle feedback**: Use subtle canvas confetti bursts and checkmark swaps on install command clicks.

---

## 2. The 7-Beat YC Information Architecture

Every premier SaaS product landing page follows a disciplined 7-beat narrative flow:

```
┌────────────────────────────────────────────────────────────────────────┐
│ Beat 1: The Hero & Live Artifact                                       │
│ • Clear value prop: "Deploy unmodified Go backends without Docker"     │
│ • Interactive centerpiece: Live terminal / code sandbox               │
│ • 1-click copy install command widget                                  │
├────────────────────────────────────────────────────────────────────────┤
│ Beat 2: The Interactive Engine Pipeline                                │
│ • Interactive step-by-step diagram showing internal architecture       │
│ • Clickable/hoverable stages with real code output                      │
├────────────────────────────────────────────────────────────────────────┤
│ Beat 3: The Architecture Drift (Before vs After)                       │
│ • Split comparison: The fragile status quo vs the clean new engine     │
│ • Concrete code diffs highlighting eliminated boilerplate              │
├────────────────────────────────────────────────────────────────────────┤
│ Beat 4: The 4 Pillars Bento Grid                                       │
│ • 4-6 asymmetric cards with cursor-following spotlight shaders         │
│ • Micro-diagrams and live terminal snippets inside each card           │
├────────────────────────────────────────────────────────────────────────┤
│ Beat 5: Empirical Benchmarks & Methodology                             │
│ • Head-to-head metrics (Cold starts, Memory footprint, Sweep time)     │
│ • Concrete measurement explanations (kernel syscalls, PSS/RSS)         │
├────────────────────────────────────────────────────────────────────────┤
│ Beat 6: The 60-Second Quickstart Walkthrough                           │
│ • Step 01, Step 02, Step 03 cards with copyable execution snippets    │
├────────────────────────────────────────────────────────────────────────┤
│ Beat 7: Technical Journal (`/blog`) & Comprehensive Docs (`/docs`)     │
│ • Searchable documentation tree with zero placeholder content           │
│ • In-depth architectural essays establishing engineering credibility   │
└────────────────────────────────────────────────────────────────────────┘
```

---

## 3. Engineering Guidelines & Edge-Case Defenses

### A. The "Frozen Scroll" Defense
* **Never set `h-full` on `<html>` or `<body>`** when implementing custom smooth scroll (Lenis) or sticky elements. Doing so locks `scrollHeight` to `100vh` on WebKit/Chromium.
* **Never set `overflow-x: hidden` on root `html, body`**: WebKit promotes `overflow-y` to `auto` or blocks document-level wheel bubbling. Apply overflow clipping to individual sections instead.
* **Always attach a `ResizeObserver` to Lenis**: Dynamic DOM updates (such as clicking documentation tabs or expanding code blocks) require an immediate `lenis.resize()` call.

### B. Offline & Sandbox-Safe Next.js Builds
* Do not rely on remote `next/font/google` fetches during build time. Use system font fallbacks with CSS variables:
  ```css
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Inter", sans-serif;
  ```
* For Next.js 15/16 under Bun or sandboxed environments, configure `next build --webpack` if Turbopack child-process IPC encounters local socket restrictions.

### C. Authentic Social Proof Over Fake Badges
* Never hardcode fake vanity numbers (e.g. `1.4k stars`). Either query live APIs client-side or provide a clean, unadorned repository link with standard SVG iconography.

---

## 4. Component Implementation Patterns

### 1. Cursor Spotlight Card (React + Tailwind)
```tsx
function SpotlightCard({ children }: { children: React.ReactNode }) {
  const cardRef = useRef<HTMLDivElement>(null);
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 });
  const [isHovered, setIsHovered] = useState(false);

  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    if (!cardRef.current) return;
    const rect = cardRef.current.getBoundingClientRect();
    setMousePos({ x: e.clientX - rect.left, y: e.clientY - rect.top });
  };

  return (
    <div
      ref={cardRef}
      onMouseMove={handleMouseMove}
      onMouseEnter={() => setIsHovered(true)}
      onMouseLeave={() => setIsHovered(false)}
      className="relative rounded-2xl border border-white/[0.08] bg-[#0c0e14] p-6 overflow-hidden transition-all hover:border-white/[0.18]"
    >
      <div
        className="pointer-events-none absolute -inset-px rounded-2xl transition-opacity duration-300"
        style={{
          opacity: isHovered ? 1 : 0,
          background: `radial-gradient(600px circle at ${mousePos.x}px ${mousePos.y}px, rgba(0, 173, 216, 0.12), transparent 40%)`,
        }}
      />
      <div className="relative z-10">{children}</div>
    </div>
  );
}
```

### 2. Auto-Resizing Momentum Smooth Scroll
```tsx
"use client";

import { useEffect } from "react";
import { usePathname } from "next/navigation";
import Lenis from "lenis";

export function SmoothScroll({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  useEffect(() => {
    if (typeof window === "undefined" || "ontouchstart" in window || navigator.maxTouchPoints > 0) return;

    const lenis = new Lenis({
      duration: 0.9,
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      orientation: "vertical",
      smoothWheel: true,
      syncTouch: false,
    });

    let frameId: number;
    const raf = (time: number) => {
      lenis.raf(time);
      frameId = requestAnimationFrame(raf);
    };
    frameId = requestAnimationFrame(raf);

    const observer = new ResizeObserver(() => lenis.resize());
    if (document.body) observer.observe(document.body);
    lenis.resize();

    return () => {
      cancelAnimationFrame(frameId);
      observer.disconnect();
      lenis.destroy();
    };
  }, [pathname]);

  return <>{children}</>;
}
```
