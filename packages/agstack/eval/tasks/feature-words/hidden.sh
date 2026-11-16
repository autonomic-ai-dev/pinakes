. ./lib/words.sh
[ "$(count_words "  spaced   out  ")" = 2 ] || exit 1
[ "$(count_words "")" = 0 ] || exit 1
[ "$(count_words "solo")" = 1 ] || exit 1
[ "$(count_words "a	tab b")" = 3 ] || exit 1
exit 0
