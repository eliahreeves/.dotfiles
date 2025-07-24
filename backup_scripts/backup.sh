#!/bin/bash
MOUNT_POINT="/run/media/erreeves/Backup"
BACKUP_DIR="$MOUNT_POINT/computer"
LOG_FILE="$BACKUP_DIR/backup.log"

backup() {
	mkdir -p "$BACKUP_DIR/$2"
	if [ -n "$3" ]; then
		echo "Backing up $1 to $BACKUP_DIR/$2 excluding $3"
		rsync -a --delete --exclude="$3" "$1" "$BACKUP_DIR/$2"
	else
		echo "Backing up $1 to $BACKUP_DIR/$2"
		rsync -a --delete "$1" "$BACKUP_DIR/$2"
	fi
	# Log the source and destination paths
	echo "$1|$BACKUP_DIR/$2" >>"$LOG_FILE"
}

if ! mountpoint -q $MOUNT_POINT; then
	echo "Backup drive not mounted. Exiting."
	exit 1
fi

# Clear/create the log file
true >"$LOG_FILE"

backup "$HOME/Documents/" Documents
backup "$HOME/repos/secrets/" repos/secrets
backup "$HOME/Pictures/" Pictures "Screenshots"
backup "$HOME/.dotfiles/" .dotfiles
backup "$HOME/.minecraft/" .minecraft
backup "$HOME/.ssh/" .ssh
backup "$HOME/.gnupg/" .gnupg
backup "$HOME/nixos/" nixos

echo "Backup complete. Log written to $LOG_FILE"
# sudo bash -c "$(declare -f backup); backup /srv/fabric/ root/srv/fabric"
