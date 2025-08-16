#!/usr/bin/env bash

if [[ "$(cat /sys/class/power_supply/ADP1/online)" == "1" ]]; then
	brightnessctl --save
	system76-power profile performance
	brightnessctl --restore
else
	brightnessctl --save
	system76-power profile battery
	brightnessctl --restore
fi
