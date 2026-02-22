#!/usr/bin/env bash
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "$1" >/dev/stderr

"$HOME"/.volta/bin/prettier --write "$1"
