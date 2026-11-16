. ./lib/slug.sh
[ "$(slugify "  A  B ")" = a-b ] || exit 1
[ "$(slugify "x_y.z")" = x-y-z ] || exit 1
[ "$(slugify "Release 2.0 Notes")" = release-2-0-notes ] || exit 1
[ "$(slugify "---")" = "" ] || exit 1
[ "$(slugify "abc")" = abc ] || exit 1
exit 0
