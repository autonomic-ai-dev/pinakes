. ./lib/enrich.sh
start=$SECONDS
out=$(enrich)
elapsed=$((SECONDS - start))
[ "$(echo "$out" | wc -l | tr -d ' ')" = 100 ] || exit 1
[ "$(echo "$out" | grep -c '|120$')" = 100 ] || exit 1
[ "$elapsed" -lt 5 ] || exit 1
exit 0
