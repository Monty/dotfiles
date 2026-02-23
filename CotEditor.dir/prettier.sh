#!/usr/bin/env bash
# Used to format CSS, HTML, JSON, & YAML files in CotEditor

echo "$1" >/dev/stderr

"$HOME"/.volta/bin/prettier --write "$1"
