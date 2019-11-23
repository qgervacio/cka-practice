# Copyright 2019 Quirino Gervacio. All Rights Reserved.

.PHONY: help

help:
	@echo "Usage: make [target]"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-11s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

TST = $(shell date "+D%Y%m%dT%H%M%S%Z" | sed -e "s/+/Z/g")
LOG = out-${TST}.log

d: destroy
destroy: ## (d)  Destroy VMs with force
	-vagrant destroy -f
	-rm -rf *.log

s: ssh
ssh: ## (s)  SSH to VM. (ex. s n=master0)
	-vagrant ssh $(n)

u: up
up: ## (u)  Start the environment
	-vagrant up 2>&1 | tee ${LOG}

vl: vlist
vlist: ## (vl) List VB running VMs
	-vboxmanage list runningvms
