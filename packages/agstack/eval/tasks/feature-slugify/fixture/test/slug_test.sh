. ./lib/slug.sh
[ "$(slugify "Hello, World!")" = hello-world ] || { echo "FAIL example"; exit 1; }
echo ok
