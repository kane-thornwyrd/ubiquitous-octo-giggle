# Inspired by https://github.com/babel/babel/blob/f5ef928586f592aa2d8bb60120ae58833d17e0db/Makefile
MAKEFLAGS = -j1
.DEFAULT_GOAL := help

export NODE_ENV = test
export FORCE_COLOR = true

SOURCES = packages

.PHONY: help lets-work

wildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

OS					 := $(shell uname)
NODE_MODULES		   ?= "./node_modules"
NODE_MODULES_BIN	   ?= "${NODE_MODULES}/.bin"
MAKE_COMMAND		   ?= help

# Credits to https://gist.github.com/prwhite/8168133#gistcomment-2278355

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)


TARGET_MAX_CHAR_NUM=20

## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
		helpCommand = substr($$1, 0, index($$1, ":")-1); \
		helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
		printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Bootstrap the project, the obvious target to start working on it !
lets-work:
	make clean-all
	npm i
	./node_modules/.bin/lerna bootstrap
	make build
