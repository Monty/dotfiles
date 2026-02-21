#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "" >/dev/stderr

"$HOME"/bin/shellcheck -s bash "$1" || true
