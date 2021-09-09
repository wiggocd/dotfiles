#!/usr/bin/env bash
PROCS=$(pgrep -u $USER "polybar")
if [ -n "$PROCS" ]; then
    kill -9 $PROCS
    while pgrep -u $USER "polybar" >/dev/null 2>&1; do
	read -t 0.5 <> <(:)
    done
fi

polybar -q main -c "$HOME/.config/polybar/config.ini"
