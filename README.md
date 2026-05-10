# caelestia

Caelestia dotfiles for an Arch/Hyprland desktop. This repository contains
configs for Hyprland, Caelestia Shell, fish, kitty, foot, fastfetch, btop,
Thunar, Zed, VS Code/VSCodium, Zen Browser, Firefox, Spicetify, and related
desktop integration.

The main installer is [`install.fish`](install.fish). It installs the local
Arch metapackage from [`PKGBUILD`](PKGBUILD), then symlinks this repository's
configs into your XDG config directory.

## Quick install

> [!WARNING]
> The installer creates symlinks into this repository. Keep the repository in a
> permanent location after installing. If you move or delete it, the linked app
> configs will break. A good location is `~/.local/share/caelestia`.

```sh
git clone https://github.com/ravindra4158/arch-setup.git ~/.local/share/arch-setup
cd ~/.local/share/caelestia
./install.fish --aur-helper=paru
```

If you already cloned this repo and are inside it:

```sh
./install.fish --aur-helper=paru
```

Install useful runtime packages used by this config:

```sh
paru -S --needed nemo google-chrome gnome-keyring polkit-gnome gnome-control-center uwsm hyprpaper mpvpaper pavucontrol qps gammastep geoclue bluez-utils libnotify
```

## Installer options

```text
usage: ./install.fish [-h] [--noconfirm] [--spotify] [--vscode] [--discord] [--zen] [--aur-helper]

options:
  -h, --help                  show help and exit
  --noconfirm                 do not confirm package installation
  --spotify                   install Spotify and Spicetify config
  --vscode=[codium|code]      install VSCodium or VS Code config
  --discord                   install Discord with OpenAsar and Equicord
  --zen                       install Zen Browser config and native app
  --aur-helper=[yay|paru]     AUR helper to use, defaults to paru
```

Example with extras:

```sh
./install.fish --aur-helper=paru --spotify --vscode=code --discord --zen
```

> [!NOTE]
> `--vscode=code` installs the Arch/AUR `code` package. If you already use
> `visual-studio-code-bin`, you may prefer to install the VSIX manually instead
> of using that flag.

## What the installer does

- Prompts you to back up `$XDG_CONFIG_HOME`, usually `~/.config`.
- Installs `paru` or `yay` if the selected helper is missing.
- Builds and installs the local `caelestia-meta` package.
- Symlinks these configs into `$XDG_CONFIG_HOME`:
  - `hypr -> ~/.config/hypr`
  - `kitty -> ~/.config/kitty`
  - `fish -> ~/.config/fish`
  - `fastfetch -> ~/.config/fastfetch`
  - `uwsm -> ~/.config/uwsm`
  - `btop -> ~/.config/btop`
  - `starship.toml -> ~/.config/starship.toml`
- Creates `~/Desktop`.
- Creates Caelestia state/config files when needed:
  - `~/.config/caelestia/hypr-vars.conf`
  - `~/.config/caelestia/hypr-user.conf`
  - `~/.local/state/caelestia/scheme.json`
  - `~/.local/state/caelestia/wallpaper/current`
- Starts/restarts the Caelestia shell.

## Dependencies

The local metapackage requires:

| Package | Purpose |
| --- | --- |
| `caelestia-cli` | Caelestia command line tools |
| `caelestia-shell` | Caelestia shell, panels, drawers, actions |
| `hyprland` | Wayland compositor |
| `xdg-desktop-portal-hyprland` | Hyprland portal integration |
| `xdg-desktop-portal-gtk` | GTK portal dialogs |
| `hyprpicker` | Color picker |
| `wl-clipboard` | Wayland clipboard tools |
| `cliphist` | Clipboard history |
| `inotify-tools` | File watching helpers |
| `app2unit` | Launch apps under systemd user units |
| `wireplumber` | PipeWire session manager |
| `trash-cli` | Trash cleanup |
| `kitty` | Main terminal |
| `hyprlock` | Lock screen |
| `dolphin` | Main file manager |
| `fish` | Shell |
| `eza` | Better `ls` |
| `fastfetch` | System info |
| `starship` | Shell prompt |
| `btop` | System monitor |
| `jq` | JSON processing |
| `adw-gtk-theme` | GTK theme |
| `papirus-icon-theme` | Icon theme |
| `qtengine-git` | Qt theme integration |
| `ttf-jetbrains-mono-nerd` | Nerd Font |

Optional packages referenced by the configs:

