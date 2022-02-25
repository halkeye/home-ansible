#!/bin/bash
CMD=$1
shift
ansible-vault $CMD --vault-password-file .vault $@
