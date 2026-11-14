clamp() {
  v=$1
  lo=$2
  hi=$3
  if [ "$v" -lt "$lo" ]; then
    echo "$lo"
  elif [ "$v" -lt "$hi" ]; then
    echo "$hi"
  else
    echo "$v"
  fi
}
