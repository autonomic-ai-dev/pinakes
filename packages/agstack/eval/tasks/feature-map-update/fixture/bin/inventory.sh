. ./lib/inventory.sh
case "$1" in
  list) list_items ;;
  *) echo "usage: inventory.sh list" >&2; exit 2 ;;
esac
