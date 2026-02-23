#!/usr/bin/env bash
# Used to format AWK files in CotEditor

echo "$1" >/dev/stderr

cd "$HOME"/Projects/WhatsStreamingToday/hidden

"$HOME"/.volta/bin/prettier --write "$1" || true
