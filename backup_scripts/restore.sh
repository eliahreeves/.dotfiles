#!/bin/bash
BACKUP_DIR="/run/media/erreeves/eli-files/computer"

while IFS='=>' read -r dst src; do
	src=$(echo "$src" | xargs)
	dst=$(echo "$dst" | xargs)
	echo "Restoring $BACKUP_DIR/$src to $dst"
	rsync -a "$BACKUP_DIR/$src/" "$dst/"
done < <(awk -F'=>' '{print $2 " => " $1}' backup-list.txt)
