#!/usr/bin/env bash

STATUS_FILE="/tmp/no-sleep.status"

if [ -f "$STATUS_FILE" ] && [ "$(cat $STATUS_FILE)" == "1" ]; then
	echo "0" >"$STATUS_FILE"
else
	echo "1" >"$STATUS_FILE"
fi

pkill -SIGRTMIN+11 waybar
