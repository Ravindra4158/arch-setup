#!/usr/bin/env fish

set -l _reload false

# Ensure config directory exists
if ! test -d $argv
    mkdir -p $argv
end

# Ensure hypr-vars exists
if ! test -f $argv/hypr-vars.conf
    touch -a $argv/hypr-vars.conf
    set -l _reload true
end

# Ensure hypr-user exists
if ! test -f $argv/hypr-user.conf
    touch -a $argv/hypr-user.conf
    set -l _reload true
end

# Ensure wallpaper state path exists for hyprpaper/hyprlock
set -l _state $HOME/.local/state/caelestia/wallpaper
set -l _current $_state/current
set -l _default ~/Pictures/wallpapers/onedark-wallpapers/wm/od_hyprland.png

if ! test -e $_current
    mkdir -p $_state
    ln -sf (realpath $_default) $_current
end

# Reload as needed
if _reload
    hyprctl reload
end
