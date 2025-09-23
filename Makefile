#doc#
#doc# production-python-template - Makefile
#doc#
#doc# Purpose: Automate common development tasks, including managing the project's virtual environment, running tests,
#doc# and doing autoformatting.
#doc#
#doc# Usage: run `make <target>` (common targets: setup, test, fmt, clean, help).
#doc#
#doc# Notes:
#doc#   - This Makefile uses the `uv` CLI (configurable via UV env var). See https://docs.astral.sh/uv/.
#doc#   - A project virtualenv is created in .venv by default (UV_PROJECT_ENVIRONMENT).
#doc#   - The `help` target prints any Makefile lines prefixed with `#doc# `; avoid leading underscores for visible
#doc#     targets.
#doc#

# --- Make configurations
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Tooling
UV ?= uv

# Force an in-project virtualenv for determinism
export UV_PROJECT_ENVIRONMENT ?= .venv

.DEFAULT_GOAL := help

# --- Helper targets

help:    #doc# Show this help
	@sed -ne '/@sed/!s/#doc#//p' $(MAKEFILE_LIST) | grep -v '^_'

.PHONY: _check-uv
_check-uv: #doc# Verify uv is installed
	@command -v $(UV) >/dev/null 2>&1 || { \
	  echo "uv not found. See https://docs.astral.sh/uv/ for installation instructions."; exit 1; }

# --- Primary targets

.PHONY: setup
setup:   #doc# Create/refresh .venv and install deps from pyproject
setup: _check-uv
	$(UV) sync --group dev

.PHONY: test
test:    #doc# Run the pytest suite
test: setup
	$(UV) run pytest -q tests/

### Convenience targets

.PHONY: lock
lock:    #doc# (Re)generate uv.lock without installing
lock: _check-uv
	$(UV) lock

.PHONY: update
update:  #doc# Update to latest compatible versions and resync
update: _check-uv
	$(UV) lock --upgrade
	$(UV) sync --group dev

.PHONY: clean
clean:   #doc# Remove Python caches and build artifacts (keeps .venv)
	@find . -type d -name "__pycache__" -prune -exec rm -rf {} + || true
	@rm -rf .pytest_cache .ruff_cache || true
