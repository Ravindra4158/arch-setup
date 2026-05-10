#!/usr/bin/env fish

set -g _state $HOME/.local/state/caelestia/wallpaper
set -g _current $_state/current
set -g _path_file $_state/path.txt
set -g _log $_state/settings-sync.log
set -g _last_applied ''
set -g _last_backend ''

function _log_msg -a text
    mkdir -p $_state
    printf '%s %s\n' (date '+%Y-%m-%d %H:%M:%S') "$text" >> $_log
end

function _uri_to_path -a uri
    set uri (string trim -- $uri | string replace -r "^'(.*)'\$" '$1')

    if ! string match -q 'file://*' -- $uri
        return 1
    end

    set -l path (string replace -r '^file://' '' -- $uri)

    if string match -q '*%*' -- $path
        string unescape --style=url -- $path 2>/dev/null
    else
        echo $path
    end
end

function _background_path
    for key in picture-uri-dark picture-uri
        set -l uri (gsettings get org.gnome.desktop.background $key 2>/dev/null)
        set -l path (_uri_to_path "$uri")

        if test -n "$path" -a -e "$path"
            realpath "$path"
            return 0
        end
    end

    return 1
end

function _caelestia_path
    if test -f $_path_file
        set -l path (string trim -- (cat $_path_file 2>/dev/null))

        if test -n "$path" -a -e "$path"
            if string match -q '*/wallpaper/disc.png' -- "$path"
                set -l gif ~/Wall-E-Desk/Pixel-Art/disc.gif

                if test -e "$gif"
                    realpath "$gif"
                    return 0
                end
            end

            realpath "$path"
            return 0
        end
    end

    if test -e $_current
        set -l path (realpath $_current 2>/dev/null)

        if test -n "$path" -a -e "$path"
            echo "$path"
            return 0
        end
    end

    return 1
end

function _stop_wallpaper_backends
    if command -q mpvpaper
        pkill -x mpvpaper >/dev/null 2>&1
    end

    if command -q hyprctl; and command -q hyprpaper
        hyprctl hyprpaper unload all >/dev/null 2>&1
    end
end

function _start_wallpaper_backend -a path
    if command -q mpvpaper
        if test "$_last_backend" != 'mpvpaper'
            _stop_wallpaper_backends
        end

        set -g _last_backend 'mpvpaper'
        pkill -x mpvpaper >/dev/null 2>&1
        mpvpaper -o 'no-audio loop-file=inf' '*' "$path" >/dev/null 2>&1 &
        return $status
    end

    if command -q hyprctl; and command -q hyprpaper
        if test "$_last_backend" != 'hyprpaper'
            _stop_wallpaper_backends
        end

        set -g _last_backend 'hyprpaper'
        hyprctl hyprpaper preload "$path" >/dev/null 2>&1

        if test $status -ne 0
            _log_msg "hyprpaper could not preload: $path"
            return 1
        end

        hyprctl hyprpaper wallpaper ",$path" >/dev/null 2>&1

        if test $status -ne 0
            _log_msg "hyprpaper could not apply: $path"
            return 1
        end

        return 0
    end

    _log_msg 'no wallpaper backend found: install mpvpaper or hyprpaper'
    return 1
end

function _event_path -a event
    if ! string match -rq '^picture-uri(-dark)?:' -- $event
        return 1
    end

    set -l uri (string replace -r '^[^:]+:\s*' '' -- $event)
    set -l path (_uri_to_path "$uri")

    if test -n "$path" -a -e "$path"
        realpath "$path"
        return 0
    end

    return 1
end

function _apply_wallpaper -a path
    mkdir -p $_state

    set -l resolved (realpath "$path" 2>/dev/null)

    if test -z "$resolved"
        _log_msg "missing wallpaper: $path"
        return 1
    end

    if test "$_last_applied" = "$resolved"
        return 0
    end

    _start_wallpaper_backend "$resolved"

    ln -sf "$resolved" $_current; or return 1
    printf '%s' "$resolved" > $_path_file; or return 1
    set -g _last_applied "$resolved"
    _log_msg "applied: $resolved"
end

if ! command -q gsettings
    _log_msg 'gsettings is required to sync wallpapers from Settings.'
    exit 1
end

set -l initial_path (_caelestia_path)

if test -z "$initial_path"
    set initial_path (_background_path)
end

if test -n "$initial_path"
    _apply_wallpaper "$initial_path"
    set -l initial_status $status
else
    set -l initial_status 1
end

if test "$argv[1]" = '--once'
    exit $initial_status
end

gsettings monitor org.gnome.desktop.background | while read -l _event
    if ! string match -rq '^picture-uri(-dark)?:' -- $_event
        continue
    end

    set -l path (_event_path "$_event")

    if test -z "$path"
        set path (_background_path)
    end

    if test -n "$path"
        _apply_wallpaper "$path"
    end
end &

if command -q inotifywait
    inotifywait -m -q -e close_write,create,moved_to,attrib $_state | while read -l _dir _events _file
        if contains -- "$_file" path.txt current
            set -l path (_caelestia_path)

            if test -n "$path"
                _apply_wallpaper "$path"
            end
        end
    end
else
    wait
end
