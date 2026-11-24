sh bin/serve.sh 2>/dev/null | grep -q 'ready' || exit 1
[ -f postmortem.md ] || exit 1
grep -qi 'DB_URL' postmortem.md || exit 1
exit 0
