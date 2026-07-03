#!/usr/bin/env bash
set -euo pipefail

FILE="rendercv.yaml"

if [ -f "$FILE" ]; then
	if [ -L "$FILE" ]; then
		echo "❌ $FILE is a symlink — refusing to remove"
		exit 1
	fi
	rm "$FILE"
	echo "✅ Removed $FILE"
else
	echo "ℹ️  $FILE does not exist — nothing to do"
fi
