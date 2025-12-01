# Remove container if it exists
if docker ps -a --filter "name=edk-workspace" | grep -q edk-workspace; then
  docker rm -f edk-workspace
fi

docker run -it --init \
  --name edk-workspace \
  --security-opt seccomp=unconfined \
  --env-file $(pwd)/.env \
  -p 8888:8888 \
  -v ${WORKSPACE_DIR:-./workspace}:/app/workspace \
  -v ${DATA_DIR:-./data}:/app/data \
  -v ${AWS_CONFIG_DIR:-~/.aws}:/root/.aws \
  edk-workspace \
  /bin/bash -lc "pip install -e /app/earth-data-kit && tail -f /dev/null"