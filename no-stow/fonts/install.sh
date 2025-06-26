#! /bin/bash
mkdir ~/.local/share/fonts
cp ./*.ttf ~/.local/share/fonts
fc-cache -f -v
