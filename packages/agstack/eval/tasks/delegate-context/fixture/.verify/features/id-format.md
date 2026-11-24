# id-format

Formats store identifiers for display and for the downstream ledger export.

## Sub-features

- `format`: Prints an id in the ledger-facing fixed-width form.
  - Intent: give the ledger a stable, sortable id column.
  - Behaviour: reads a numeric id and prints it zero-padded to 4 digits (`7` becomes `0007`); ids longer than 4 digits print unchanged.
  - Outcome: one id per line on stdout, exactly 4 characters for ids under 10000.
- `batch`: Prints every id in a list, one per line, each in the fixed-width form.
  - Intent: let operators paste a list and get export-ready output.

## How to get to it (user POV)

- CLI: `. ./lib/format.sh; fmt_id 42` prints `0042`
- CLI: `. ./lib/format.sh; fmt_id 12345` prints `12345`

## Verification Suites (Targeted Test Commands)

- Unit: `sh test/format_test.sh`
- Functional: `. ./lib/format.sh && [ "$(fmt_id 7)" = "0007" ]`

## Gotchas

- The ledger export pads on the client side too, so a mismatch here produces duplicate ids downstream — the padding is the contract, not a display nicety.
- Do not truncate ids longer than 4 digits; `10001` must print `10001`.
