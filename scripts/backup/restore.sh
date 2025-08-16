#!/usr/bin/env bash
MOUNT_POINT="/mnt"
BACKUP_DIR="$MOUNT_POINT/computer"
LOG_FILE="$BACKUP_DIR/backup.log"

restore() {
	local backup_path="$1"
	local original_path="$2"

	if [ ! -d "$backup_path" ]; then
		echo "Warning: Backup path $backup_path does not exist, skipping"
		return 1
	fi

	echo "Restoring $backup_path to $original_path"

	# Create parent directory if it doesn't exist
	mkdir -p "$(dirname "$original_path")"

	# Restore using rsync
	rsync -a --delete "$backup_path/" "$original_path"
}

# Check if backup drive is mounted
if ! mountpoint -q $MOUNT_POINT; then
	echo "Backup drive not mounted. Exiting."
	exit 1
fi

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
	echo "Backup log file $LOG_FILE not found. Exiting."
	exit 1
fi

echo "Restore plan:"
echo "Reading from: $LOG_FILE"
echo

# First pass: show the plan
while IFS='|' read -r original_path backup_path; do
	# Skip empty lines
	[ -z "$original_path" ] && continue

	if [ ! -d "$backup_path" ]; then
		echo "$backup_path => $original_path (WARNING: backup path does not exist)"
	else
		echo "$backup_path => $original_path"
	fi
done <"$LOG_FILE"

echo
echo -n "Do you want to proceed with the restoration? (y/N): "
read -r confirmation

if [[ ! "$confirmation" =~ ^[Yy]$ ]]; then
	echo "Restoration cancelled."
	exit 0
fi

echo
echo "Starting restore process..."

# Second pass: actually restore
while IFS='|' read -r original_path backup_path; do
	# Skip empty lines
	[ -z "$original_path" ] && continue

	restore "$backup_path" "$original_path"
done <"$LOG_FILE"

echo
echo "Restore complete!"
