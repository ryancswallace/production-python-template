#
# production-python-template
# Usage: See `make help`
#

### Make configurations
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Tooling
UV ?= uv

# Force an in-project virtualenv for determinism
export UV_PROJECT_ENVIRONMENT ?= .venv

.DEFAULT_GOAL := help

### Helper targets

.PHONY: help
help:  ## Show this help message
	@printf "Usage: make <target>\n\n"
	@awk 'BEGIN {FS":.*##"; OFS=""; print "Targets:" } /^[a-zA-Z0-9_.-]+:.*##/ { \
	  printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: _check-uv
_check-uv:  ## Verify uv is installed
	@command -v $(UV) >/dev/null 2>&1 || { \
	  echo "uv not found. See https://docs.astral.sh/uv/ for installation instructions."; exit 1; }

### Primary targets

.PHONY: setup
setup: _check-uv  ## Create/refresh .venv and install deps from pyproject
	$(UV) sync --group dev

.PHONY: test
test: setup  ## Run the pytest suite
	$(UV) run pytest -q tests/

### Convenience targets

.PHONY: lock
lock: _check-uv  ## (Re)generate uv.lock without installing
	$(UV) lock

.PHONY: update
update: _check-uv  ## Update to latest compatible versions and resync
	$(UV) lock --upgrade
	$(UV) sync --group dev

.PHONY: clean
clean:  ## Remove Python caches and build artifacts (keeps .venv)
	@find . -type d -name "__pycache__" -prune -exec rm -rf {} + || true
	@rm -rf .pytest_cache .ruff_cache || true
