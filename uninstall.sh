#!/bin/bash
# Remove everything install.sh put in place.
set -euo pipefail

rm -f \
  "$HOME/.config/omarchy/hooks/theme-set.d/omaterm" \
  "$HOME/.config/omarchy/themed/tern.json.tpl" \
  "$HOME/.local/state/omarchy/current/theme/tern.json" \
  "${PI_CODING_AGENT_DIR:-$HOME/.omp/agent}/themes/omarchy.json"
rm -rf "$HOME/.local/share/omaterm"

echo "omaterm removed. Pick another theme in Tern's settings."
