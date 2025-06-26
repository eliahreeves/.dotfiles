#!/bin/bash
BACKUP_DIR="/run/media/erreeves/Backup/computer"
EXCLUDE_FILE="backup-exclude.txt"
mkdir -p "$BACKUP_DIR"

while read -r line; do
	# Skip empty lines and comments
	[[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

	# Split on '=>' and trim whitespace
	src=$(echo "$line" | cut -d'=' -f1 | xargs)
	dst=$(echo "$line" | cut -d'>' -f2 | xargs)
	src=$(eval echo "$src")

	echo "Backing up $src to $BACKUP_DIR/$dst"
	mkdir -p "$BACKUP_DIR/$dst"

	# Use exclude file if it exists
	if [[ -f "$EXCLUDE_FILE" ]]; then
		rsync -a --delete --exclude-from="$EXCLUDE_FILE" "$src/" "$BACKUP_DIR/$dst/"
	else
		rsync -a --delete "$src/" "$BACKUP_DIR/$dst/"
	fi
done <backup-list.txt
