#!/usr/bin/env bash

# Dotfiles installation script
# Dependencies:
#	bash >= 4.x.x
#	GNU coreutils
#	git

DESKTOP_THEME_GIT="https://github.com/vinceliuice/ChromeOS-theme"
CURSOR_THEME_BIN="https://github.com/ful1e5/apple_cursor/releases/latest/download/macOSBigSur.tar.gz"
LOCKER_GIT="https://github.com/rainbowgoth/sxlock"
FF_THEME_GIT="https://github.com/muckSponge/MaterialFox"
TPM="https://github.com/tmux-plugins/tpm"

input() {
	local -n ref=$2
	printf "$1"
	read ref
}

copy() {
	if [ ! -d "${XDG_CONFIG_HOME-}" ] ; then
		export XDG_CONFIG_HOME="$HOME"/.config
		mkdir -p "$XDG_CONFIG_HOME"
	fi
	cp -R config/* "$XDG_CONFIG_HOME"
	
	mkdir -p "$HOME"/scripts
	cp -R scripts/* "$HOME"/scripts
	
	mkdir -p "$HOME"/Pictures
	cp -R images/bg "$HOME"/Pictures/Wallpaper
	
	mkdir -p "$HOME"/.local/share/fonts
	cp -R fonts/* "$HOME"/.local/share/fonts

	for file in shell/* X/*; do
		cp "$file" "$HOME/.$(basename $file)"
	done
	
	chmod +x "$HOME"/scripts/*
}

post_copy() {
	input "Set the default wallpaper now? (Y/n) " res
	if [ -n "${DISPLAY-}" ] && [[ -z "$res" || "${res^^}" == 'Y' ]]; then
		scripts/theme/setbg "$HOME"/Pictures/Wallpaper/default
	fi
	
	fc-cache -f
	"$HOME"/scripts/update-scripts
}

install_themes() {
	ROOTDIR=$(pwd)
	TMPDIR=desktop-theme
	
	git clone "$DESKTOP_THEME_GIT" "$TMPDIR"
	if [ -d "$TMPDIR" ]; then
		cd "$TMPDIR" 	    && \
		./install.sh
		cd "$ROOTDIR"	    && \
		rm -rf "$TMPDIR"
	fi

	mkdir -p "$HOME"/.themes
	cp -R themes/* "$HOME"/.themes

	mkdir -p "$HOME"/.icons
	curl -L -o cursors.tar.gz "$CURSOR_THEME_BIN" && \
	tar -xzf cursors.tar.gz && \
	mv macOSBigSur ~/.icons
	rm -f cursors.tar.gz
}

install_tmux_conf() {
	if [ -d "$XDG_CONFIG_HOME"/tmux ]; then
		ln -s "$XDG_CONFIG_HOME"/tmux "$HOME"/.tmux
		ln -s "$XDG_CONFIG_HOME"/tmux/tmux.conf "$HOME"/.tmux.conf
	fi

	git clone "$TPM" "$HOME"/.tmux/plugins/tpm && \
	echo -e "\n** Type <Prefix> Shift+I in tmux to install the provided themes/packages. **" \
			"\n(Default prefix for this config is M-a [Alt+A])"
}

install_locker() {
    ROOTDIR=$(pwd)
    TMPDIR=locker

    git clone "$LOCKER_GIT" "$TMPDIR"
    if [ -d "$TMPDIR" ]; then
        cd "$TMPDIR" 	    && \
        make && sudo make install
        cd "$ROOTDIR"		&& \
        rm -rf "$TMPDIR"
    fi
}

install_services() {
    SCTL=$(which systemctl) \
        || (echo "No systemd executable in path"; return 1)
    $SCTL enable --user env-metadata.service

    sudo cp config/systemd/userthemes@.service /etc/systemd/system/usethemes@.service && \
    sudo $SCTL enable userthemes@${SUDO_USER}.service
}

firefox_config() {
	FFROOT="$HOME"/.mozilla/firefox
	
	if [ -d "$FFROOT" ]; then
		LAST_PWD=$(pwd)
		FF_FILES=$(ls "$HOME"/.mozilla/firefox)

		cd "$FFROOT" && \
		profiles=$(find ./ -type d -name "*.default-release")
		
		if [ -n $profiles ]; then
			for profile in $profiles; do
				cp "$LAST_PWD"/firefox/user.js "./$profile"
			done

			echo -e "\n[* Pre-Firefox 89 only *] Install the MaterialFox theme by muckSponge?" \
					"\nDo not use this with current versions of Firefox as old-style theming is broken."
			
			input "(y/N) " res
			if [ "$res" == "y" ]; then
				if [ -d ./materialfox  ]; then
					echo "Using existing MaterialFox clone"
				else
					git clone "$FF_THEME_GIT" ./materialfox
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

	echo -e "\nInstall the desktop and cursor themes (GTK+, etc.)?" \
			"\nThis requires the GTK Murrine engine for your distro (gtk-engine-murrine for Arch)."
	input "(y/N) " res
	if [ "$res" == "y" ]; then
		echo "Installing desktop themes..."
		install_themes
	fi

	echo -e "\nInstall the recommended screen locker? (sxlock fork)"
    input "(y/N) " res
    if [ "$res" == "y" ]; then
        echo "Installing screen locker..."
        install_locker
    fi

	echo -e "\nInstall tmux and TPM configuration?"
	input "(y/N) " res
	if [ "$res" == "y" ]; then
		echo "Installing tmux configuration..."
		install_tmux_conf
	fi

	echo -e "\nInstall the recommended root systemd services? (Required for automatic theming after suspend)"
	input "(y/N) " res
	if [ "$res" == "y" ]; then
        echo "Installing systemd services..."
        install_services
	fi

	echo -e "\nInstall Firefox configuration?" \
			"\nNote: This will overwrite the Firefox \"user.js\" and \"chrome\" directory files."
	input "(y/N) " res
	if [ "$res" == "y" ]; then
		echo "Installing Firefox configuration..."
		firefox_config
	fi

	echo -e "\n** Installed dotfiles. **" \
            "\nRestart your shell to launch into a usable state." \
			"\nRun \`setbg <path to image>\` to change your desktop background." \
			"\nYou may also now use a tool such as lxappearance to customise GTK and other theming options <3"
}

echo -e "** Linux dotfiles configuration script **
Make sure that you have read the readme and installed the required dependencies.
This script should only be run from the repository root.

The script **will** overwrite various configuration files,
so please don't proceed if you have any configurations that you have not backed up.
"

input "Proceed to installation? (y/N) " res
if [ "$res" == "y" ]; then
	install_config
	exit $?
else
	echo "No changes made. Exiting..."
	exit 0
fi
