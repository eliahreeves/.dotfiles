#!/usr/bin/env bash

if pgrep -x "wlogout" >/dev/null; then
	pkill -x "wlogout"
else
	ROWS=$(grep -c "{" "$HOME/.config/wlogout/layout")
	wlogout -b "$ROWS"
fi
