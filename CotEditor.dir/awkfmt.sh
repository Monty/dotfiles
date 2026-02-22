#!/usr/bin/env bash
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "$1" >/dev/stderr

cd "$HOME"/Projects/WhatsStreamingToday/hidden

"$HOME"/.volta/bin/prettier --write "$1" || true
