SHELL=/bin/bash

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

lint/terraform:
	terraform -chdir=terraform fmt -recursive -check -diff

lint: lint/terraform

format/terraform: devops/terraform/fmt

format: format/terraform
