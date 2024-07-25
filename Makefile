.PHONY: help virtualenv kind image deploy

CLUSTER_NAME ?= $(shell whoami)-test

VIRTUALENV ?= ./virtualenv
ANSIBLE = $(VIRTUALENV)/bin/ansible-playbook $(VERBOSITY) $(EXTRA_VARS)

IGNORE_CERTS ?= false
IGNORE_CERTS_OPTION=
ifeq ($(IGNORE_CERTS), true)
IGNORE_CERTS_OPTION = --ignore-certs
endif

BITWARDEN_APIKEY_FILE ?= .apikey.mk

venv: 
	LC_ALL=en_US.UTF-8 python3 -m venv $(VIRTUALENV)
	. $(VIRTUALENV)/bin/activate && pip install --upgrade pip && pip install -r requirements.txt
	$(VIRTUALENV)/bin/ansible-galaxy collection install -r requirements.yml $(IGNORE_CERTS_OPTION)

init:
	@terraform init

# plan-classic:
# 	@export TF_VAR_token="$$(bw get password ocm-api)" && \
# 	export TF_VAR_admin_password="$$(bw get password admin)" && \
# 	terraform plan -out main.plan -var-file=main.tfvars

plan-hcp:
	@export TF_VAR_token="$$(bw get password ocm-api)" && \
	export TF_VAR_admin_password="$$(bw get password admin)" && \
	export TF_VAR_hosted_control_plane=true && \
	terraform plan -out main.plan -var-file=main.tfvars

# cluster-private:
# 	@export TF_VAR_private=true && terraform apply main.plan

cluster-public:
	@export TF_VAR_private=false && terraform apply main.plan

destroy:
	@export TF_VAR_token="$$(bw get password ocm-api)" && \
	export TF_VAR_admin_password="$$(bw get password cluster-admin)" && \
	terraform destroy -var-file=main.tfvars

ansible-rhoai:
	@. $(BITWARDEN_APIKEY_FILE); \
	bw login --apikey; \
	source $(VIRTUALENV)/bin/activate && \
	export BW_PASSWORD=$$(bw unlock --passwordenv BW_PASSWORD --raw); \
	cd ansible && \
	$(VIRTUALENV)/bin/ansible-playbook install-operators.yaml -i localhost --extra-vars "cluster_name=$(CLUSTER_NAME)"