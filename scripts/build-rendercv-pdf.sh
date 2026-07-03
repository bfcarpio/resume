#!/usr/bin/env bash
set -euo pipefail

YAML_INPUT="${1:-rendercv.yaml}"
OUTPUT_DIR="${2:-.}"
THEME="${3:-engineeringclassic}"

if [ ! -f "$YAML_INPUT" ]; then
	echo "❌ Input file '$YAML_INPUT' not found"
	exit 1
fi

# Set theme via yq (uvx), then render
uvx --from yq yq -i ".Theme = \"$THEME\"" "$YAML_INPUT"
echo "Rendering $YAML_INPUT with theme: $THEME"
uvx rendercv render "$YAML_INPUT" --output "$OUTPUT_DIR"

# RenderCV names output <name>_CV.pdf — locate and report
PDF=$(find "$OUTPUT_DIR" -maxdepth 1 -name '*_CV.pdf' -print -quit)
if [ -n "$PDF" ]; then
	echo "✅ Generated $PDF"
else
	echo "❌ No PDF produced"
	exit 1
fi
