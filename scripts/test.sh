#!/usr/bin/env bash
set -euo pipefail

KUBECTL_VERSION="${KUBECTL_VERSION:-v1.30.5}"

echo "======================================"
echo " Building container image"
echo "======================================"
KUBECTL_VERSION="$KUBECTL_VERSION" ./scripts/build.sh

echo ""
echo "======================================"
echo " Running container tests"
echo "======================================"

docker run --rm \
  --platform linux/arm64 \
  -e KUBECTL_VERSION="$KUBECTL_VERSION" \
  -v $(pwd)/scripts:/scripts/ \
  --entrypoint bash \
  docker.io/johe37/k8s-toolbox:latest \
  -c "
    set -e
    /scripts/test_tools.sh
  "

echo ""
echo "======================================"
echo " ALL TESTS PASSED ✔"
echo "======================================"
