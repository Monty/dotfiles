#!/usr/bin/env bash
# Used to format Swift files in CotEditor

echo "$1" >/dev/stderr

"$HOME"/.swiftly/bin/swiftformat --swiftversion 6.2.3 "$1"
