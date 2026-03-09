#!/usr/bin/env bash
# Map CotEditor syntax types to line wrap scripts in _lib
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SYNTAX=$(osascript -e '
    tell application "CotEditor"
        get coloring style of front document
    end tell
')

FILEPATH=$(osascript -e '
    tell application "CotEditor"
        POSIX path of (get file of front document)
    end tell
')

case "$SYNTAX" in
"Markdown") "$SCRIPT_DIR/_lib/prettier-wrap_70.sh" "$FILEPATH" ;;
"Plain Text") "$SCRIPT_DIR/_lib/fmt-wrap_70.sh" "$FILEPATH" ;;
*) osascript -e '
    tell application "CotEditor"
        display alert "LineWrap not available for '"$SYNTAX"' documents"
    end tell' >/dev/null ;;
esac
