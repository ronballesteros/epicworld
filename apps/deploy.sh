#!/usr/bin/env bash
kustomize build .//flux | kubectl apply -f -
kubectl apply -f ./epicworld-reqs/namespace.yaml

kubectl create secret generic repository-credentials -n epicworld --from-literal=username=${GITHUB_USER} --from-literal=password=${GITHUB_PASSWORD}
