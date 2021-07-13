# Dotfiles

Configuration for Arch Linux

## Screenshots

![Primary](images/screenshot-1.png)

## Details

**OS** [GNU](https://www.gnu.org)/[Linux](https://github.com/torvalds/linux)

**Distro** [Arch Linux](https://archlinux.org)

**WM** [i3-gaps](https://github.com/Airblader/i3)

**Compositor** [picom-ibhagwan](https://aur.archlinux.org/packages/picom-ibhagwan-git)

**Bar** [polybar](https://github.com/polybar/polybar), [original theme by adi1090x](https://github.com/adi1090x/polybar-themes) (modified)

**Launcher** [rofi](https://github.com/davatorium/rofi), [theme by adi1090x](https://github.com/adi1090x/rofi)

**Terminal Emulators** [alacritty](https://github.com/alacritty/alacritty), [kitty](https://github.com/kovidgoyal/kitty)

**Shell** [zsh](https://www.zsh.org)

**Shell Theme** [grml-zsh-config](https://github.com/grml/grml-etc-core), [powerlevel10k](https://github.com/romkatv/powerlevel10k)

**AUR Helper** [pikaur](https://github.com/actionless/pikaur)

**Text Editors** [micro](https://github.com/zyedidia/micro), [vim](https://github.com/vim/vim), [code](https://github.com/microsoft/vscode)

**Monospace Fonts** [GohuFont](https://github.com/hchargois/gohufont), [MesloLGS NF](https://github.com/ryanoasis/nerd-fonts), [Droid Sans Mono](https://fonts.adobe.com/fonts/droid-sans)) [Terminus](http://terminus-font.sourceforge.net/)

**UI Fonts** [Droid Sans 11pt](https://fonts.adobe.com/fonts/droid-sans)

**Browser** [Firefox](https://hg.mozilla.org/mozilla-central/)

**GTK Theme** [ChromeOS-light-compact](https://github.com/vinceliuice/ChromeOS-theme)

**Icon Theme** [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)

**Cursor Theme** [Apple Cursor](https://github.com/ful1e5/apple_cursor)

**Music Player** [mpd](https://github.com/MusicPlayerDaemon/MPD) + [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)

## Dependencies and Packages

All packages are listed assuming acces to the main/extra Arch Linux repos and Arch User Repository

**Dependencies**

`bash coreutils git curl tar i3-gaps rofi picom-ibhagwan-git polybar fontconfig feh`

**Recommended packages**

`sudo pikaur zsh autotiling alacritty kitty tmux firefox vim micro ttf-droid grml-zsh-config lxappearance physlock xorg-xset xss-lock xorg-xbacklight redshift-gtk autorandr zsh-theme-powerlevel10k-git papirus-icon-theme`

**Other packages, including programs and utilities used**

`lxsession libinput-gestures xorg-xrandr visual-studio-code-bin mpd mpd-mpris mpc ncmpcpp pulseaudio pavucontrol networkmanager libqalculate`

## Installation

- Feel free to copy the files manually, where `config` maps to `$XDG_CONFIG_HOME` and `scripts` maps to `$HOME/scripts`, etc...

*or* keeping in mind that configurations **will** be overwritten

- Run `./install.sh` to install the configuration files automatically

## Tested Versions

- OS
	- Arch Linux x86_64 5.12.14
- Packages
	- See `VERSIONS`

## Documentation

To use this for your own desktop configuration, there are some useful scripts in the `dev` directory:

- `getversions`
	- Read pacman package versions for a specified list of packages into a file
- `testenv`
	- Start a new shell with a clean environment to test the dotfiles scripts

Enjoy! <3