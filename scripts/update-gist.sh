#!/usr/bin/env bash
set -euo pipefail

RESUME_FILE="${1:-resume.json}"
GIST_ID="941db0112258c22d1d1a371ba0eb72a6"

if [ ! -f "$RESUME_FILE" ]; then
	echo "❌ Resume file '$RESUME_FILE' not found"
	exit 1
fi

if [ -z "${GH_TOKEN:-}" ]; then
	echo "GH_TOKEN is not set"
	exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
	echo "jq could not be found"
	exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
	echo "curl could not be found"
	exit 1
fi

echo "Updating gist $GIST_ID with $RESUME_FILE"
body=$(jq -n --rawfile content "$RESUME_FILE" '{files: {"resume.json": {content: $content}}}')
curl -fsS -X PATCH \
	-H "Authorization: Bearer ${GH_TOKEN}" \
	-H "Accept: application/vnd.github+json" \
	-H "X-GitHub-Api-Version: 2022-11-28" \
	--data "$body" \
	"https://api.github.com/gists/${GIST_ID}"
echo "✅ Updated gist $GIST_ID"
