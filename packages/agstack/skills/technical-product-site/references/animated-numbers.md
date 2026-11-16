# Animated Empirical Numbers & Metrics

In high-conviction technical product websites, numbers are the ultimate sales pitch: RAM reductions (`98% less memory`), startup speedups (`350x faster`), and cold boot timings (`12 ms vs 4,200 ms`).

Presenting static numbers fails to capture developer attention; conversely, heavy React re-renders during number counting kill animation frame rates.

This specification details the **SSR-First, Zero-Re-Render Animated Counter Architecture**.

---

## 1. Core Principles

1. **SSR & SEO First:**
   The initial server-rendered HTML must contain the complete, final formatted number (e.g. `98%`, `350x`, `4,200 ms`). Search engines, scraping bots, and initial paints never see `0` or an empty placeholder.
2. **Zero Cumulative Layout Shift (CLS):**
   Because the server output contains the full number, the typography occupies its exact computed bounding box from frame zero.
3. **Zero React Component Re-Renders (Direct DOM Updates):**
   During the 60/120 FPS count-up animation, updating React state (`useState`) triggers hundreds of redundant component renders. Instead, we directly mutate `ref.current.textContent` during animation frames.
4. **Bidirectional Scroll Reactivity (`once: false`):**
   - Entering Viewport: Animates smoothly from `0` to `targetValue`.
   - Exiting Viewport: Resets to `0` (or starting state).
   - Re-Entering: Smoothly counts up again, creating a tactile, living interface.

---

## 2. Component Implementation (`AnimatedNumber.tsx`)

```tsx
"use client";

import { useEffect, useRef } from "react";
import { useInView, animate } from "motion/react";

interface AnimatedNumberProps {
  value: number;
  prefix?: string;
  suffix?: string;
  formatCommas?: boolean;
  className?: string;
  duration?: number;
  delay?: number;
}

export function AnimatedNumber({
  value,
  prefix = "",
  suffix = "",
  formatCommas = false,
  className = "",
  duration = 1.3,
  delay = 0,
}: AnimatedNumberProps) {
  const ref = useRef<HTMLSpanElement>(null);
  const isInView = useInView(ref, { once: false, amount: 0.2 });

  useEffect(() => {
    if (!ref.current) return;

    if (isInView) {
      const controls = animate(0, value, {
        duration,
        delay,
        ease: [0.16, 1, 0.3, 1], // Signature technical cubic bezier
        onUpdate(latest) {
          if (ref.current) {
            const rounded = Math.round(latest);
            const formatted = formatCommas ? rounded.toLocaleString() : rounded.toString();
            ref.current.textContent = `${prefix}${formatted}${suffix}`;
          }
        },
      });
      return () => controls.stop();
    } else {
      if (ref.current) {
        ref.current.textContent = `${prefix}0${suffix}`;
      }
    }
  }, [isInView, value, prefix, suffix, formatCommas, duration, delay]);

  // SSR Initial Render: Outputs final formatted value for SEO and zero CLS
  return (
    <span ref={ref} className={className}>
      {prefix}{formatCommas ? value.toLocaleString() : value}{suffix}
    </span>
  );
}
```

---

## 3. Synchronized Metric Bar Expansion

When presenting comparison bars (e.g., Docker vs Bare-Metal systemd), pair the `AnimatedNumber` counter with an expanding Framer Motion progress bar:

```tsx
{/* Anode Bar */}
<div>
  <div className="flex justify-between text-xs font-mono-code text-neutral-400 mb-1.5">
    <span className="text-white font-semibold">Anode Static ELF</span>
    <span className="text-white font-bold font-mono-code">
      <AnimatedNumber value={12} suffix=" ms" duration={1.0} delay={0.15} />
    </span>
  </div>
  <div className="w-full h-8 rounded-lg bg-neutral-900 border border-white/[0.06] overflow-hidden p-0.5">
    <motion.div
      initial={{ width: "0%" }}
      whileInView={{ width: "4%" }}
      viewport={{ once: false, amount: 0.2 }}
      transition={{ duration: 0.85, delay: 0.15, ease: [0.16, 1, 0.3, 1] }}
      className="h-full rounded-md bg-white min-w-[48px] flex items-center justify-center shadow-[0_0_15px_rgba(255,255,255,0.3)]"
    >
      <span className="text-[10px] font-mono-code text-black font-bold">
        <AnimatedNumber value={12} suffix=" ms" duration={1.0} delay={0.15} />
      </span>
    </motion.div>
  </div>
</div>
```

---

## 4. Easing Curves & Timing Guidelines

| Metric Magnitude | Example | Recommended Duration | Easing |
|---|---|---|---|
| Percentages (`0–100%`) | `98%` | `1.1s – 1.3s` | `[0.16, 1, 0.3, 1]` |
| Multipliers (`1x–500x`) | `350x` | `1.2s – 1.4s` | `[0.16, 1, 0.3, 1]` |
| Latencies (`0–5000 ms`) | `4,200 ms` | `1.3s – 1.6s` | `[0.16, 1, 0.3, 1]` |
| Megabytes (`0–1024 MB`) | `850 MB` | `1.0s – 1.2s` | `[0.16, 1, 0.3, 1]` |
