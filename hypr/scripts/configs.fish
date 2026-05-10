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

# Ensure wallpaper state path exists for the desktop wallpaper and hyprlock
set -l _state $HOME/.local/state/caelestia/wallpaper
set -l _current $_state/current
set -l _path_file $_state/path.txt
set -l _source ~/Wall-E-Desk/Pixel-Art/disc.gif

if ! test -e $_current; or ! test -f $_path_file
    mkdir -p $_state
    if ! test -e $_source
        echo "Default wallpaper source not found: $_source" >&2
        exit 1
    end

    ln -sf (realpath $_source) $_current; or exit 1
    printf '%s' (realpath $_source) > $_path_file; or exit 1
end

# Make the Appearance wallpaper picker see the local wallpaper collection.
# Caelestia scans ~/Pictures/Wallpapers recursively by default.
set -l _wall_source $HOME/Wall-E-Desk
set -l _wall_dir $HOME/Pictures/Wallpapers

if test -d "$_wall_source"
    mkdir -p (path dirname "$_wall_dir")

    if test -L "$_wall_dir"
        # Existing symlink is fine; leave user customisation alone.
    else if ! test -e "$_wall_dir"
        ln -s (realpath "$_wall_source") "$_wall_dir"; or exit 1
    else if test -d "$_wall_dir"
        set -l _wall_link "$_wall_dir/Wall-E-Desk"

        if ! test -e "$_wall_link"; and ! test -L "$_wall_link"
            ln -s (realpath "$_wall_source") "$_wall_link"; or exit 1
        end
    else
        echo "Wallpaper directory path exists but is not a directory: $_wall_dir" >&2
    end
end

# Reload as needed
if test "$_reload" = true
    hyprctl reload
end
