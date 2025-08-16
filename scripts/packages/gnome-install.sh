#! /bin/bash
pacman -S --needed $(cat "$(dirname "$0")/gnome-essentials.txt")
