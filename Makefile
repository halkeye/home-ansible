#!make
.DEFAULT_GOAL := run

ANSIBLE_PLAYBOOK := ansible-playbook -i inventory --vault-password-file .vault

.PHONY: run
run: ## Run
	$(ANSIBLE_PLAYBOOK) main.yml

.PHONY: check
check: ## Validate all the configs
	$(ANSIBLE_PLAYBOOK) main.yml --check --diff

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
