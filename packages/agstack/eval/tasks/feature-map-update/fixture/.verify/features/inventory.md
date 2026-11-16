# inventory

Prints the items the store holds, one per line, for an operator checking stock.

## Sub-features

- `list-items`: Prints every stored item.
  - Intent: let an operator see what is in stock.
  - Behaviour: reads data/items.txt and prints it.
  - Outcome: one item per line.

## How to get to it (user POV)

- CLI: `sh bin/inventory.sh list`

## Verification Suites (Targeted Test Commands)

- Unit: `sh test/inventory_test.sh`

## Gotchas

- Items with spaces are printed as stored.
