#!/usr/bin/env bash
set -e

echo "Testing kubectl..."
kubectl version --client

echo "Testing helm..."
helm version

echo "Testing helmfile..."
helmfile --version

echo "Testing sops..."
sops --version

echo "Testing age..."
age --version

echo "All tools installed correctly ✔"
