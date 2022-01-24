#!/usr/bin/env bash

# Quick check to ensure the cluster is ready
echo "Checking if K8s nodes are ready"
if ! kubectl wait --for=condition=ready --timeout 600s nodes --all; then
  echo "Timed out waiting for nodes to become ready"
  exit 1
fi

# Flux pre-check to ensure requirements are met
echo "Installing Flux"
flux --version
flux check --pre

# Deploy flux and wait for it to be ready
kustomize build ./flux | kubectl apply -f -

## create flux namespace
#kubectl create ns flux-system || true

# Wait for flux
flux check

# Create secret ref for flux source controller to pull from the repo
# These credentials are loaded from the .envrc file
kubectl create secret generic repository-credentials -n flux-system --from-literal=username=${GITHUB_USER} --from-literal=password=${GITHUB_PASSWORD}

# Deploy epicworld which should flux would watch and reconcile automatically.
kustomize build ./bootstrap | kubectl apply -f -

# Deploy epicworld apps
kustomize build ./apps | kubectl apply -f -