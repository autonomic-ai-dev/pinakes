. ./lib/format.sh
[ "$(fmt_id 7)" = "0007" ] || exit 1
[ "$(fmt_id 42)" = "0042" ] || exit 1
[ "$(fmt_id 1234)" = "1234" ] || exit 1
[ "$(fmt_id 12345)" = "12345" ] || exit 1
sh test/format_test.sh >/dev/null 2>&1 || exit 1
grep -rl '0007\|0042' test/ | grep -qv 'format_test.sh' || exit 1
exit 0
