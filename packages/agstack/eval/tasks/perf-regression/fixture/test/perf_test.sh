. ./lib/enrich.sh
start=$SECONDS
out=$(enrich)
elapsed=$((SECONDS - start))
rows=$(echo "$out" | wc -l | tr -d ' ')
if [ "$rows" != 100 ]; then
  echo "FAIL: rows=$rows want 100"
  exit 1
fi
if [ "$elapsed" -ge 5 ]; then
  echo "FAIL: ${elapsed}s over 5s budget"
  exit 1
fi
echo PASS
