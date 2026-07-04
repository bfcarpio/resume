#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-resume.json}"
PDF_OUTPUT="${2:-resume.pdf}"
THEME="${3:-engineeringclassic}"

if [ ! -f "$INPUT" ]; then
	echo "❌ Input file '$INPUT' not found"
	exit 1
fi

# Convert JSON to a temporary RenderCV YAML, then render PDF
if [[ "$INPUT" == *.json ]]; then
	YAML_INPUT=$(mktemp --suffix=.yaml)
	trap 'rm -f "$YAML_INPUT"' EXIT
	echo "Converting $INPUT → $PDF_OUTPUT (theme: $THEME)"
	uvx --from jsonresume-to-rendercv jsonresume_to_rendercv "$INPUT" "$YAML_INPUT"
else
	YAML_INPUT="$INPUT"
	echo "Rendering $YAML_INPUT → $PDF_OUTPUT (theme: $THEME)"
fi

ABS_OUTPUT="$(cd "$(dirname "$PDF_OUTPUT")" && pwd)/$(basename "$PDF_OUTPUT")"
uvx "rendercv[full]" render "$YAML_INPUT" \
	--design.theme "$THEME" \
	--pdf-path "$ABS_OUTPUT" \
	-nomd -nohtml -nopng

echo "✅ Generated $PDF_OUTPUT"
