#! /bin/bash
if [ $(brightnessctl get -d asus::kbd_backlight) -eq 3 ]; then brightnessctl -sd asus::kbd_backlight set 0; else brightnessctl -sd asus::kbd_backlight set +1; fi

