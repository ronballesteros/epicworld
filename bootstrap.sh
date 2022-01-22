#!/usr/bin/env bash

# Quick check to ensure the cluster is ready
echo "Checking if K8s nodes are ready"
if ! kubectl wait --for=condition=ready --timeout 600s nodes --all; then
  echo "Timed out waiting for nodes to become ready"
  exit 1
fi

# Deploy flux and wait for it to be ready
echo "Installing Flux"
flux --version
flux check --pre

# install flux
kustomize build ./flux | kubectl apply -f -

# create flux namespace
kubectl create ns flux-system || true

# # wait for flux
flux check

kubectl create secret generic repository-credentials -n flux-system --from-literal=username=${GITHUB_USER} --from-literal=password=${GITHUB_PASSWORD}

## Create necessary namespaces
#kubectl apply -f ./bootstrap/namespace.yaml

#Deploy epicworld which should flux would watch and reconcile automatically.
kustomize build ./bootstrap | kubectl apply -f -

kustomize build ./apps | kubectl apply -f -

## Deploy bitcoind using kustomize
#kustomize build apps/bitcoind/ | k apply -f -
#
## Deploy lightning networkd daemon using kustomize
#kustomize build apps/lnd/ | k apply -f -
#
## Deploy monitoring using kustomize
#kustomize build apps/monitoring/ | k apply -f -