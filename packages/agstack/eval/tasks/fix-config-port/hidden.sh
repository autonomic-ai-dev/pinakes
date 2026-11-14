. ./lib/config.sh
[ "$(parse_port 1)" = 1 ] || exit 1
[ "$(parse_port 65535)" = 65535 ] || exit 1
parse_port 0 >/dev/null 2>&1 && exit 1
parse_port 65536 >/dev/null 2>&1 && exit 1
parse_port x >/dev/null 2>&1 && exit 1
[ "$(parse_port 8080)" = 8080 ] || exit 1
exit 0
