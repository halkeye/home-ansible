#!make
.DEFAULT_GOAL := run

ANSIBLE_VAULT_FILE := .vault
ANSIBLE_PLAYBOOK := ansible-playbook -i inventory --vault-password-file $(ANSIBLE_VAULT_FILE)
ANSIBLE_DEBUG :=
PLAYBOOK := main

deps: requirements.yml ## Install ansible dependancies
	ansible-galaxy install -r requirements.yml

.PHONY: run
run: deps ## Run
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK).yml $(ANSIBLE_DEBUG)

.PHONY: jenkins
jenkins: deps ## Run
	$(ANSIBLE_PLAYBOOK) jenkins_agents.yml $(ANSIBLE_DEBUG)

.PHONY: check
check: deps ## Validate all the configs
	$(ANSIBLE_PLAYBOOK) $(PLAYBOOK).yml $(ANSIBLE_DEBUG) --check --diff

.PHONY: lint
lint: ## Perform an ansible-lint linting
	ansible-lint main.yml

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
