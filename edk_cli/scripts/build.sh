source $(pwd)/.env

# Create workspace requirements.txt if it doesn't exist
WORKSPACE_DIR="${WORKSPACE_DIR:-./workspace}"
REQ_FILE="$WORKSPACE_DIR/requirements.txt"
if [ ! -f "$REQ_FILE" ]; then
  mkdir -p "$WORKSPACE_DIR"
  touch "$REQ_FILE"
fi

# Convert absolute path to relative path for Docker build context
if [[ "$WORKSPACE_DIR" == /* ]]; then
  # If it's an absolute path, make it relative to current directory
  WORKSPACE_DIR_RELATIVE=$(realpath --relative-to="$(pwd)" "$WORKSPACE_DIR" 2>/dev/null || python3 -c "import os; print(os.path.relpath('$WORKSPACE_DIR', '$(pwd)'))")
else
  WORKSPACE_DIR_RELATIVE="$WORKSPACE_DIR"
fi

DOCKERFILE_PATH="$1"

docker build --build-arg WORKSPACE_DIR=${WORKSPACE_DIR_RELATIVE} -t edk-workspace -f $DOCKERFILE_PATH .