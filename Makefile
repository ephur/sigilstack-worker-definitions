PYTHON_VERSION := 3.13.3

.PHONY: all env check-pyenv install-python create-venv activate-venv help clean

all: help

help:
	@echo "make pr-summary       - Generate a PR summary of recent commits"
	@echo "make rubberstamp      - Run the rubberstamp script to create and merge a PR"

rubberstamp:
	./scripts/rubberstamp.sh

pr-summary:
	@echo "Generating PR summary from commits since master..."
	@DEFAULT_BRANCH=$$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'); \
	git fetch origin $${DEFAULT_BRANCH}; \
	git log origin/$${DEFAULT_BRANCH}..HEAD --pretty=format:"- %s" > .pr_summary.tmp; \
	if [ ! -s .pr_summary.tmp ]; then echo "No new commits to summarize."; rm -f .pr_summary.tmp; exit 0; fi
	@echo "\nProposed PR Body:\n"
	@cat .pr_summary.tmp
	@rm .pr_summary.tmp
