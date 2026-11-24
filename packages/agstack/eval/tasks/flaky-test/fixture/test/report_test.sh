. ./lib/report.sh
want=$(printf 'alpha\nbeta\ngamma')
got=$(report)
if [ "$got" != "$want" ]; then
  echo "FAIL: got:"
  echo "$got"
  exit 1
fi
echo PASS
