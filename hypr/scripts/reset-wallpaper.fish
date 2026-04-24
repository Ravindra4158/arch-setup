#!/usr/bin/env fish

set -l _default ~/Pictures/wallpapers/onedark-wallpapers/wm/od_hyprland.png
set -l _state $HOME/.local/state/caelestia/wallpaper
set -l _current $_state/current

if ! test -e $_default
    echo "Default wallpaper not found: $_default" >&2
    exit 1
end

mkdir -p $_state
ln -sf (realpath $_default) $_current

# Apply immediately to running hyprpaper.
hyprctl hyprpaper unload all > /dev/null 2>&1
hyprctl hyprpaper preload $_current
hyprctl hyprpaper wallpaper ",$_current"

echo "Wallpaper reset and applied: $_current"
