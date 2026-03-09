#!/usr/bin/env bash
# Used to format CSS, HTML, JSON, & YAML files in CotEditor

prettier_output=$("$HOME"/.volta/bin/prettier --write "$1" 2>&1)
prettier_exit=$?

if [[ $prettier_exit -ne 0 ]]; then
    printf "Prettier error (exit %s):\n" "$prettier_exit" >&2
    printf "%s\n" "$prettier_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "Prettier failed" message "See Console for details"
    end tell' >/dev/null
fi
