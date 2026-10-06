#!/bin/bash
# Install the active Omarchy theme's tern.json as the "omarchy" theme in omp's
# custom themes directory, which is where Tern finds user themes (and omp's /theme
# picker can use it too). Generated from ~/.config/omarchy/themed/tern.json.tpl.
# Symlinked into ~/.config/omarchy/hooks/theme-set.d/omaterm; safe to run by hand.
set -euo pipefail

THEME_JSON="$HOME/.local/state/omarchy/current/theme/tern.json"
TERN_THEMES="${PI_CODING_AGENT_DIR:-$HOME/.omp/agent}/themes"

[[ -f $THEME_JSON ]] || exit 0

mkdir -p "$TERN_THEMES"
tmp=$(mktemp "$TERN_THEMES/.omarchy.json.XXXXXX")
cp "$THEME_JSON" "$tmp"
chmod 644 "$tmp"
mv "$tmp" "$TERN_THEMES/omarchy.json"
