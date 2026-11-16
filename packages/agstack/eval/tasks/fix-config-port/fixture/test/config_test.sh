. ./lib/config.sh
[ "$(parse_port 8080)" = 8080 ] || { echo "FAIL valid"; exit 1; }
parse_port abc >/dev/null 2>&1
[ $? -eq 2 ] || { echo "FAIL invalid"; exit 1; }
echo ok
