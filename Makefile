#!make
.DEFAULT_GOAL := run

ANSIBLE_PLAYBOOK := ansible-playbook -i inventory --vault-password-file .vault

deps: requirements.yml ## Install ansible dependancies
	ansible-galaxy install -r requirements.yml

.PHONY: run
run: deps ## Run
	$(ANSIBLE_PLAYBOOK) main.yml

.PHONY: jenkins
jenkins: deps ## Run
	$(ANSIBLE_PLAYBOOK) jenkins_agents.yml

.PHONY: check
check: deps ## Validate all the configs
	$(ANSIBLE_PLAYBOOK) main.yml --check --diff

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
