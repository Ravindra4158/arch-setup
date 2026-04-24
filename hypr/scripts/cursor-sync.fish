#!/usr/bin/env fish

if test (count $argv) -lt 2
    exit 1
end

set -l wanted_theme $argv[1]
set -l wanted_size $argv[2]

set -l current_theme (gsettings get org.gnome.desktop.interface cursor-theme 2>/dev/null | string trim | string replace -a "'" "")
set -l current_size (gsettings get org.gnome.desktop.interface cursor-size 2>/dev/null | string trim)

if test "$current_theme" != "$wanted_theme"
    gsettings set org.gnome.desktop.interface cursor-theme "$wanted_theme"
end

if test "$current_size" != "$wanted_size"
    gsettings set org.gnome.desktop.interface cursor-size $wanted_size
end
