i=0
while [ $i -lt 8 ]; do
  sh test/report_test.sh >/dev/null 2>&1 || exit 1
  i=$((i + 1))
done
exit 0
