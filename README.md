# edk-cli

A CLI tool for Earth-Data-Kit — designed to simplify environment setup, container management, and Jupyter Notebook access for Earth data workflows.

---

## Prerequisites

- Python 3.12 or higher is required  
- Docker must be installed and running

You can check your Python version with:
```bash
python3 --version
```
## Installation

To install, run the below command. This downloads the latest release from GitHub and installs it.
```bash
pip3 install https://github.com/earth-data-kit/edk-cli/releases/download/0.1.0/edk_cli-0.1.0-py3-none-any.whl
```

## Usage

- `edk configure`: Helps user configure `.env` for earth-data-kit
- `edk run`: Builds and runs the edk container
- `edk ssh`: SSH into the edk container
- `edk notebook`: Starts a Jupyter notebook


## Important Notes:

- You must create the workspace and data directories before running edk configure.
- Use relative paths (not absolute paths) when specifying directories.
  - Example: ./workspace
  - Avoid: /Users/username/earth-data-kit/workspace

- After running edk notebook , you’ll see a URL like: http://127.0.0.1:8888/lab?token=xxxx Open that link in your browser to access the Jupyter interface.
