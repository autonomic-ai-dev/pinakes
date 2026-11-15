# Trust & Evidence: The "Show, Don't Tell" Doctrine

Engineers have high skepticism toward marketing copy. They trust software that exposes its mechanisms, proves its assertions with reproducible artifacts, and clearly states its boundaries.

---

## 1. Grounding Rules for Copywriting

1. **Verify Against Code Before Publishing:**
   Never write a marketing claim that cannot be proven by inspecting the codebase.
   - If claiming `"0 model calls"`, verify that no LLM API client (`anthropic`, `openai`) exists in runtime dependencies.
   - If claiming `"Cryptographic tree receipts"`, verify that git commit and tree hashes are actually hashed into `.verify/receipt.json`.
   - If claiming `"Deterministic execution"`, verify that runs are reproducible and stored immutably in SQLite.

2. **Replace Superlatives with Invariants:**
   - Instead of *"Blazing-fast execution"*, write *"Completes 14 allowlisted checks in 0.38s"*.
   - Instead of *"Military-grade security"*, write *"Refuses arbitrary bash execution outside `.verify/verify.toml`"*.
   - Instead of *"Effortless agent integration"*, write *"Registers a native stop hook in Claude Code settings"*.

3. **No Fluff Adjectives:**
   Ban the following words from product websites:
   - *Revolutionary*
   - *Effortless*
   - *Seamless*
   - *Next-generation*
   - *Robust*
   - *AI-powered magic*

---

## 2. The "Honest Boundaries" Section

One of the strongest trust-builders on high-conviction developer and platform engineering product sites is an explicit **"What it does not do yet"** or **"Honest Boundaries"** section:

### Example Pattern:
```html
<section>
  <span class="yc-label">Honest Boundaries</span>
  <h2>What it does not do yet.</h2>
  <p>Engineering boundaries and explicit non-goals for this release.</p>

  <ul class="divide-y divide-white/[0.06] rounded-2xl border border-white/[0.1] bg-[#0c0d10]">
    <li class="flex gap-4 px-6 py-5 text-sm text-neutral-300">
      <Minus class="text-neutral-500 shrink-0" />
      <span>Does not sandbox network connections for allowlisted test commands; network isolation must be enforced by container harnesses.</span>
    </li>
    <li class="flex gap-4 px-6 py-5 text-sm text-neutral-300">
      <Minus class="text-neutral-500 shrink-0" />
      <span>Does not support Windows shells (PowerShell/cmd.exe); runtime currently requires macOS or Linux POSIX subshells.</span>
    </li>
    <li class="flex gap-4 px-6 py-5 text-sm text-neutral-300">
      <Minus class="text-neutral-500 shrink-0" />
      <span>Does not evaluate subjective code style; only passes or fails deterministic allowlisted commands.</span>
    </li>
  </ul>
</section>
```

When developers see what a tool *refuses* to do, they trust that what it claims to do is real.

---

## 3. Comparison Matrix: Mechanisms vs Instructions

Developer landing pages should explicitly contrast **Process Gates** against **Prompt Instructions**:

| Feature / Scenario | Unrestricted Agent (Instructions Only) | Hard Gate Engine (Tekmor / Thesmos) |
|---|---|---|
| **Agent claims tests pass without running** | Accepted (Agent hallucinates success) | **Hard Blocked** by Claude Code Stop Hook |
| **Code modified after tests completed** | Stale pass accepted as valid | **Receipt Invalidated** (Mismatch in git tree SHA) |
| **Arbitrary bash command executed** | Runs unchecked in subshell | **Refused** unless in `.verify/` allowlist |
| **Flaky test runs that intermittently pass** | Single lucky pass accepted | **Flagged as Flaky** after N repeated runs |
| **LLM tokens spent on verification** | Burns metered model tokens | **0 model tokens** (100% deterministic local code) |