| Package | Used by |
| --- | --- |
| `nemo` | Desktop icons and `Super+Alt+E` |
| `google-chrome` | Default browser command is `google-chrome-stable` |
| `code` or `visual-studio-code-bin` | Default editor command is `code` |
| `uwsm` | Systemd-managed Wayland session |
| `hyprpaper` | Wallpaper fallback for static images |
| `mpvpaper` | Animated wallpaper playback for GIFs and video |
| `gnome-keyring` | Secrets/keyring daemon at login |
| `polkit-gnome` | Polkit authentication agent |
| `pavucontrol` | `Ctrl+Alt+V` audio mixer shortcut |
| `qps` | `Ctrl+Alt+Escape` process manager shortcut |
| `gammastep` | Delayed background color temperature service |
| `geoclue` | Location agent for Gammastep |
| `bluez-utils` | Provides `mpris-proxy` for media integration |
| `libnotify` | Provides `notify-send` for notification testing |
| `spotify` or Flatpak Spotify | Music shortcut and Spicetify integration |
| `discord` | Communication special workspace |
| `github-desktop` | `Super+G` shortcut |
| `todoist-appimage` | Todo special workspace |
| `direnv` | Optional fish integration |
| `zoxide` | Optional fish `cd` integration |
| `rofi` | `Super+D` launcher command expects a rofi script |
| `fuzzel` | Clipboard/emoji picker kill-toggle command |
| `ydotool` | Alternate paste shortcut |

## Included configs

The installer always links the core session configs: `hypr`, `kitty`, `fish`,
`fastfetch`, `rofi`, `uwsm`, `btop`, and `starship.toml`.

Other configs are included for manual or optional use:

| Path | Purpose |
| --- | --- |
| `foot/foot.ini` | Foot terminal config |
| `thunar/` | Thunar custom actions and volume manager config |
| `zed/` | Zed settings and keymap |
| `vscode/` | VS Code/VSCodium settings, flags, keybindings, and theme extension |
| `zen/` | Zen Browser userChrome, native app, and CaelestiaFox extension source |
| `firefox/` | Firefox userChrome CSS |
| `micro/` | Micro editor settings |
| `spicetify/` | Spotify/Spicetify theme |

## App defaults

These are defined in [`hypr/variables.conf`](hypr/variables.conf):

| Role | Command |
| --- | --- |
| Terminal | `kitty` |
| Browser | `google-chrome-stable` |
| Editor | `code` |
| File manager | `dolphin` |
| Settings | `gnome-control-center background` |
| Cursor theme | `sweet-cursors` |
| Cursor size | `24` |
| Volume step | `10%` |

Override defaults in `~/.config/caelestia/hypr-vars.conf`. Add personal Hyprland
rules or monitors in `~/.config/caelestia/hypr-user.conf`.

## Startup behavior

Hyprland starts:

- `gnome-keyring-daemon --start --components=secrets`
- `/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1`
- Wallpaper changes from Caelestia Appearance/GNOME Settings are synced by
  `hypr/scripts/wallpaper-settings-sync.fish`.
- `caelestia shell -d`
- `caelestia resizer -d`
- `wl-paste` watchers for text and image clipboard history
- Cursor sync with `hyprctl setcursor`
- Delayed background services from `hypr/scripts/background-services.fish`

Delayed services:

- Geoclue demo agent
- `gammastep`
- `nemo-desktop`, if installed
- `mpris-proxy`
- `trash-empty 30`

## Shortcuts

`Super` means the Windows/Command key.

### Shell and session

| Shortcut | Action |
| --- | --- |
| `Super+D` | Toggle rofi launcher script at `~/.config/rofi/scripts/launcher_t2` |
| `Ctrl+Alt+Delete` | Open Caelestia session menu |
| `Super+N` | Show sidebar |
| `Ctrl+Alt+C` | Clear notifications |
| `Super+K` | Show all Caelestia panels |
| `Super+L` | Lock screen |
| `Super+Alt+L` | Restart shell and lock |
| `Ctrl+Super+Shift+R` | Kill Caelestia shell |
| `Ctrl+Super+Alt+R` | Restart Caelestia shell |

### Apps

