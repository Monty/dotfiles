#!/usr/bin/env bash
# Used to format Python files in CotEditor

ruff_output=$("$HOME"/.local/bin/ruff format --no-cache "$1" 2>&1)
ruff_exit=$?

if [[ $ruff_exit -ne 0 ]]; then
    printf "ruff error (exit %s):\n" "$ruff_exit" >&2
    printf "%s\n" "$ruff_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "ruff failed" message "See Console for details"
    end tell' >/dev/null
fi
