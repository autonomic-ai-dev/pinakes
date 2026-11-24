i=0
while [ $i -lt 5 ]; do
  sh test/race_test.sh >/dev/null 2>&1 || exit 1
  i=$((i + 1))
done
exit 0
