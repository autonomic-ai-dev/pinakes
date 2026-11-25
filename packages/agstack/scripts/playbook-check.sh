#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "usage: playbook-check.sh <stream.jsonl> <playbook-spec>" >&2
  exit 2
fi

jq -r '
  select(.type == "assistant")
  | .message.content[]?
  | select(.type == "tool_use")
  | if .name == "Read" and ((.input.file_path // "") | test("/playbooks/[^/]+[.]md$")) then
      "read " + (.input.file_path | split("/") | last | rtrimstr(".md"))
    elif .name == "Read" and ((.input.file_path // "") | test("/skills/.*SKILL[.]md$")) then
      "read " + (.input.file_path | split("/") | .[-2])
    elif .name == "Skill" then "read " + (.input.skill // "")
    elif (.name == "TodoWrite" or .name == "TaskCreate" or .name == "TaskUpdate" or .name == "TaskList") then "read plan"
    elif .name == "Edit" or .name == "Write" or .name == "MultiEdit" or .name == "NotebookEdit" then "edit"
    else empty end
' "$1" | awk -v spec="$2" '
  BEGIN {
    while ((getline line < spec) > 0) {
      n = split(line, p, " ")
      if (n == 0) continue
      want[++m] = p[1]
      stage[m] = (n >= 2) ? p[2] : "before"
    }
    close(spec)
  }
  $1 == "edit" { edited = 1; next }
  $1 == "read" {
    if (edited) after[$2] = 1
    else before[$2] = 1
  }
  END {
    fail = 0
    for (i = 1; i <= m; i++) {
      if (stage[i] == "after") ok = (want[i] in after)
      else if (stage[i] == "before") ok = (want[i] in before)
      else ok = 0
      printf "%s %s %s\n", (ok ? "PASS" : "FAIL"), want[i], stage[i]
      if (!ok) fail = 1
    }
    print (fail ? "FAIL" : "PASS")
  }
'
