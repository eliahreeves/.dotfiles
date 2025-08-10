#!/usr/bin/env bash

STATUS_FILE="/tmp/no-sleep.status"

if [[ -f "$STATUS_FILE" ]]; then
	STATUS=$(cat "$STATUS_FILE" || echo "0")
else
	STATUS="0"
fi

# Now, check the value of the STATUS variable.
if [[ "$STATUS" == "0" ]]; then
	echo " "
else
	echo " "
fi
