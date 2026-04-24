#!/usr/bin/env bash
set -e

kubectl version --client=true | grep -E "Client Version|GitVersion"
helm version
helmfile --version
sops --version
age --version
