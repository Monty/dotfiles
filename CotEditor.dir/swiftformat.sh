#!/usr/bin/env bash
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "$1" >/dev/stderr

"$HOME"/.swiftly/bin/swiftformat --swiftversion 6.2.3 "$1"
