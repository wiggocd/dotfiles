#!/usr/bin/env bash
COM="picom --config "$HOME/.config/picom/picom.conf" --backend glx"
[ "$VSYNC" == false ] && $COM || $COM --vsync
