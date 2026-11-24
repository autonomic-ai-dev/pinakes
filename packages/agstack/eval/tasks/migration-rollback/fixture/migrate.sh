direction="$1"
case "$direction" in
  up)   files=$(ls migrations/*.up.sh 2>/dev/null | sort) ;;
  down) files=$(ls migrations/*.down.sh 2>/dev/null | sort -r) ;;
  *) echo "usage: migrate.sh up|down" >&2; exit 2 ;;
esac
for f in $files; do
  sh "$f"
done
