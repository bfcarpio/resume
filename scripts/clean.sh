#!/usr/bin/env bash
set -euo pipefail

# Generated RenderCV YAML
if [ -f rendercv.yaml ]; then
	if [ -L rendercv.yaml ]; then
		echo "❌ rendercv.yaml is a symlink — refusing to remove"
		exit 1
	fi
	rm rendercv.yaml
	echo "✅ Removed rendercv.yaml"
fi

# Generated PDFs & HTML
shopt -s nullglob
pdfs=(*.pdf *.html)
if [ ${#pdfs[@]} -gt 0 ]; then
	rm "${pdfs[@]}"
	echo "✅ Removed ${#pdfs[@]} PDF(s) or HTML(s): ${pdfs[*]}"
else
	echo "ℹ️  No PDFs or HTMLs to remove"
fi

# Node stuff
nd=("package*.json")
for item in "${nd[@]}"; do
	if [ -f "$item" ]; then
		rm "$item"
		echo "✅ Removed $item"
	fi
done

# RenderCV intermediate output
if [ -d rendercv_output ]; then
	rm -rf rendercv_output
	echo "✅ Removed rendercv_output/"
fi

# Node modules
if [ -d node_modules ]; then
	rm -rf node_modules
	echo "✅ Removed node_modules/"
fi
# Collected PDFs
if [ -d output ]; then
	rm -rf output
	echo "✅ Removed output/"
fi
