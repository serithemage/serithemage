# Repository Guidelines

## Project Structure & Module Organization

This repository maintains the `serithemage` GitHub profile.

- `README.md`: public profile, experience, projects, publications, and linked certification images.
- `scripts/collect-*.sh`: Bash collectors for repositories, stars, and events.
- `Makefile`: entry points for collection and cleanup.
- `data/`: generated collection output; ignored by Git.
- `.github/workflows/update-profile.yml`: weekly and manually triggered profile updates.
- `.claude/skills/update-profile/SKILL.md`: profile-update procedure; `CLAUDE.md` provides additional repository guidance.

There are no application source, test, or local asset directories.

## Build, Test, and Development Commands

Install Bash, Make, Git, GitHub CLI (`gh`), and `jq`; authenticate `gh` before collecting data. Run commands from the repository root.

- `make collect-all`: writes `data/repos.txt`, `data/stars.tsv`, and `data/events.json`.
- `make collect-stars`: prints tracked project star counts.
- `make collect-repos` / `make collect-events`: prints recent repository or event information.
- `make collect-all SINCE=2026-01-01`: sets the collection start date; otherwise, the last README commit date is used.
- `make clean`: deletes generated `data/`.

There is no build step or local application server.

## Coding Style & Naming Conventions

Preserve the English README's heading hierarchy, project categories, links, and star notation. Use descriptive, hyphenated script names such as `collect-stars.sh`. Follow existing Bash conventions: `#!/usr/bin/env bash`, `set -euo pipefail`, quoted variables, uppercase configuration variables, and two-space indentation. Use tabs for Make recipes and two spaces for YAML. No formatter or linter is configured.

## Testing Guidelines

No automated test framework, test naming convention, or coverage threshold exists. Check shell syntax with `for script in scripts/*.sh; do bash -n "$script" || exit; done` and whitespace with `git diff --check`. For collector changes, run the affected Make target and inspect output for API errors or unexpected empty results. Preview README rendering and verify changed links and figures.

## Commit & Pull Request Guidelines

History uses concise descriptive subjects in English and Korean without a mandatory prefix. Keep commits focused. PR descriptions should explain changes, data sources, and validation; link relevant issues and include screenshots for rendering changes. Automated profile commits follow the workflow's `- [Skip GitHub Action]` suffix convention.

## Security & Configuration

Keep generated data and credentials out of commits. Automation uses `ANTHROPIC_API_KEY` and `METRICS_TOKEN` repository secrets. Do not identify private repositories in the public profile; summarize relevant experience without private details.
