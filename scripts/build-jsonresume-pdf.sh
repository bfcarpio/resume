#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-resume.json}"
OUTPUT="${2:-resume.pdf}"
THEME="${3:-flat}"

if [ ! -f "$INPUT" ]; then
	echo "❌ Input file '$INPUT' not found"
	exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
	echo "❌ npx could not be found"
	exit 1
fi

echo "Building PDF from $INPUT → $OUTPUT (theme: $THEME)"
npx -y resumed render "$INPUT" --theme "$THEME" --type pdf --output "$OUTPUT"
echo "✅ Generated $OUTPUT"
