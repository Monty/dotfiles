#!/bin/sh
# %%%{CotEditorXInput=AllText}%%%
# %%%{CotEditorXOutput=ReplaceAllText}%%%

echo "" >/dev/stderr

"$HOME"/.cargo/bin/rustfmt
