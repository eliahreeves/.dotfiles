#!/usr/bin/env bash

if pgrep -x "rofi" >/dev/null; then
	pkill -x "rofi"
else
	rofi -show drun -theme ~/.dotfiles/rofi/theme.rasi
fi
