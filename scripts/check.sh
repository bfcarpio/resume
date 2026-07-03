#!/usr/bin/env bash
biome check
tombi format --check
shfmt -d scripts/*.sh
shellcheck scripts/*.sh
tombi lint --error-on-warnings
