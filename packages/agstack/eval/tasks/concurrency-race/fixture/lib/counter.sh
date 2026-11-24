increment() {
  n=$(cat state 2>/dev/null || echo 0)
  echo $((n + 1)) > state
}
