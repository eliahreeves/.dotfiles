#!/bin/bash

# path to the battery sysfs info
BATTERY="/sys/class/power_supply/BAT0"

# get capacity
capacity=$(cat "$BATTERY/capacity")

# get status
status=$(cat "$BATTERY/status")

# if discharging and below thresholds
if [ "$status" == "Discharging" ]; then
	if [ "$capacity" -le 5 ]; then
		# go to hibernate
		/usr/bin/systemctl hibernate
	elif [ "$capacity" -le 10 ]; then
		# send notification to user session
		export DISPLAY=:0
		export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
		sudo -u erreeves /usr/bin/notify-send "Battery low" "Battery level is ${capacity}%!"
	fi
fi
