
default: 
	echo "I am an example Makefile: execute make help"

# System checks

## Checking for python3 of a specific major.minor version
PYVERCHECK=$(shell (which python3 >/dev/null && (python3 --version | grep -Eo '3\.8\..|3\.10\..')))

.PHONY: check-python
check-python:
	$(info Checking Python version)
ifneq ($(PYVERCHECK),)
	$(info OK: Found python version $(PYVERCHECK))
else
	$(error Python3 versions 3.8 or 3.10 not found)
endif

##~ Execute system checks 
.PHONY: check-system
check-system: check-python 
	@echo "System checks passed"

#############################################################################

# Creating python venvs and deletion with confirmation

## Creating a venv and installing requirements
.example_venv/:
	python3 -m venv .example_venv/
	. .example_venv/bin/activate && python3 -m pip install -r some_requirements.txt

##~ Delete a venv with confirmation
.PHONY: delete-venv
delete-venv:
ifeq ($(CONFIRM),1) 
	$(info Removing environment)
	rm -rf .example_venv
else
	 $(info Execute with "make delete-venv CONFIRM=1" to confirm)
endif

##~ Check reqs and create venv
.PHONY: create-venv
create-venv: check-system .example_venv/

#############################################################################

# Pyproject

# build if folder does not exist
python/dist/: 
	. .example_venv/bin/activate && python3 -m pip install --upgrade build
	. .example_venv/bin/activate && cd python && python3 -m build


##~ Build example cli package
.PHONY: build
build: create-venv python/dist/
	
##~ Install example cli package
.PHONY: install 
install: create-venv python/dist/
	. .example_venv/bin/activate && python3 -m pip uninstall -y example_pyproject_cli
	. .example_venv/bin/activate && python3 -m pip install python/dist/example_pyproject_cli-0.0.1-py3-none-any.whl

.PHONY: undocumented-phony
undocumented-phony:
	@echo "I'm a secret"

##~ See help of example cli
.PHONY: cli-help 
cli-help: create-venv python/dist/
	. .example_venv/bin/activate && example_cli --help

##~ Execute example cli 
.PHONY: cli-execute
cli-execute: create-venv python/dist/
	. .example_venv/bin/activate && example_cli --required-named 2.0 --named 31 "something" 12345

#############################################################################

# Using the auxilary awk script to print help

##~ Print this help
.PHONY: help
help:
	@busybox awk -f awk/makefile_autodoc.awk ./Makefile | sort 
