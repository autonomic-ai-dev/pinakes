out="$(sh bin/inventory.sh list)"
[ "$(echo "$out" | head -n 1)" = apple ] || { echo "FAIL list"; exit 1; }
echo ok
