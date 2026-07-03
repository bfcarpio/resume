#!/usr/bin/env bash
biome check
tombi format --check
tombi lint --error-on-warnings
