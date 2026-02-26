#!/usr/bin/env bash
# Used to format AWK files in CotEditor

cd "$HOME"/Projects/WhatsStreamingToday/hidden || exit

"$HOME"/.volta/bin/prettier --write "$1" || true
