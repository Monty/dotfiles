#!/usr/bin/env bash
# Used to shellcheck Shell Scripts in CotEditor
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

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
    printf "==> Error: shellcheck not available for %s documents\n" "$SYNTAX"
    exit 0
fi

ERRORS=$("$HOME"/bin/shellcheck -s bash "$1")
if [[ -n $ERRORS ]]; then
    printf "shellcheck %s\n" "$1"
    printf "==> Found the following errors:\n"
    printf "%s\n" "$ERRORS"
else
    printf "shellcheck %s\n" "$1"
    printf "==> Found no errors\n"
fi
