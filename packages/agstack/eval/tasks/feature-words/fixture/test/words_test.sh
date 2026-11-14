. ./lib/words.sh
[ "$(count_words "one two three")" = 3 ] || { echo "FAIL basic"; exit 1; }
echo ok
