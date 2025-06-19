#! /bin/bash
pacman -S --needed $(cat "$(dirname "$0")/pacman.txt")
