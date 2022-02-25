#!/bin/bash
which ansible || pip install ansible
ansible-galaxy install -p ./roles -r requirements.yml --force
