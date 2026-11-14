. ./lib/report.sh
[ "$(format_user carol vip)" = "user: carol (vip)" ] || { echo "FAIL user"; exit 1; }
[ "$(format_order 7 new)" = "order: 7 (new)" ] || { echo "FAIL order"; exit 1; }
echo ok
