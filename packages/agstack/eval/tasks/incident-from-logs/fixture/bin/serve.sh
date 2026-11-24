. ./lib/config.sh
load_config
echo "$(date '+%T') INFO serve: starting worker" >> logs/app.log
sh lib/worker.sh
