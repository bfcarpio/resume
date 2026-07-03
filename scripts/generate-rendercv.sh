#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-resume.json}"
OUTPUT="${2:-rendercv.yaml}"

if [ ! -f "$INPUT" ]; then
  echo "❌ Input file '$INPUT' not found"
  exit 1
fi

if ! command -v uvx >/dev/null 2>&1
then
    echo "uvx could not be found"
    exit 1
fi

echo "Converting $INPUT → $OUTPUT"
uvx --from jsonresume-to-rendercv jsonresume_to_rendercv "$INPUT" "$OUTPUT"
echo "✅ Generated $OUTPUT"
