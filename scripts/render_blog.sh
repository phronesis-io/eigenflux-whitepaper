#!/usr/bin/env bash
# Render one or more blog posts into print-ready PDFs.
#
# Usage:
#   scripts/render_blog.sh 01           # render blogs/01.md -> blogs/pdf/01.pdf
#   scripts/render_blog.sh 01 03        # render multiple chapters
#   scripts/render_blog.sh              # render all blogs/*.md
#   scripts/render_blog.sh all          # same as no arg
#
# Requires: pandoc, weasyprint (installed via homebrew).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CSS="${ROOT}/scripts/blog.css"
SRC_DIR="${ROOT}/blogs"
OUT_DIR="${ROOT}/blogs/pdf"

command -v pandoc >/dev/null     || { echo "pandoc not found (brew install pandoc)" >&2; exit 1; }
command -v weasyprint >/dev/null || { echo "weasyprint not found (brew install weasyprint)" >&2; exit 1; }

mkdir -p "$OUT_DIR"

render() {
    local n="$1"
    local src="${SRC_DIR}/${n}.md"
    local out="${OUT_DIR}/${n}.pdf"

    if [[ ! -f "$src" ]]; then
        echo "skip: $src not found" >&2
        return 0
    fi

    # Pull the H1 title from the markdown if present, else fall back to filename.
    local title
    title="$(awk '/^# / { sub(/^# /, ""); print; exit }' "$src")"
    [[ -z "$title" ]] && title="Blog $n"

    pandoc "$src" \
        --from=markdown+footnotes+smart \
        --to=html5 \
        --standalone \
        --pdf-engine=weasyprint \
        --css "$CSS" \
        --metadata title="$title" \
        -o "$out"

    echo "wrote $out"
}

if [[ $# -eq 0 || "${1:-}" == "all" ]]; then
    shopt -s nullglob
    for src in "${SRC_DIR}"/*.md; do
        render "$(basename "$src" .md)"
    done
else
    for arg in "$@"; do
        render "$arg"
    done
fi
