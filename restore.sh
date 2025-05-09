#!/bin/bash
# GNOME Restore Script

set -eo pipefail
trap 'echo -e "\nERROR: Restoration failed! Check permissions or paths." >&2; exit 1' ERR

echo -e "\nRestoring GNOME environment..."
echo "- Restoring themes..."
mkdir -p "$HOME/.themes" "$HOME/.local/share/themes"
rsync -a --ignore-missing-args "themes/" "$HOME/.themes/"
rsync -a --ignore-missing-args "themes/" "$HOME/.local/share/themes/"

echo "- Restoring icons..."
mkdir -p "$HOME/.icons" "$HOME/.local/share/icons"
rsync -a --ignore-missing-args "icons/" "$HOME/.icons/"
rsync -a --ignore-missing-args "icons/" "$HOME/.local/share/icons/"

echo "- Restoring extensions..."
[ -d "extensions" ] && mkdir -p "$HOME/.local/share/gnome-shell/extensions" && rsync -a "extensions/" "$HOME/.local/share/gnome-shell/extensions/"

echo "- Applying settings..."
dconf load / < "settings/gnome.dconf"
dconf load /org/gnome/shell/extensions/ < "settings/extensions.dconf"

echo -e "\nRestore complete!"
echo "Restart GNOME with Alt+F2 → 'r'"
echo "Backup directory preserved at: $(pwd)"
