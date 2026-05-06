#!/usr/bin/env python3
"""
Reproduces the token-count claim in blogs/01.md: that the January 2025 FOMC
press release is ~16k tokens of HTML wrapping a few hundred tokens of actual
policy substance.

Usage:
    python3 scripts/measure_fomc_tokens.py

Inputs:
    scripts/data/monetary20250129a.htm — raw HTML of the press release,
    fetched once and committed for archival reproducibility:

        curl -sSL -o scripts/data/monetary20250129a.htm \\
            https://www.federalreserve.gov/newsevents/pressreleases/monetary20250129a.htm

Tokenizer: cl100k_base (the encoding used by GPT-4 / GPT-3.5-turbo).

The "core policy statement" is defined as the substantive policy paragraphs
inside <div id="article">, stopping before the voting roll-call paragraph.
"""
from __future__ import annotations

import sys
from html.parser import HTMLParser
from pathlib import Path

import tiktoken

HTML_PATH = Path(__file__).parent / "data" / "monetary20250129a.htm"
ENCODING_NAME = "cl100k_base"


class StatementExtractor(HTMLParser):
    """Pull the policy paragraphs from inside <div id="article">.

    Stops at the first <p> beginning with "Voting for" — the canonical
    boundary between the policy statement and the roll-call.
    """

    def __init__(self) -> None:
        super().__init__()
        self._article_depth = 0
        self._in_article = False
        self._in_p = False
        self._stop = False
        self._paragraphs: list[list[str]] = []
        self._current: list[str] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        if self._stop:
            return
        attr_dict = dict(attrs)
        if tag == "div":
            if self._in_article:
                self._article_depth += 1
            elif attr_dict.get("id") == "article":
                self._in_article = True
                self._article_depth = 1
        elif tag == "p" and self._in_article:
            self._in_p = True
            self._current = []

    def handle_endtag(self, tag: str) -> None:
        if self._stop:
            return
        if tag == "div" and self._in_article:
            self._article_depth -= 1
            if self._article_depth == 0:
                self._in_article = False
        elif tag == "p" and self._in_p:
            text = "".join(self._current).strip()
            if text.startswith("Voting for"):
                self._stop = True
                return
            if text:
                self._paragraphs.append(self._current)
            self._in_p = False
            self._current = []

    def handle_data(self, data: str) -> None:
        if self._in_p and not self._stop:
            self._current.append(data)

    def text(self) -> str:
        return "\n\n".join("".join(p).strip() for p in self._paragraphs).strip()


def main() -> int:
    if not HTML_PATH.exists():
        print(f"missing {HTML_PATH}; see docstring for fetch command", file=sys.stderr)
        return 1

    html = HTML_PATH.read_text()
    enc = tiktoken.get_encoding(ENCODING_NAME)

    full_tokens = len(enc.encode(html))

    parser = StatementExtractor()
    parser.feed(html)
    statement = parser.text()
    statement_tokens = len(enc.encode(statement))

    waste_pct = (1 - statement_tokens / full_tokens) * 100

    print(f"file:              {HTML_PATH.name}")
    print(f"encoding:          {ENCODING_NAME}")
    print(f"full HTML tokens:  {full_tokens:>6,}")
    print(f"statement tokens:  {statement_tokens:>6,}")
    print(f"overhead:          {waste_pct:>6.1f}%")
    print()
    print("--- core statement ---")
    print(statement)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
