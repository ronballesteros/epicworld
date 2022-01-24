# Setup
.ONESHELL:
.SHELL := /usr/local/bin/bash

# Requiring kubectl for cluster api interaction
ifneq ($(shell kubectl >/dev/null 2>&1 && echo 0), 0)
$(error "👉 Dependency kubectl not found, please install via https://kubernetes.io/docs/tasks/tools/install-kubectl")
endif

help:
	@echo "\nmake infra-init: INITIALIZE infrastructure Terraform code "
	@echo "\nmake infra-plan: PLAN infrastructure Terraform code"
	@echo "\nmake infra-deploy: DEPLOY infrastructure Terraform code"
	@echo "\nmake infra-destroy: DESTROY infrastructure Terraform code"
	@echo "\nmake epicworld-deploy: DEPLOY Epicworld app on GKE"
	@echo "\nmake destroy-bigbang: DESTROY Epicworld app on GKE"

infra-init:
	cd infra && terraform init

infra-plan:
	cd infra && terraform plan

infra-deploy:
	cd infra && terraform apply

infra-destroy:
	cd infra && terraform destroy

epicworld-deploy:
	bash bootstrap.sh

epicworld-destroy:
	kustomize build ./apps | kubectl delete -f -





