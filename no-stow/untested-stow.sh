#!/bin/bash

# Simple GNU Stow implementation
# This script creates symlinks from files in a package directory to a target directory

usage() {
	echo "Usage: $0 [options] package_dir"
	echo "Options:"
	echo "  -t, --target DIR    Set target directory (default: parent of package_dir)"
	echo "  -d, --dir DIR       Set stow directory (default: current directory)"
	echo "  -D, --delete        Delete (unstow) the package instead of installing it"
	echo "  -v, --verbose       Enable verbose output"
	echo "  -h, --help          Display this help message"
	exit 1
}

# Default values
TARGET=""
STOW_DIR="$(pwd)"
DELETE=false
VERBOSE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	-t | --target)
		TARGET="$2"
		shift 2
		;;
	-d | --dir)
		STOW_DIR="$2"
		shift 2
		;;
	-D | --delete)
		DELETE=true
		shift
		;;
	-v | --verbose)
		VERBOSE=true
		shift
		;;
	-h | --help)
		usage
		;;
	-*)
		echo "Unknown option: $1"
		usage
		;;
	*)
		PACKAGE="$1"
		shift
		;;
	esac
done

# Check if package is specified
if [ -z "$PACKAGE" ]; then
	echo "Error: No package specified"
	usage
fi

# Calculate absolute paths
PACKAGE_DIR="$STOW_DIR/$PACKAGE"

# Set target directory if not specified
if [ -z "$TARGET" ]; then
	TARGET="$(dirname "$STOW_DIR")"
fi

# Check if package directory exists
if [ ! -d "$PACKAGE_DIR" ]; then
	echo "Error: Package directory '$PACKAGE_DIR' does not exist"
	exit 1
fi

log() {
	if [ "$VERBOSE" = true ]; then
		echo "$1"
	fi
}

# Function to create parent directories for a target file if needed
create_parent_dirs() {
	local target_path="$1"
	local parent_dir="$(dirname "$target_path")"

	if [ ! -d "$parent_dir" ]; then
		mkdir -p "$parent_dir"
		log "Created directory: $parent_dir"
	fi
}

# Function to stow a package
stow_package() {
	log "Stowing package '$PACKAGE' from '$PACKAGE_DIR' to '$TARGET'"

	# Find all files in the package directory
	find "$PACKAGE_DIR" -type f -o -type l | while read -r file; do
		# Calculate relative path within package
		rel_path="${file#$PACKAGE_DIR/}"

		# Calculate target location
		target_file="$TARGET/$rel_path"

		# Create parent directories if they don't exist
		create_parent_dirs "$target_file"

		# Create symlink if it doesn't already exist
		if [ ! -e "$target_file" ]; then
			ln -s "$file" "$target_file"
			log "Created symlink: $target_file -> $file"
		else
			log "Warning: Target file already exists: $target_file"
		fi
	done

	# Handle directories (create empty ones if needed)
	find "$PACKAGE_DIR" -type d | while read -r dir; do
		# Calculate relative path within package
		rel_path="${dir#$PACKAGE_DIR/}"
		if [ -z "$rel_path" ]; then
			continue # Skip the package directory itself
		fi

		# Calculate target location
		target_dir="$TARGET/$rel_path"

		# Create directory if it doesn't exist (and not created by file symlinks)
		if [ ! -e "$target_dir" ]; then
			mkdir -p "$target_dir"
			log "Created directory: $target_dir"
		fi
	done
}

# Function to unstow a package
unstow_package() {
	log "Unstowing package '$PACKAGE' from '$TARGET'"

	# Find all files in the package directory
	find "$PACKAGE_DIR" -type f -o -type l | while read -r file; do
		# Calculate relative path within package
		rel_path="${file#$PACKAGE_DIR/}"

		# Calculate target location
		target_file="$TARGET/$rel_path"

		# Remove symlink if it points to our file
		if [ -L "$target_file" ]; then
			target_link="$(readlink "$target_file")"
			if [ "$target_link" = "$file" ]; then
				rm "$target_file"
				log "Removed symlink: $target_file"
			else
				log "Warning: Target is not a symlink to our file: $target_file"
			fi
		elif [ -e "$target_file" ]; then
			log "Warning: Target exists but is not a symlink to our file: $target_file"
		fi
	done

	# Clean up empty directories
	find "$TARGET" -type d -empty -delete 2>/dev/null
	log "Cleaned up empty directories"
}

# Main execution
if [ "$DELETE" = true ]; then
	unstow_package
else
	stow_package
fi

log "Operation completed successfully"
exit 0
