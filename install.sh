#!/bin/bash
# Install omaterm: Tern theme template, sync script and theme-set hook.
set -euo pipefail

REPO_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SHARE_DIR="$HOME/.local/share/omaterm"
TEMPLATE="$HOME/.config/omarchy/themed/tern.json.tpl"
RENDERED="$HOME/.local/state/omarchy/current/theme/tern.json"
HOOKS_DIR="$HOME/.config/omarchy/hooks"
TERN_SETTINGS="${TERN_CONFIG_DIR:-$HOME/.config/tern}/settings.json"

if ! command -v omarchy >/dev/null; then
  echo "omaterm needs Omarchy (https://omarchy.org)." >&2
  exit 1
fi

# Omarchy renders themed/*.tpl only while applying a theme, so a new or changed
# template needs the current theme re-applied; otherwise copying tern.json is enough.
needs_refresh=0
if [[ ! -f $RENDERED ]] || ! cmp -s "$REPO_DIR/tern.json.tpl" "$TEMPLATE"; then
  needs_refresh=1
fi

mkdir -p "$SHARE_DIR" "$(dirname "$TEMPLATE")" "$HOOKS_DIR/theme-set.d"
install -m 755 "$REPO_DIR/sync.sh" "$SHARE_DIR/sync.sh"
install -m 644 "$REPO_DIR/tern.json.tpl" "$TEMPLATE"
ln -sf "$SHARE_DIR/sync.sh" "$HOOKS_DIR/theme-set.d/omaterm"

if ((needs_refresh)); then
  omarchy theme refresh # runs the theme-set hook, which installs the theme
else
  "$SHARE_DIR/sync.sh"
fi

# A running Tern rewrites settings.json from memory, so only edit it while Tern is closed.
if ! pgrep -x tern >/dev/null && [[ -f $TERN_SETTINGS ]] && command -v jq >/dev/null; then
  tmp=$(mktemp "$TERN_SETTINGS.XXXXXX")
  jq '.theme_dark = "omarchy" | .theme_light = "omarchy"' "$TERN_SETTINGS" >"$tmp"
  mv "$tmp" "$TERN_SETTINGS"
  echo "omaterm installed and selected in Tern."
else
  cat <<EOF
omaterm installed.
Select it once in Tern: Settings -> Theme -> "omarchy" (for both dark and light).
EOF
fi
