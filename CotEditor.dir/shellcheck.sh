#!/usr/bin/env bash
# Used to shellcheck Shell Scripts in CotEditor
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

SYNTAX=$(osascript -e '
    tell application "CotEditor"
      get coloring style of front document
    end tell
')

if [[ $SYNTAX != "Shell Script" ]]; then
    osascript -e '
    tell application "CotEditor"
        display alert "shellcheck not available for '"$SYNTAX"' documents"
    end tell' >/dev/null
    exit 0
fi

ERRORS=$("$HOME"/bin/shellcheck -s bash "$1")
if [[ -n $ERRORS ]]; then
    osascript -e '
    tell application "CotEditor"
        make new document
        set contents of front document to "'"$ERRORS"'"
    end tell' >/dev/null
fi
