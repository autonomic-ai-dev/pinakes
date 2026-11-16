[ "$(sh bin/inventory.sh count)" = 3 ] || exit 1
grep -q 'sh bin/inventory.sh count' .verify/features/inventory.md || exit 1
grep -q 'sh bin/inventory.sh list' .verify/features/inventory.md || exit 1
sh bin/inventory.sh list > /dev/null || exit 1
exit 0
