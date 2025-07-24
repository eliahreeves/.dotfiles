#!/usr/bin/env bash

mkdir -p ~/Pictures/Screenshots
SCREENSHOT_FILE_NAME="screenshot-$(date +%F_%T).png"
SCREENSHOT_PATH="$HOME/Pictures/Screenshots/$SCREENSHOT_FILE_NAME"
if area=$(slurp); then grim -g "$area" - | tee >(wl-copy) >"$SCREENSHOT_PATH" && notify-send "Screenshot Taken" "$SCREENSHOT_FILE_NAME" --icon "$SCREENSHOT_PATH"; fi
