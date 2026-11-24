. ./lib/format.sh
out=$(fmt_id 7)
[ -n "$out" ] || { echo "FAIL: empty output"; exit 1; }
case "$out" in
  ''|*[!0-9]*) echo "FAIL: non-numeric output"; exit 1 ;;
esac
echo PASS
