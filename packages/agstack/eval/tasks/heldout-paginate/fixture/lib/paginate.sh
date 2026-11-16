page() {
  items="$1"
  size="$2"
  number="$3"
  start=$(( number * size ))
  printf '%s\n' "$items" | tail -n +$((start + 1)) | head -n "$size"
}
