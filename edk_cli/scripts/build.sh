source $(pwd)/.env

# Create workspace requirements.txt if it doesn't exist
WORKSPACE_DIR="${WORKSPACE_DIR:-./workspace}"

# Convert relative path to absolute path if needed
if [[ "$WORKSPACE_DIR" != /* ]]; then
  WORKSPACE_DIR="$(cd "$(dirname "$WORKSPACE_DIR")" && pwd)/$(basename "$WORKSPACE_DIR")"
fi

REQ_FILE="$WORKSPACE_DIR/requirements.txt"
if [ ! -f "$REQ_FILE" ]; then
  mkdir -p "$WORKSPACE_DIR"
  touch "$REQ_FILE"
fi

DOCKERFILE_PATH="$1"

docker build --build-arg WORKSPACE_DIR=${WORKSPACE_DIR} -t edk-workspace -f $DOCKERFILE_PATH $(pwd)
