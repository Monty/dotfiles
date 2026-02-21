#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "" >/dev/stderr

"$HOME"/.local/bin/ruff format "$1"
