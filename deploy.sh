#!/usr/bin/env bash
kustomize build ./base/flux | kubectl apply -f -
kubectl apply -f ./base/epicworld-reqs/namespace.yaml
