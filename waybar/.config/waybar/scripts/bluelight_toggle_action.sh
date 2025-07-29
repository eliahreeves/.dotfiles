#!/usr/bin/env bash

STATUS_FILE="/tmp/bluelight.status"

if [ -f "$STATUS_FILE" ] && [ "$(cat $STATUS_FILE)" == " " ]; then
	# turn it off
	hyprctl hyprsunset identity >/dev/null
	echo " " >"$STATUS_FILE"
else
	# turn it on
	hyprctl hyprsunset temperature 2600 >/dev/null
	echo " " >"$STATUS_FILE"
fi

pkill -SIGRTMIN+10 waybar
