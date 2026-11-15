# Visual Design System: The Obsidian & Telemetry Standard

High-conviction developer sites (Caveman.so, Orca.dev, Memorable.sh) share a tactile, architectural visual language that sets them apart from conventional SaaS templates.

---

## 1. Color Palette Tokens

```css
:root {
  /* Canvas & Elevated Dark Surfaces */
  --color-canvas-dark: #070709;
  --color-surface-card: #090a0d;
  --color-surface-elevated: #0c0d10;
  --color-surface-hover: #121318;
  --color-surface-code: #050608;

  /* Hairline Borders */
  --color-border-subtle: rgba(255, 255, 255, 0.08);
  --color-border-hover: rgba(255, 255, 255, 0.18);
  --color-border-strong: rgba(255, 255, 255, 0.28);

  /* Roma Continuous Thread & Motion Tokens */
  --color-roma-core: #ff7a4a;        /* Vibrant core laser thread */
  --color-roma-red: #ff531a;         /* High-energy halo & glow */
  --color-roma-highlight: #ffd9c7;   /* Razor highlight accent */
  --color-roma-cold: #7a3826;        /* Subdued background guide rail */
  --color-roma-glow: rgba(255, 83, 26, 0.45);

  /* Telemetry Accents */
  --color-telemetry-emerald: #5fd39a; /* #22c55e */
  --color-telemetry-cyan: #00f2fe;
  --color-telemetry-amber: #f59e0b;
  --color-telemetry-red: #ef4444;
  --color-telemetry-blue: #3b82f6;

  /* Typography */
  --color-text-primary: #ededed;
  --color-text-secondary: #a1a1aa;
  --color-text-muted: #71717a;
}
```

---

## 2. Typography Rules

1. **Headlines:** Use a clean, modern sans-serif (*Geist Sans*, *Inter*) with negative tracking:
   ```css
   h1, h2, h3 {
     letter-spacing: -0.035em;
     line-height: 1.1;
     font-weight: 600;
   }
   ```
2. **Body Prose:** Constrain width to 60–75 characters per line (`max-w-xl` to `max-w-2xl`) with relaxed line-height (`leading-relaxed`).
3. **Monospace Precision:** All commands, file paths, hashes, versions, and table headers must use monospace font (*Geist Mono*, *JetBrains Mono*) with `font-mono`.

---

## 3. Bento Grid & Tactile Card Anatomy

### Bento Card Component
```css
.yc-card {
  position: relative;
  background-color: var(--color-surface-card);
  border: 1px solid var(--color-border-subtle);
  border-radius: 18px;
  box-shadow: 
    inset 0 1px 1px 0 rgba(255, 255, 255, 0.09),
    0 14px 30px -10px rgba(0, 0, 0, 0.8);
  transition: border-color 0.2s cubic-bezier(0.16, 1, 0.3, 1),
              background-color 0.2s cubic-bezier(0.16, 1, 0.3, 1),
              transform 0.2s cubic-bezier(0.16, 1, 0.3, 1);
}

.yc-card:hover {
  background-color: var(--color-surface-hover);
  border-color: var(--color-border-hover);
  transform: translateY(-2px);
}
```

### Top Hairline Glow (`yc-card-glow`)
Simulates top-down directional lighting across obsidian surfaces:
```css
.yc-card-glow::before {
  content: "";
  position: absolute;
  top: -1px;
  left: 20%;
  right: 20%;
  height: 1px;
  background: linear-gradient(90deg, transparent, rgba(95, 211, 154, 0.5), transparent);
  pointer-events: none;
}
```

### 1px Hairline Bento Grid
Creates razor-sharp internal dividers between adjacent cards without doubling border width:
```html
<div class="rounded-2xl border border-white/[0.12] bg-white/[0.08] p-[1px] shadow-2xl">
  <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-[1px] bg-white/[0.08] rounded-[15px] overflow-hidden">
    <!-- Each card has bg-[#090a0d] p-7 -->
  </div>
</div>
```

---

## 4. Ambient Radial Glow & Dot Grid

```html
<!-- Ambient Radial Glow -->
<div class="pointer-events-none absolute -top-32 left-1/2 -z-10 h-[480px] w-[750px] -translate-x-1/2 rounded-full bg-[radial-gradient(ellipse_at_center,rgba(95,211,154,0.12),transparent_70%)] blur-3xl"></div>

<!-- Dot Grid Background -->
<div class="dotgrid">
  <!-- Content -->
</div>
```

```css
.dotgrid {
  background-image: radial-gradient(rgba(255, 255, 255, 0.09) 1px, transparent 1px);
  background-size: 24px 24px;
}
```

---

## 5. Live Telemetry Beacon

A subtle pulsing green indicator communicating local-first runtime or live system health:

```css
.live-beacon {
  display: inline-block;
  width: 6px;
  height: 6px;
  border-radius: 9999px;
  background-color: #5fd39a;
  box-shadow: 0 0 8px #5fd39a;
  animation: pulse-beacon 2s ease-in-out infinite;
}

@keyframes pulse-beacon {
  0%, 100% { opacity: 0.8; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.2); }
}
```
