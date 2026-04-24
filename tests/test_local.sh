#!/usr/bin/env bash
set -euo pipefail

KUBECTL_VERSION="${KUBECTL_VERSION:-v1.30.5}"

echo "======================================"
echo " Running local test pipeline"
echo "======================================"

# Build image
KUBECTL_VERSION="$KUBECTL_VERSION" bash scripts/build-local.sh

echo ""
echo "======================================"
echo " Running container tests"
echo "======================================"

docker run --rm \
  -e KUBECTL_VERSION="$KUBECTL_VERSION" \
  docker.io/johe37/k8s-toolbox:latest \
  bash -c "
    set -e
    /tests/test_kubectl_version.sh
    /tests/test_tools.sh
  "

echo ""
echo "======================================"
echo " ALL TESTS PASSED ✔"
echo "======================================"
