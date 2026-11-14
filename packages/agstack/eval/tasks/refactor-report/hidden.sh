expected='user: alice (active)
order: 1042 (shipped)
user: bob (suspended)'
actual="$(sh bin/report.sh)"
[ "$actual" = "$expected" ] || exit 1
. ./lib/report.sh
[ "$(format_user carol vip)" = "user: carol (vip)" ] || exit 1
[ "$(format_order 7 new)" = "order: 7 (new)" ] || exit 1
exit 0
