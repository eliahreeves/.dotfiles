#!/usr/bin/env bash
STATUS_FILE="/tmp/bluelight.status"
if [ -f "$STATUS_FILE" ] && [ "$(cat $STATUS_FILE)" == " " ]; then
	sleep 1
	hyprctl hyprsunset temperature 2600 >/dev/null
fi
