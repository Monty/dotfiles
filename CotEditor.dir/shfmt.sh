#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=ReplaceAllText}%%%

echo "" >/dev/stderr

"$HOME"/go/bin/shfmt -i 4 -s "$1"
