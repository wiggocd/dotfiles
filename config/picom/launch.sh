#!/usr/bin/env bash
COM="picom --config "$HOME/.config/picom/picom.conf" --backend glx"
! ps u -C picom >/dev/null 2>&1 || killall -u $USER picom
[ "$VSYNC" == false ] && $COM || $COM --vsync
