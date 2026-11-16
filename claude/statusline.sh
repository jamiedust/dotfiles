#!/usr/bin/env bash
input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.current_dir')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Emit a 24-bit ANSI foreground escape
# for a #rrggbb hex colour
from_hex() {
  local hex=${1#\#}
  printf '\033[38;2;%d;%d;%dm' "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

theme_reset=$'\033[0m'

theme_blue=$(from_hex '#61afef')
theme_green=$(from_hex '#98c379')
theme_yellow=$(from_hex '#d19966')
theme_red=$(from_hex '#e06c75')

out="${dir/#$HOME/~}"

if git -C "$dir" rev-parse --git-dir > /dev/null 2>&1; then
  branch=$(git -C "$dir" branch --show-current 2>/dev/null)

  staged=$(git -C "$dir" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
  modified=$(git -C "$dir" diff --numstat 2>/dev/null | wc -l | tr -d ' ')

  color=${theme_green}

  [ "$STAGED" -gt 0 ] && color=${theme_yellow}
  [ "$MODIFIED" -gt 0 ] && color=${theme_yellow}

  out="$out ${color}$branch${theme_reset}"
fi

[ -n "$used" ] && [ "${used%.*}" -gt 10 ] 2>/dev/null && out="$out ${theme_red}ctx: ${used}%${theme_reset}"

printf '%b\n' "$out"
