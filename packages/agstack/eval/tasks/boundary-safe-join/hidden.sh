. ./lib/path.sh
[ "$(safe_join /srv/app sub/dir/x)" = /srv/app/sub/dir/x ] || exit 1
[ "$(safe_join /srv/app a..b)" = /srv/app/a..b ] || exit 1
safe_join /srv/app /etc/passwd >/dev/null 2>&1 && exit 1
safe_join /srv/app a/../../b >/dev/null 2>&1 && exit 1
safe_join /srv/app .. >/dev/null 2>&1 && exit 1
exit 0
