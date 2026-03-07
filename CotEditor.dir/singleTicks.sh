#!/usr/bin/env bash
# Surround CotEditor Inline Code with single backticks
# %%%{CotEditorXInput=Selection}%%%
# %%%{CotEditorXOutput=ReplaceSelection}%%%

SYNTAX=$(osascript -e '
    tell application "CotEditor"
        get coloring style of front document
    end tell
')

case "$SYNTAX" in
"Markdown" | "Plain Text")
    printf '`'
    cat
    printf '`'
    ;;
*) osascript -e '
    tell application "CotEditor"
        display alert "singleTicks not available for '"$SYNTAX"' documents"
    end tell' >/dev/null ;;
esac
