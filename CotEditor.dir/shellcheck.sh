#!/usr/bin/env bash
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "$1" >/dev/stderr

"$HOME"/bin/shellcheck -s bash "$1" || true
