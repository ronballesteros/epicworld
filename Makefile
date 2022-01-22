# Setup
.ONESHELL:
.SHELL := /usr/local/bin/bash

ifneq ($(shell kubectl >/dev/null 2>&1 && echo 0), 0)
$(error "👉 Dependency kubectl not found, please install via https://kubernetes.io/docs/tasks/tools/install-kubectl")
endif


help:
	@echo "\nmake infra-deploy: DEPLOY infrastructure Terraform code"
	@echo "\nmake infra-destroy: DESTROY infrastructure Terraform code"
	@echo "\nmake epicworld-deploy: DEPLOY Epicworld app on KIND"
	@echo "\nmake destroy-bigbang: DESTROY Epicworld app on KIND"


infra-deploy:
	kind create cluster --image=kindest/node:v1.23.1

infra-destroy:
	kind delete cluster

epicworld-deploy:
	bash bootstrap.sh

destroy-epicworld:
	kustomize build ./apps | kubectl delete -f -
