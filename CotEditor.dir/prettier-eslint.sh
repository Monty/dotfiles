#!/usr/bin/env bash
# Used to format JavaScript files in CotEditor

eslint_output=$("$HOME"/.volta/bin/eslint --fix --config \
    "$HOME"/Projects/WhatsStreamingToday/eslint.config.mjs "$1" 2>&1)
eslint_exit=$?

if [[ $eslint_exit -ne 0 ]]; then
    printf "ESLint error (exit %s):\n" "$eslint_exit" >&2
    printf "%s\n" "$eslint_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "ESLint failed" message "See Console for details"
    end tell' >/dev/null
    exit 0
fi

"$HOME"/.volta/bin/prettier --write "$1"
