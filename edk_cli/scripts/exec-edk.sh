CONTAINER_NAME=$(docker ps --filter "name=edk-workspace" --format "{{.Names}}" | head -n 1)
if [ -z "$CONTAINER_NAME" ]; then
  echo "No running container found with name matching 'edk-workspace'."
  exit 1
fi
docker exec -it "$CONTAINER_NAME" /bin/bash

