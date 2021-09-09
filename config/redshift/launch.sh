#!/usr/bin/env bash
LOC="$HOME/.config/locations/current"
LOCSTRING=$(cat "$LOC")
if [ -n "$LOCSTRING" ]; then
    killall -u $USER redshift >/dev/null 2>&1 && \
	while ps u -C redshift >/dev/null 2>&1; do
	    read -t 1 <> <(:)
	done

    redshift -x
    redshift -l $LOCSTRING
else
    echo "No location found at \`$LOC\'"
    exit 1
fi
