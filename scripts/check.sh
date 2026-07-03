#!/usr/bin/env bash
set -euo pipefail
biome check
tombi format --check
shfmt -d scripts/*.sh
shellcheck scripts/*.sh
tombi lint --error-on-warnings
