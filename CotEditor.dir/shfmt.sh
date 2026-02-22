#!/usr/bin/env bash
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=ReplaceAllText}%%%

echo "$1" >/dev/stderr

"$HOME"/go/bin/shfmt -i 4 -s "$1"
