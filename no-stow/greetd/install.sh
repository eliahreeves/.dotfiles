#!/bin/bash
pacman -Sy --needed greetd greetd-tuigreet
cp config.toml /etc/greetd/
cp hyprland.conf /etc/greetd/
cp start-hyprland /usr/local/bin/
systemctl enable --now greetd.service
