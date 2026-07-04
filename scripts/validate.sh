#!/usr/bin/env bash
set -euo pipefail

SCHEMA_URL="https://raw.githubusercontent.com/jsonresume/resume-schema/master/schema.json"
SCHEMA_FILE="/tmp/resume-schema.json"
RESUME_FILE="${1:-resume.json}"

if [ ! -f "$RESUME_FILE" ]; then
	echo "❌ Resume file '$RESUME_FILE' not found"
	exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
	echo "npx could not be found"
	exit 1
fi

# echo "Fetching JSON Resume schema..."
# curl -sL "$SCHEMA_URL" -o "$SCHEMA_FILE"

echo "Validating $RESUME_FILE..."
# npx -y ajv-cli validate -s "$SCHEMA_FILE" -d "$RESUME_FILE" --strict=false 2>/dev/null
npx resumed validate "$RESUME_FILE"

echo "✅ $RESUME_FILE is valid"
