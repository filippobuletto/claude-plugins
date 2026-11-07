#!/usr/bin/env bash
# Checks each github entry in marketplace.json against the plugin's own
# .claude-plugin/plugin.json on its default branch. Requires curl and jq.
set -uo pipefail

MKT="$(cd "$(dirname "$0")/.." && pwd)/.claude-plugin/marketplace.json"
pass=0 fail=0

check() { # check <name> <expected> <actual>
  if [[ "$2" == "$3" ]]; then pass=$((pass + 1)); echo "ok   $1"
  else fail=$((fail + 1)); printf 'FAIL %s\n  expected: %s\n  actual:   %s\n' "$1" "$2" "$3"; fi
}

while IFS=$'\t' read -r name repo; do
  manifest=$(curl -fsSL "https://raw.githubusercontent.com/$repo/HEAD/.claude-plugin/plugin.json" 2>/dev/null)
  check "$name: plugin.json reachable in $repo" true "$([[ -n "$manifest" ]] && echo true || echo false)"
  check "$name: manifest name matches entry" "$name" "$(jq -r '.name' <<<"$manifest" 2>/dev/null)"
  for field in description homepage license; do
    check "$name: $field matches manifest" "$(jq -r ".$field" <<<"$manifest" 2>/dev/null)" \
      "$(jq -r --arg n "$name" ".plugins[] | select(.name == \$n) | .$field" "$MKT")"
  done
done < <(jq -r '.plugins[] | select(.source.source == "github") | [.name, .source.repo] | @tsv' "$MKT")

echo "$pass passed, $fail failed"
[[ $fail -eq 0 ]]
