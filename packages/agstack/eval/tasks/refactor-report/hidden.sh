expected='user: alice (active)
order: 1042 (shipped)
user: bob (suspended)'
actual="$(sh bin/report.sh)"
[ "$actual" = "$expected" ] || exit 1
exit 0
