. ./lib/clamp.sh
[ "$(clamp 5 0 10)" = 5 ] || { echo "FAIL in-range"; exit 1; }
[ "$(clamp -3 0 10)" = 0 ] || { echo "FAIL low"; exit 1; }
echo ok
