#!/bin/sh
set -eu

if [ "$#" -ne 1 ]; then
  echo "usage: skill-trace.sh <stream.jsonl>" >&2
  exit 2
fi

jq -r '
  select(.type == "assistant")
  | .message.content[]?
  | select(.type == "tool_use")
  | if .name == "Skill" then (.input.skill // empty)
    elif .name == "Read" then ((.input.file_path // "") | select(endswith("/SKILL.md")) | split("/") | .[-2])
    else empty end
' "$1" | sort | uniq -c | sort -rn | awk '{ printf "%s\t%s\n", $2, $1 }'
