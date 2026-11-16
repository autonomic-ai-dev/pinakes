. ./lib/path.sh
[ "$(safe_join /srv/app notes.txt)" = /srv/app/notes.txt ] || { echo "FAIL join"; exit 1; }
safe_join /srv/app ../etc/passwd >/dev/null 2>&1
[ $? -eq 1 ] || { echo "FAIL traversal"; exit 1; }
echo ok
