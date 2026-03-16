#!/usr/bin/env bash
# Used to format Swift files in CotEditor

swiftformat_output=$("$HOME"/.swiftly/bin/swiftformat \
    --swiftversion 6.2.4 "$1" 2>&1)
swiftformat_exit=$?

if [[ $swiftformat_exit -ne 0 ]]; then
    printf "swiftformat error (exit %s):\n" "$swiftformat_exit" >&2
    printf "%s\n" "$swiftformat_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "swiftformat failed" message "See Console for details"
    end tell' >/dev/null
fi
