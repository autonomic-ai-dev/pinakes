grep -v '^users:' data/db.txt > data/db.txt.tmp 2>/dev/null
mv data/db.txt.tmp data/db.txt 2>/dev/null
echo 'users: id|name' >> data/db.txt
