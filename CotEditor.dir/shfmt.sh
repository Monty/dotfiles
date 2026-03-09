#!/usr/bin/env bash
# Used to format Shell Scripts in CotEditor

shfmt_output=$("$HOME"/go/bin/shfmt -i 4 -s -w "$1" 2>&1)
shfmt_exit=$?

if [[ $shfmt_exit -ne 0 ]]; then
    printf "shfmt error (exit %s):\n" "$shfmt_exit" >&2
    printf "%s\n" "$shfmt_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "shfmt failed" message "See Console for details"
    end tell' >/dev/null
fi
