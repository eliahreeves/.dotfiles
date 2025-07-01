#! /bin/bash
mkdir -p ~/Pictures/Screenshots
SCREENSHOT_FILE_NAME="screenshot-$(date +%F_%T).png"
SCREENSHOT_PATH="$HOME/Pictures/Screenshots/$SCREENSHOT_FILE_NAME"
grim - | wl-copy && wl-paste >"$SCREENSHOT_PATH" && notify-send "Screenshot Taken" "$SCREENSHOT_FILE_NAME" --icon "$SCREENSHOT_PATH"
