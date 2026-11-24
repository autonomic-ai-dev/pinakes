if [ -z "$DB_URL" ]; then
  echo "$(date '+%T') FATAL worker: DB_URL unset, refusing to start" >> logs/app.log
  exit 1
fi
echo "ready: connected to $DB_URL"