| Shortcut | Action |
| --- | --- |
| `Super+Q` | Open terminal, `kitty` |
| `Super+W` | Open browser, `google-chrome-stable` |
| `Super+V` | Open editor, `code` |
| `Super+E` | Open file manager, `dolphin` |
| `Super+I` | Open Settings directly to wallpaper/background choices |
| `Super+Alt+E` | Open `nemo` |
| `Super+M` | Open Spotify Flatpak, `com.spotify.Client` |
| `Super+G` | Open GitHub Desktop |
| `Ctrl+Alt+Escape` | Open `qps` |
| `Ctrl+Alt+V` | Open `pavucontrol` |

### Workspaces

| Shortcut | Action |
| --- | --- |
| `Super+1..9` | Go to workspace 1 through 9 |
| `Super+0` | Go to workspace 10 |
| `Ctrl+Super+1..9` | Go to workspace group 1 through 9 |
| `Ctrl+Super+0` | Go to workspace group 10 |
| `Super+Mouse Wheel` | Previous/next workspace |
| `Super+Page Up` | Previous workspace |
| `Super+Page Down` | Next workspace |
| `Ctrl+Super+Mouse Wheel` | Previous/next workspace group |
| `Super+S` | Toggle special workspace |

### Move windows between workspaces

| Shortcut | Action |
| --- | --- |
| `Super+Alt+1..9` | Move window to workspace 1 through 9 |
| `Super+Alt+0` | Move window to workspace 10 |
| `Ctrl+Super+Alt+1..9` | Move window to workspace group 1 through 9 |
| `Ctrl+Super+Alt+0` | Move window to workspace group 10 |
| `Super+Alt+Page Up` | Move window to previous workspace |
| `Super+Alt+Page Down` | Move window to next workspace |
| `Super+Alt+Mouse Wheel` | Move window to previous/next workspace |
| `Ctrl+Super+Shift+Left` | Move window to previous workspace |
| `Ctrl+Super+Shift+Right` | Move window to next workspace |
| `Ctrl+Super+Shift+Up` | Move window to special workspace |
| `Ctrl+Super+Shift+Down` | Move window back to current workspace |
| `Super+Alt+S` | Move window to special workspace |

### Special workspaces

| Shortcut | Action |
| --- | --- |
| `Ctrl+Shift+Escape` | Toggle system monitor workspace |
| `Ctrl+Super+M` | Toggle music workspace |
| `Super+Alt+D` | Toggle communication workspace |
| `Super+R` | Toggle todo workspace |

### Window groups

| Shortcut | Action |
| --- | --- |
| `Alt+Tab` | Cycle to next window in group |
| `Shift+Alt+Tab` | Cycle to previous window in group |
| `Ctrl+Alt+Tab` | Change active grouped window forward |
| `Ctrl+Shift+Alt+Tab` | Change active grouped window backward |
| `Super+Comma` | Toggle window group |
| `Super+U` | Move window out of group |
| `Super+Shift+Comma` | Toggle active group lock |

### Window control

| Shortcut | Action |
| --- | --- |
| `Super+Arrow` | Move focus |
| `Super+Shift+Arrow` | Move window |
| `Super+-` | Resize active window narrower |
| `Super+=` | Resize active window wider |
| `Super+Shift+-` | Resize active window shorter |
| `Super+Shift+=` | Resize active window taller |
| `Super+Alt+Arrow` | Resize active window by direction |
| `Super+Left Mouse` | Move window |
| `Super+Z` | Move window drag bind |
| `Super+Right Mouse` | Resize window |
| `Super+X` | Resize window drag bind |
| `Ctrl+Super+Backslash` | Center window |
| `Ctrl+Super+Alt+Backslash` | Resize window to `55% 70%` and center it |
| `Super+Alt+Backslash` | Move window to picture-in-picture mode |
| `Super+P` | Pin window |
| `Super+F` | Fullscreen |
| `Super+Alt+F` | Bordered fullscreen |
| `Super+Alt+Space` | Toggle floating |
| `Super+C` | Close active window |

### Screenshots, recording, and tools

| Shortcut | Action |
| --- | --- |
| `Print` | Full screenshot to clipboard |
| `Super+Shift+S` | Region screenshot with freeze |
| `Super+Shift+Alt+S` | Region screenshot |
| `Super+Alt+R` | Screen record with sound |
| `Ctrl+Alt+R` | Screen record |
| `Super+Shift+Alt+R` | Region record |
| `Super+Shift+C` | Color picker |

### Media, volume, clipboard

