#!/usr/bin/env bash
# Used to format Python files in CotEditor

echo "$1" >/dev/stderr

"$HOME"/.local/bin/ruff format --no-cache "$1"
