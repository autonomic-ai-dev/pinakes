cp data/db.txt /tmp/pinakes_eval_db.$$
sh migrate.sh up || exit 1
grep -q '^emails:' data/db.txt || exit 1
sh migrate.sh down || exit 1
cmp -s data/db.txt /tmp/pinakes_eval_db.$$ || { rm -f /tmp/pinakes_eval_db.$$; exit 1; }
ls migrations/*_add_email.down.sh >/dev/null 2>&1 || { rm -f /tmp/pinakes_eval_db.$$; exit 1; }
rm -f /tmp/pinakes_eval_db.$$
exit 0
