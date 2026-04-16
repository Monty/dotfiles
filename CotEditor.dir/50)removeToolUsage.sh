#!/usr/bin/env bash
# Remove tool-use blocks from AI assistant chat exports
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

SCRIPT_DIR="$(cd "$(dirname "$0")/_lib" && pwd)"

FILEPATH=$(osascript -e '
    tell application "CotEditor"
        POSIX path of (get file of front document)
    end tell
')

TMPFILE=$(mktemp) || exit 1
trap 'rm -f "$TMPFILE"' EXIT

awk -f "$SCRIPT_DIR/remove_tools.awk" "$FILEPATH" >"$TMPFILE" &&
    mv "$TMPFILE" "$FILEPATH"
