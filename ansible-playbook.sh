#!/bin/bash
ansible-playbook -i inventory --vault-password-file .vault $@
