#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="docker.io/johe37/k8s-toolbox:latest"
KUBECTL_VERSION="${KUBECTL_VERSION:-v1.30.5}"

# Detect host architecture
# ARCH=$(uname -m)
ARCH=linux/amd64

case "$ARCH" in
  x86_64)
    PLATFORM="linux/amd64"
    ;;
  arm64|aarch64)
    PLATFORM="linux/arm64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

echo "======================================"
echo " Building image"
echo " Image: $IMAGE_NAME"
echo " Host arch: $ARCH"
echo " Target platform: $PLATFORM"
echo " kubectl version: $KUBECTL_VERSION"
echo "======================================"

docker build \
  --platform "$PLATFORM" \
  --build-arg KUBECTL_VERSION="$KUBECTL_VERSION" \
  -t "$IMAGE_NAME" \
  .

echo ""
echo "Build completed ✔"
