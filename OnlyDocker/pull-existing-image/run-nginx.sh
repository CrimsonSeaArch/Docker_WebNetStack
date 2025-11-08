#!/bin/zsh

set -euo pipefail

SITE_DIR="$(pwd)/website"
CONTAINER_NAME="webnetstack-nginx"
IMAGE="nginx:alpine"

# Container starten (mit Bind-Mount)
docker run -d \
  --name "$CONTAINER_NAME" \
  -p 8080:80 \
  -v "$SITE_DIR":/usr/share/nginx/html:ro,Z \
  "$IMAGE"

echo "→ Website erreichbar unter: http://localhost:8080"
