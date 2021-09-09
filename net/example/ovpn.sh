#!/usr/bin/env bash
LASTDIR=$(pwd)
BASEDIR=$(dirname $(realpath $0))
CONF="$BASEDIR/client.ovpn"
CR="$BASEDIR/cr.asc"
CR_DEC="$BASEDIR/cr.tmp"
NAME="$BASEDIR/key.name"

cleanup() {
    rm -f "$CR_DEC"
    cd "$LASTDIR"
    [ $(($1)) -gt 0 ] && exit $1 || exit
}

run() {
    $@ || cleanup
}

trap cleanup SIGINT SIGQUIT SIGABRT SIGKILL
run gpg --decrypt -o "$CR_DEC" -r $(cat "$NAME") "$CR" && chmod 600 "$CR_DEC"
run cd "$BASEDIR" && openvpn "$CONF"
cleanup
