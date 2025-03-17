#!/bin/bash

if ! pacman -Q keyd &>/dev/null; then
  echo "keyd is not installed. Installing..."
  sudo pacman -S --noconfirm keyd
  sudo systemctl enable --now keyd
fi

cp default.conf /etc/keyd/
systemctl restart keyd
