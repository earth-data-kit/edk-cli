FROM ghcr.io/earth-data-kit/edk:latest

# Copy requirements.txt from the workspace directory if it exists and install it
ARG WORKSPACE_DIR
ENV WORKSPACE_DIR=${WORKSPACE_DIR}
COPY ${WORKSPACE_DIR}/requirements.txt /app/workspace-requirements.txt

RUN pip install -r /app/workspace-requirements.txt

WORKDIR /app/workspace