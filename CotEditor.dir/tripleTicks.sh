#!/usr/bin/env bash
# Fence CotEditor Code Blocks with triple backticks
# %%%{CotEditorXInput=Selection}%%%
# %%%{CotEditorXOutput=ReplaceSelection}%%%

SYNTAX=$(osascript -e '
    tell application "CotEditor"
        get coloring style of front document
    end tell
')

case "$SYNTAX" in
"Markdown" | "Plain Text")
    printf '```\n'
    cat
    printf '\n```\n'
    ;;
*) osascript -e '
    tell application "CotEditor"
        display alert "tripleTicks not available for '"$SYNTAX"' documents"
    end tell' >/dev/null ;;
esac
