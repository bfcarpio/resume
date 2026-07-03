#!/usr/bin/env bash
biome check --fix
biome format --fix
tombi format
tombi lint
