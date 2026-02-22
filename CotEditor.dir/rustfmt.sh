#!/usr/bin/env bash
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "$1" >/dev/stderr

"$HOME"/.cargo/bin/rustfmt "$1"
