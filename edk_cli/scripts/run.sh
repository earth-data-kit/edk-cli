# Remove container if it exists
if docker ps -a --filter "name=edk-workspace" | grep -q edk-workspace; then
  docker rm -f edk-workspace
fi

# Load environment variables
source $(pwd)/.env

# Set defaults and convert relative paths to absolute paths
WORKSPACE_DIR="${WORKSPACE_DIR:-./workspace}"
DATA_DIR="${DATA_DIR:-./data}"
AWS_CONFIG_DIR="${AWS_CONFIG_DIR:-~/.aws}"

# Convert relative path to absolute path for WORKSPACE_DIR
if [[ "$WORKSPACE_DIR" != /* ]]; then
  WORKSPACE_DIR="$(cd "$(dirname "$WORKSPACE_DIR")" && pwd)/$(basename "$WORKSPACE_DIR")"
fi

# Convert relative path to absolute path for DATA_DIR
if [[ "$DATA_DIR" != /* ]]; then
  DATA_DIR="$(cd "$(dirname "$DATA_DIR")" && pwd)/$(basename "$DATA_DIR")"
fi

# Expand tilde for AWS_CONFIG_DIR
AWS_CONFIG_DIR="${AWS_CONFIG_DIR/#\~/$HOME}"

docker run -it --init \
  --name edk-workspace \
  --security-opt seccomp=unconfined \
  --env-file $(pwd)/.env \
  -p 8888:8888 \
  -v ${WORKSPACE_DIR}:/app/workspace \
  -v ${DATA_DIR}:/app/data \
  -v ${AWS_CONFIG_DIR}:/root/.aws \
  edk-workspace \
  /bin/bash -lc "pip install -e /app/earth-data-kit && tail -f /dev/null"