#!/usr/bin/env bash
for d in /var/lib/minecraft/*-world/; do
  rsync -a --delete "$d" "/home/erreeves/Documents/minecraft_worlds/$(basename "$d")"
done
chown -R erreeves:users /home/erreeves/Documents/minecraft_worlds/
