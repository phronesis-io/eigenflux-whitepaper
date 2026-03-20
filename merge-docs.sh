#!/bin/bash
# Merge all doc chapters into a single file (excluding outline)
# Usage: ./merge-docs.sh [output_file]
#   default output: docs/full.md

DIR="docs"
OUT="${1:-docs/full.md}"

# Find chapter files in order, skip outline
files=$(ls "$DIR"/[0-9]*.md 2>/dev/null | grep -v outline | sort)

if [ -z "$files" ]; then
  echo "No chapter files found in $DIR/" >&2
  exit 1
fi

> "$OUT"
first=true
for f in $files; do
  if $first; then
    first=false
  else
    printf '\n\n---\n\n' >> "$OUT"
  fi
  cat "$f" >> "$OUT"
done

echo "Merged $(echo "$files" | wc -l | tr -d ' ') files → $OUT"
