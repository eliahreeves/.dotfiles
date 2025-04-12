#!/bin/bash

container_name="225-dev-container"
image_name="225-dev-image"

# Check if container exists
if ! docker ps -a --format '{{.Names}}' | grep -q "^${container_name}$"; then
	echo "Creating and starting container..."
	docker run -dit \
		--name "$container_name" \
		-v "$PWD":/workspace \
		-w /workspace \
		"$image_name" \
		zsh
elif ! docker ps --format '{{.Names}}' | grep -q "^${container_name}$"; then
	echo "Starting existing container..."
	docker start "$container_name" >/dev/null
fi

# Run the passed command inside the container
if [ $# -eq 0 ]; then
	docker exec -it "$container_name" zsh
else
	docker exec -it "$container_name" zsh -c "$*"
fi
