# Responsive Navigation Architecture

The most common failure in modern dark-theme landing pages is navigation squishing between 768px and 1024px. An 11-item desktop navbar forced into a single flex container collides, wipes out margins, and causes horizontal scroll blowout.

---

## 1. Breakpoint Thresholds

| Viewport Width | Device Class | Navigation Pattern |
|---|---|---|
| `< 768px` | Mobile (Phone) | Compact header + Tactile hamburger button + Slide-down mobile drawer |
| `768px – 1023px` | Tablet / iPad / Split Desktop | Compact header + Hamburger button + Mobile drawer (**Do NOT show 7+ links**) |
| `1024px – 1279px` | Small Laptop / Desktop | Full desktop nav (`lg:flex`) with tight gap (`gap-5`), local-first badge hidden |
| `≥ 1280px` | Wide Desktop (`xl:`) | Full desktop nav (`gap-7`) with all telemetry badges & secondary actions |

---

## 2. Accessible Mobile Hamburger Drawer Pattern

### Svelte 5 Implementation (`Navbar.svelte`)

```svelte
<script lang="ts">
  import { Menu, X, ArrowRight, ExternalLink } from 'lucide-svelte';
  import { page } from '$app/state';

  let mobileMenuOpen = $state(false);

  // Auto-close on navigation
  $effect(() => {
    void page.url.pathname;
    mobileMenuOpen = false;
  });
</script>

<header class="sticky top-0 z-50 border-b border-white/[0.08] bg-[#070709]/90 backdrop-blur-xl">
  <div class="yc-container flex items-center justify-between py-3.5">
    <!-- Brand -->
    <a href="/" class="flex items-center gap-2.5 text-sm font-semibold text-white">
      <span class="flex h-6 w-6 items-center justify-center rounded-lg border border-white/20 bg-white/[0.05] font-mono text-[11px] font-bold text-[#5fd39a]">A</span>
      <span>Autonomic AI</span>
    </a>

    <!-- Desktop Nav: ONLY on lg: (1024px+) -->
    <nav class="hidden lg:flex items-center gap-5 xl:gap-7 text-[13px] font-medium text-neutral-400">
      <a href="/#features" class="hover:text-white transition-colors">Features</a>
      <a href="/#how-it-works" class="hover:text-white transition-colors">How it works</a>
      <a href="/docs" class="hover:text-white transition-colors">Docs</a>
      <a href="/changelog" class="hover:text-white transition-colors">Changelog</a>
    </nav>

    <!-- Right Controls -->
    <div class="flex items-center gap-2.5">
      <a href="https://github.com/..." class="hidden sm:inline-flex ...">GitHub</a>
      <a href="#quickstart" class="hidden sm:inline-flex ...">Get Started</a>

      <!-- Hamburger Button: visible under lg -->
      <button
        type="button"
        onclick={() => (mobileMenuOpen = !mobileMenuOpen)}
        aria-label={mobileMenuOpen ? 'Close navigation' : 'Open navigation'}
        class="inline-flex lg:hidden items-center justify-center h-8 w-8 rounded-lg border border-white/[0.12] bg-white/[0.04] text-neutral-300"
      >
        {#if mobileMenuOpen}
          <X size={16} />
        {:else}
          <Menu size={16} />
        {/if}
      </button>
    </div>
  </div>

  <!-- Mobile Drawer -->
  {#if mobileMenuOpen}
    <div class="lg:hidden border-t border-white/[0.08] bg-[#090a0d] px-4 py-5 space-y-6">
      <!-- Grouped Products -->
      <div>
        <span class="font-mono text-[11px] uppercase tracking-wider text-neutral-500">Products</span>
        <!-- Product Links -->
      </div>

      <!-- Navigation Links -->
      <div class="flex flex-col space-y-1">
        <a href="/#features" onclick={() => (mobileMenuOpen = false)} class="px-3 py-2 text-sm text-neutral-300">Features</a>
        <a href="/docs" onclick={() => (mobileMenuOpen = false)} class="px-3 py-2 text-sm text-neutral-300">Documentation</a>
        <a href="/changelog" onclick={() => (mobileMenuOpen = false)} class="px-3 py-2 text-sm text-neutral-300">Changelog</a>
      </div>
    </div>
  {/if}
</header>
```

---

## 3. Viewport Overflow Prevention Checklist

1. **All `<pre>` elements outside prose:**
   Must have `overflow-x-auto` or `text-wrap: balance`:
   ```html
   <pre class="overflow-x-auto text-xs font-mono leading-relaxed"></pre>
   ```
2. **Tables:**
   Wrap all tables inside an `overflow-x-auto` container with `-webkit-overflow-scrolling: touch`:
   ```html
   <div class="overflow-x-auto rounded-2xl border border-white/[0.08]">
     <table class="w-full min-w-[540px]">...</table>
   </div>
   ```
3. **Execution Loop Cards:**
   Use `grid-cols-1 sm:grid-cols-2 lg:grid-cols-4`. Never jump directly from 1 column on mobile to 4 columns on tablet (`md:grid-cols-4`).
4. **Hero Action Buttons:**
   Ensure long button titles (e.g. *"Explore Tekmor & Thesmos"*) use `truncate` or wrap gracefully with `flex-col sm:flex-row`.
