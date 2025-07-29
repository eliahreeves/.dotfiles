#!/usr/bin/env bash
pushd "$HOME/nixos-config/"
alejandra . &>/dev/null
git add .
git --no-pager diff --cached
echo "NixOs Rebuilding..."
if { sudo nixos-rebuild switch --flake ~/nixos-config#computer 2>&1 | tee nixos-switch.log; } && [ "${PIPESTATUS[0]}" -eq 0 ]; then
    gen=$(sudo nixos-rebuild list-generations | grep True | awk '{print $1}')
    git commit -am "$gen"
    echo "$gen" >> nixos-switch.log
    echo "Rebuild successful, committed generation $gen"
else
    exit 1
fi
popd
