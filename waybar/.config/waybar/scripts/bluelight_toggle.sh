#!/usr/bin/env bash

STATUS_FILE="/tmp/bluelight.status"

# check current status
if [ ! -f "$STATUS_FILE" ]; then
	echo " "
	exit
fi

status=$(cat "$STATUS_FILE")

if [ "$status" == " " ]; then
	echo " "
else
	echo " "
fi
