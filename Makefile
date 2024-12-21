SHELL=/bin/bash
PROJECT=time2block
REGION=us-east1
SERVICE_NAME=t2b
DOCKER_IMAGE_TAG=latest
DOCKER_IMAGE=time2block
DOCKER_REPOSITORY_ID=andremiras
DOCKER_IMAGE_NAME=$(DOCKER_REPOSITORY_ID)/$(DOCKER_IMAGE):$(DOCKER_IMAGE_TAG)
API_SERVICE_NAME=$(SERVICE_NAME)-time2block-api
CLOUDSDK_CORE_ACCOUNT?=notset

ensure-account-set:
ifeq ($(CLOUDSDK_CORE_ACCOUNT),notset)
	$(error CLOUDSDK_CORE_ACCOUNT is not set. Please set it to a valid email address.)
endif

devops/terraform/fmt:
	terraform -chdir=terraform fmt -recursive -diff

devops/terraform/init:
	terraform -chdir=terraform init

devops/terraform/plan:
	terraform -chdir=terraform plan

devops/terraform/apply:
	terraform -chdir=terraform apply -auto-approve

devops/terraform/output:
	terraform -chdir=terraform output

devops/gcloud/redeploy/api: ensure-account-set
	gcloud run deploy $(API_SERVICE_NAME) \
	--project $(PROJECT) \
	--image $(DOCKER_IMAGE_NAME) \
	--platform managed \
	--region $(REGION)

lint/terraform:
	terraform -chdir=terraform fmt -recursive -check -diff

lint: lint/terraform

format/terraform: devops/terraform/fmt

format: format/terraform
