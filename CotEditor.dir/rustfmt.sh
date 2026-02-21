#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "" >/dev/stderr

"$HOME"/.cargo/bin/rustfmt "$1"
