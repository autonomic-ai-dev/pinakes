. ./lib/paginate.sh
items="$(printf 'a\nb\nc\nd\ne\nf')"
[ "$(page "$items" 3 2)" = "$(printf 'd\ne\nf')" ] || exit 1
[ -z "$(page "$items" 3 3)" ] || exit 1
[ "$(page "$items" 1 6)" = "f" ] || exit 1
[ -z "$(page "$items" 2 9)" ] || exit 1
exit 0
