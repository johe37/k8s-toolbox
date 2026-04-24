docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t docker.io/johe37/k8s-toolbox:latest \
  --load .