| Shortcut | Action |
| --- | --- |
| `XF86MonBrightnessUp` | Brightness up |
| `XF86MonBrightnessDown` | Brightness down |
| `Ctrl+Super+Space` | Toggle media playback |
| `XF86AudioPlay` / `XF86AudioPause` | Toggle media playback |
| `Ctrl+Super+=` | Next media track |
| `XF86AudioNext` | Next media track |
| `Ctrl+Super+-` | Previous media track |
| `XF86AudioPrev` | Previous media track |
| `XF86AudioStop` | Stop media |
| `XF86AudioMicMute` | Toggle microphone mute |
| `XF86AudioMute` | Toggle output mute |
| `Super+Shift+M` | Toggle output mute |
| `XF86AudioRaiseVolume` | Raise volume by configured step |
| `XF86AudioLowerVolume` | Lower volume by configured step |
| `Super+Shift+L` | Suspend then hibernate |
| `Ctrl+Super+V` | Clipboard picker |
| `Super+Alt+V` | Clipboard delete picker |
| `Super+.` | Emoji picker |
| `Ctrl+Shift+Alt+V` | Type latest clipboard entry |
| `Super+Alt+F12` | Send a test notification |

### Touchpad gestures

| Gesture | Action |
| --- | --- |
| Four-finger horizontal swipe | Switch workspace |
| Three-finger swipe up | Show special workspace |
| Three-finger swipe down | Toggle Caelestia special workspace |
| Four-finger swipe down | Suspend then hibernate |

## Manual installation

Install the required packages and the Caelestia CLI/shell, then symlink configs:

```sh
ln -s "$(realpath hypr)" ~/.config/hypr
ln -s "$(realpath kitty)" ~/.config/kitty
ln -s "$(realpath fish)" ~/.config/fish
ln -s "$(realpath fastfetch)" ~/.config/fastfetch
ln -s "$(realpath rofi)" ~/.config/rofi
ln -s "$(realpath uwsm)" ~/.config/uwsm
ln -s "$(realpath btop)" ~/.config/btop
ln -s "$(realpath starship.toml)" ~/.config/starship.toml
```

The installer is preferred because it also handles packages, state files,
backups, optional app configs, and shell startup.

### Spicetify

```sh
paru -S --needed spotify spicetify-cli spicetify-marketplace-bin
ln -s "$(realpath spicetify)" ~/.config/spicetify
spicetify config current_theme caelestia color_scheme caelestia custom_apps marketplace
spicetify apply
```

### VS Code or VSCodium

Symlink:

- `vscode/settings.json` to `~/.config/Code/User/settings.json` or
  `~/.config/VSCodium/User/settings.json`
- `vscode/keybindings.json` to `~/.config/Code/User/keybindings.json` or
  `~/.config/VSCodium/User/keybindings.json`
- `vscode/flags.conf` to `~/.config/code-flags.conf` or
  `~/.config/codium-flags.conf`

Install the bundled extension:

```sh
code --install-extension vscode/caelestia-vscode-integration/caelestia-vscode-integration-*.vsix
```

Use `codium` instead of `code` for VSCodium.

### Zen Browser

Install `zen-browser-bin`, then symlink `zen/userChrome.css` into your Zen
profile's `chrome` directory.

The native app manifest goes to:

```text
~/.mozilla/native-messaging-hosts/caelestiafox.json
```

Replace `{{ $lib }}` in the manifest with the absolute path to:

```text
~/.local/lib/caelestia
```

Then symlink:

```text
zen/native_app/app.fish -> ~/.local/lib/caelestia/caelestiafox
```

Install the CaelestiaFox extension from Mozilla Add-ons.

## Updating

Update packages with your AUR helper, then pull the repo:

```sh
paru
cd ~/.local/share/caelestia
git pull
```

Because configs are symlinked, pulled changes apply immediately or after the
relevant app/session reload.

## Notes

- This repo does not install a login manager. Use your preferred one, or start
  Hyprland from TTY. `greetd` with `tuigreet` works well.
- The default wallpaper is the animated `~/Wall-E-Desk/Pixel-Art/disc.gif`.
  You can choose a new wallpaper directly from Settings > Appearance; the session
  syncs it to `~/.local/state/caelestia/wallpaper/current` for the wallpaper
  backend and Hyprlock.
- The Appearance wallpaper picker reads `~/Pictures/Wallpapers`. During setup,
  that path is linked to `~/Wall-E-Desk` when available, so all image folders
  there appear in Settings.
- `fish/config.fish` enables Starship, optional Direnv/Zoxide integration,
  `eza`-based `ls`, and git/navigation abbreviations.
- Personal fish config can live at `~/.config/caelestia/user-config.fish`.
