# Dotfiles

Configuration for Void Linux

## Screenshots

![Primary](images/screenshot-1.png)

## Details

**OS** [GNU](https://www.gnu.org)/[Linux](https://github.com/torvalds/linux)

**Distribution** [Void Linux](https://github.com/torvalds/linux)

**WM** [i3-gaps](https://github.com/Airblader/i3)

**Compositor** [picom](https://github.com/ibhagwan/picom)

**Bar** [polybar](https://github.com/polybar/polybar), [original theme by adi1090x](https://github.com/adi1090x/polybar-themes) (updated)

**Launcher** [rofi](https://github.com/davatorium/rofi), [original theme by adi1090x](https://github.com/adi1090x/rofi) (updated)

**Terminal Emulator** [alacritty](https://github.com/alacritty/alacritty)

**Shell** [zsh](https://www.zsh.org)

**Shell Theme** [grml-zsh-config](https://github.com/grml/grml-etc-core)

**Text Editors** [vim](https://github.com/vim/vim), [code](https://github.com/microsoft/vscode), [micro](https://github.com/zyedidia/micro)

**Monospace Fonts** [Terminus](http://terminus-font.sourceforge.net/), [Droid Sans Mono](https://fonts.adobe.com/fonts/droid-sans)

**UI Font** [Noto Sans Medium 10.5pt](https://github.com/googlefonts/noto-fonts)

**Browser** [Firefox](https://hg.mozilla.org/mozilla-central)

**GTK Theme** [ChromeOS-light-compact, ChromeOS-dark-compact (fork)](https://github.com/rainbowgoth/ChromeOS-theme)

**Icon Theme** [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

**Cursor Theme** [OpenZone](https://github.com/ducakar/openzone-cursors)

**Music Player** [mpd](https://github.com/MusicPlayerDaemon/MPD) + [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)

## Dependencies and Packages

See `PACKAGES` for the complete list.

All packages listed should be accessible from the main Void Linux repository.

## Installation

- `git submodule update`
- Run `./install` from the project root to install the configuration files automatically
    - *WARNING: Configuration files **will** be overwritten*

*(or feel free to copy files manually)*

## Tested Versions

- OS
    - Void GNU/Linux x86_64 5.13.15
- Packages
    - See `VERSIONS`

## Location and Privacy

For privacy protection, I block auto geolocation and spoof my location to the centre of the country in which I am currently located when necessary.

For redshift and theme scheduling to function correctly:
- Add any coordinates in your timezone to `~/.config/locations`
    - Format: `(-)LAT:(-)LONG`
- Create a symlink at `~/.config/locations/current` to your current approximated location

## Firefox

Static approximate location patches are required as stated above for Firefox autotheming to function.

Extensions:
- [automaticDark](https://github.com/skhzhang/time-based-themes) - automatic day/night themes
- [uBlock Origin](https://github.com/gorhill/uBlock#ublock-origin) - content blocker, with lighter sites whitelisted
- [Violentmonkey](https://github.com/violentmonkey/violentmonkey) - userscripts

## Documentation

### Repository Structure

- Primary
    - `home` - non-dotfiles to be transferred to dotfiles in the user's home directory
    - `config` - equivalent of `$XDG_CONFIG_HOME`
    - `scripts` - library of shell scripts to facilitate functionality of the desktop environment

- Secondary
    - `firefox`
    - `fonts`
    - `themes` - GTK and cursor themes and submodules for external repositories
    - `runit` - init scripts for Void Linux
    - `tmux`
    - `vim`
    - `images` - wallpaper, repository images
    - `packages` - external xbps-src packages
    - `archlinux` - backup configurations for the previous Arch-based configuration

### Maintenance

To use this for your own desktop configuration,  here are some other useful management scripts.
Configuration files are arranged in categorised subdirectories; hidden files in the home folder
(such as `.zshrc`) can be found in the `home` directory, etc. 

- `getversions`
	- Read package versions for a specified list of packages into a file
- `testenv`
	- Start a new shell with a clean environment to test the dotfiles scripts

Enjoy! <3
