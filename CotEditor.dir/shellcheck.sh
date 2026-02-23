#!/usr/bin/env bash
# Used to shellcheck Shell Scripts in CotEditor
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "$1" >/dev/stderr

"$HOME"/bin/shellcheck -s bash "$1" || true
