# Copyright (C) 2021 Quirino Gervacio. All Rights Reserved.

.PHONY: help test

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \
	    \033[36m        <target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ \
	    { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } \
	    /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL  := help

TST = $(shell date "+D%Y%m%dT%H%M%S%Z" | sed -e "s/+/Z/g")
LOG = out-${TST}.log

##@ Build


c: create
create: ## (c) Create VMs
	@vagrant up 2>&1 | tee ${LOG}

s: ssh
ssh: ## (s) SSH to VM. (ex. s n=master0)
	@vagrant ssh $(n)

x: destroy
destroy: ## (x) Destroy VMs with force
	@vagrant destroy -f
	@rm -rf *.log

u: up
up: ## (u) Resume Vms
	@vagrant resume

d: down
down: ## (d) Suspend Vms
	@vagrant suspend

l: list
list: ## (l) List VB running VMs
	@vboxmanage list runningvms
