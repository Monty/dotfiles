#!/usr/bin/env bash
# Used to format JavaScript files in CotEditor

eslint_output=$("$HOME"/.volta/bin/eslint --fix --config \
    "$HOME"/Projects/WhatsStreamingToday/eslint.config.mjs "$1" 2>&1)
eslint_exit=$?

# shellcheck disable=SC2059
if [[ $eslint_exit -eq 1 || $eslint_exit -eq 2 ]]; then
    printf "ESLint error (exit $eslint_exit):\n" >&2
    printf "$eslint_output\n" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "ESLint error (exit '"$eslint_exit"')" message "'"$eslint_output"'"
    end tell'
    exit 0
fi

"$HOME"/.volta/bin/prettier --write "$1"
