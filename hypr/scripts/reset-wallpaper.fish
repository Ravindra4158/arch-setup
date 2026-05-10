#!/usr/bin/env fish

set -l _state $HOME/.local/state/caelestia/wallpaper
set -l _current $_state/current
set -l _path_file $_state/path.txt
set -l _source ~/Wall-E-Desk/Pixel-Art/disc.gif

if ! test -e $_source
    echo "Default wallpaper source not found: $_source" >&2
    exit 1
end

mkdir -p $_state
ln -sf (realpath $_source) $_current; or exit 1
printf '%s' (realpath $_source) > $_path_file; or exit 1

# Apply immediately to the wallpaper backend.
if command -q mpvpaper
    pkill -x mpvpaper > /dev/null 2>&1
    mpvpaper -o 'no-audio loop-file=inf' '*' "$_current" >/dev/null 2>&1 &
else if command -q hyprctl
    hyprctl hyprpaper unload all > /dev/null 2>&1
    hyprctl hyprpaper preload $_current
    hyprctl hyprpaper wallpaper ",$_current"
end

echo "Wallpaper reset and applied: $_source"
