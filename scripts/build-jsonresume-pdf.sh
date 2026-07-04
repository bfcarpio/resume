#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-resume.json}"
OUTPUT="${2:-resume.pdf}"
# THEME="${3:-even}"
THEME="${3:-minyma}"

if [ ! -f "$INPUT" ]; then
	echo "❌ Input file '$INPUT' not found"
	exit 1
fi

echo "Building PDF from $INPUT → $OUTPUT (theme: $THEME)"
npm install "jsonresume-theme-${THEME}"
npx resumed render "$INPUT" --theme "jsonresume-theme-${THEME}" --type pdf --output "$OUTPUT"
echo "✅ Generated $OUTPUT"
