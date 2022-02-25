#!/bin/bash
ansible -i inventory --vault-password-file .vault $@
