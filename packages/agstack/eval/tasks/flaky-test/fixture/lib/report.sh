report() {
  ls data/ | while read -r f; do
    echo "$RANDOM $f"
  done | sort -n | sed 's/^[0-9]* //'
}
