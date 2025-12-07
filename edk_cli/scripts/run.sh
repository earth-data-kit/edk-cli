source $(pwd)/.env

# Remove container if it exists
if docker ps -a --filter "name=edk-workspace" | grep -q edk-workspace; then
  docker rm -f edk-workspace
fi

docker run \
  --name edk-workspace \
  --security-opt seccomp=unconfined \
  --env-file $(pwd)/.env \
  -p 8888:8888 \
  -v ${WORKSPACE_DIR:-./workspace}:/app/workspace \
  -v ${DATA_DIR:-./data}:/app/data \
  -v ${AWS_CONFIG_DIR:-~/.aws}:/root/.aws \
  -v ./.edk-venv:/opt/venv \
  ghcr.io/earth-data-kit/edk:latest