. ./lib/paginate.sh
items="$(printf 'a\nb\nc\nd\ne')"
[ "$(page "$items" 2 1)" = "$(printf 'a\nb')" ] || { echo "FAIL first"; exit 1; }
[ "$(page "$items" 2 3)" = "e" ] || { echo "FAIL last"; exit 1; }
echo ok
