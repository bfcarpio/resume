#!/usr/bin/env bash
biome check --fix
biome format --fix
tombi format
shfmt -w scripts/*.sh
tombi lint
