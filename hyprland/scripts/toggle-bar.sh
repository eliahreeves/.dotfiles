#!/usr/bin/env bash

# Check if waybar is running
if pgrep "waybar" >/dev/null; then
  # If running, kill the waybar process
  pkill "waybar"
else
  # If not running, start waybar
  waybar &
fi
