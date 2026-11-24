rm -f state
. ./lib/counter.sh
i=0
while [ $i -lt 20 ]; do
  increment &
  i=$((i + 1))
done
wait
n=$(cat state)
if [ "$n" != 20 ]; then
  echo "FAIL: count=$n want 20"
  exit 1
fi
echo PASS
