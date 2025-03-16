#!/bin/bash
BATTERY_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)
ON_AC_POWER=$(cat /sys/class/power_supply/AC0/online)

if [ "$ON_AC_POWER" -eq 0 ]; then
  CHARGING=""
else
  CHARGING="󱐋"
fi

if [ "$BATTERY_PERCENT" -ge 80 ]; then
  ICON=""
elif [ "$BATTERY_PERCENT" -ge 60 ]; then
  ICON=""
elif [ "$BATTERY_PERCENT" -ge 40 ]; then
  ICON=""
elif [ "$BATTERY_PERCENT" -ge 20 ]; then
  ICON=""
else
  ICON=""
fi

echo "$ICON  $CHARGING$BATTERY_PERCENT%"
