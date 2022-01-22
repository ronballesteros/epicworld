# Setup
.ONESHELL:
.SHELL := /usr/local/bin/bash

ifneq ($(shell kubectl >/dev/null 2>&1 && echo 0), 0)
$(error "👉 Dependency kubectl not found, please install via https://kubernetes.io/docs/tasks/tools/install-kubectl")
endif


help:
	@echo "\nmake ssh: ssh into bastion host"
	@echo "\nmake connect: Create Split tunnel to access private DNS"
	@echo "\nmake infra-plan: plan dev environment in test-coder AWS account"
	@echo "\nmake infra-deploy: Deploy dev environment in test-coder AWS account"
	@echo "\nmake infra-destroy: Destroy dev environment in test-coder AWS account"
	@echo "\nmake bb-deploy: Deploy Bigbang on PartyBus RKE2 K8s Cluster"
	@echo "\nmake destroy-bigbang: Destory Bigbang on PartyBus K8s Cluster"
	@echo "\nmake reset-argo-pw: Temporary work-around for argo password issues"

infra-plan:
	terragrunt run-all plan --terragrunt-working-dir infra/env/dev/us-gov-west-1

infra-deploy:
	kind create cluster --config /Users/rballesteros/r2b-lab/kind/kind-config.yaml --image=kindest/node:v1.23.1

infra-destroy:
	kind delete cluster

infra-clean:
	find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
	find . -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;
	rm common-dev.pem

epicworld-deploy:
	bash bootstrap.sh

destroy-epicworld:
	kustomize build ./apps | kubectl delete -f -
