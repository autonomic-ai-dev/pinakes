expected='user: alice (active)
order: 1042 (shipped)
user: bob (suspended)'
[ "$(sh bin/report.sh)" = "$expected" ] || { echo "FAIL output"; exit 1; }
echo ok
