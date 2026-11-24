enrich() {
  while IFS='|' read -r id name; do
    count=0
    while IFS='|' read -r sid score; do
      [ "$sid" = "$id" ] && count=$((count + 1))
    done < data/scores.txt
    echo "$id|$name|$count"
  done < data/users.txt
}
