. ./lib/clamp.sh
[ "$(clamp 5 0 10)" = 5 ] || exit 1
[ "$(clamp -3 0 10)" = 0 ] || exit 1
[ "$(clamp 15 0 10)" = 10 ] || exit 1
[ "$(clamp 10 0 10)" = 10 ] || exit 1
[ "$(clamp 0 0 10)" = 0 ] || exit 1
[ "$(clamp 7 7 7)" = 7 ] || exit 1
exit 0
