#!/bin/sh
# %%%{CotEditorXInput=AllText}%%%
# %%%{CotEditorXOutput=ReplaceAllText}%%%

echo "" >/dev/stderr

"$HOME"/.local/bin/ruff format --stdin-filename=script.py -
