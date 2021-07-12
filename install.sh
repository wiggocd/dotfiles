#!/usr/bin/env bash

# Dotfiles installation script
# Dependencies:
#	bash >= 4.x.x
#	GNU coreutils
#	git

DESKTOP_THEME="https://github.com/vinceliuice/ChromeOS-theme"
FF_THEME="https://github.com/muckSponge/MaterialFox"
TPM="https://github.com/tmux-plugins/tpm"

chkdir() {
	[ -d "$1" ] || mkdir -p "$1"
}

input() {
	local -n ref=$2
	printf "$1"
	read ref
}

copy() {
	if [ ! -d "$XDG_CONFIG_HOME" ] || [ ! -n "${XDG_CONFIG_HOME-}" ] ; then
		export XDG_CONFIG_HOME="$HOME"/.config
		mkdir -p "$XDG_CONFIG_HOME"
	fi
	cp -R config/* "$XDG_CONFIG_HOME"
	
	chkdir "$HOME"/scripts
	cp -R scripts/* "$HOME"/scripts
	
	chkdir "$HOME"/Pictures
	cp -R images/bg "$HOME"/Pictures/Wallpaper
	
	chkdir "$HOME"/.local/share/fonts
	cp -R fonts/* "$HOME"/.local/share/fonts

	for file in shell/*; do
		cp "$file" "$HOME/.$(basename $file)"
	done
	
	chmod +x "$HOME"/scripts/*
}

post_copy() {
	input "Set the default wallpaper? (Y/n) " res
	if [ -z "$res" ] || [ "${res^^}" == 'Y' ]; then
		scripts/setbg "$HOME"/Pictures/Wallpaper/default
	fi
	
	fc-cache -f
}

install_themes() {
	ROOTDIR=$(pwd)
	TMPDIR=desktop-theme
	
	git clone "$DESKTOP_THEME" "$TMPDIR"
	if [ -d ./desktop-theme ]; then
		cd ./desktop-theme 	&& \
		./install.sh
		cd "$ROOTDIR"		&& \
		rm -rf "$TMPDIR"
	fi

	chkdir "$HOME"/.themes
	cp -R themes/* "$HOME"/.themes
}

install_tmux_conf() {
	if [[ -d "$XDG_CONFIG_HOME"/tmux ]]; then
		ln -s "$XDG_CONFIG_HOME"/tmux "$HOME"/.tmux
		ln -s "$XDG_CONFIG_HOME"/tmux/tmux.conf "$HOME"/.tmux.conf
	fi

	git clone "$TPM" "$HOME"/.tmux/plugins/tpm && \
	echo -e "\n** Type <Prefix> Shift+I in tmux to install the provided themes/packages. **" \
			"\n(Default prefix for this config is M-a [Alt+A])"
}

firefox_config() {
	FFROOT="$HOME"/.mozilla/firefox
	
	if [ -d "$FFROOT" ]; then
		ROOTFIR=$(pwd)
		FF_FILES=$(ls "$HOME"/.mozilla/firefox)

		cd "$FFROOT" && \
		profiles=$(find ./ -type d -name "*.default-release")
		
		if [ -n $profiles ]; then
			for profile in $profiles; do
				cp "$ROOTDIR"/firefox/user.js "./$profile"
			done

			echo -e "\n[- Pre-Firefox 89 only -] Install the MaterialFox theme by muckSponge?" \
					"\nDo not use this with current versions of Firefox as old-style theming is broken."
			
			input "(y/N) " res
			if [ "$res" == "y" ]; then
				if [ -d ./materialfox  ]; then
					echo "Using existing MaterialFox clone"
				else
					git clone "$FF_THEME" ./materialfox
				fi
				
				if [ -d ./materialfox/chrome ]; then
					for profile in $profiles; do
						cp -R ./materialfox/chrome "./$profile"
					done
				else
					echo "Skipping MaterialFox installation"
				fi
			else
				echo "Skipping MaterialFox installation"
			fi
		else
			echo "No suitable Firefox profiles found."
		fi

		cd "$ROOTDIR"
	else
		echo "Firefox config directory \"$FFROOT\" not found."
	fi
}

install_config() {
	echo -e "\nInstalling; this may take some time..."

	copy && post_copy

	echo -e "\nInstall the desktop themes (GTK+, etc.)?" \
			"\nThis requires the GTK Murrine engine for your distro (gtk-engine-murrine for Arch)."
	input "(y/N) " res
	if [ "$res" == "y" ]; then
		echo "Installing desktop themes..."
		install_themes
	fi

	echo -e "\nInstall tmux and TPM configuration?"
	input "(y/N) " res
	if [ "$res" == "y" ]; then
		echo "Installing tmux configuration..."
		install_tmux_conf
	fi

	echo -e "\nInstall Firefox configuration?" \
			"\nNote: This will overwrite the Firefox \"user.js\" and \"chrome\" directory files."
	input "(y/N) " res
	if [ "$res" == "y" ]; then
		echo "Installing Firefox configuration..."
		firefox_config
	fi

	echo -e "\n** Installed dotfiles. **" \
			"\nRun \`setbg <path to image>\` to change your desktop background." \
			"\nYou may also now use a tool such as lxappearance to customise GTK and other theming options <3"
}

echo -e <<-EOF "** Linux dotfiles configuration script **
Make sure that you have read the readme and installed the required dependencies.
This script should only be run from the repository root.

The script **will** overwrite various configuration files,
so please don't proceed if you have any configurations that you have not backed up."
EOF

input "Proceed to installation? (y/N) " res
if [ "$res" == "y" ]; then
	install_config
	exit $?
else
	echo "No changes made. Exiting..."
	exit 0
fi
