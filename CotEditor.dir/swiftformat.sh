#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "" >/dev/stderr

"$HOME"/.swiftly/bin/swiftformat --swiftversion 6.2.3 \
    --disable docComments "$1"
