#!/usr/bin/env bash
# Used to format Go files in CotEditor

gofmt_output=$(/usr/local/go/bin/gofmt -w "$1" 2>&1)
gofmt_exit=$?

if [[ $gofmt_exit -ne 0 ]]; then
    printf "gofmt error (exit %s):\n" "$gofmt_exit" >&2
    printf "%s\n" "$gofmt_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "gofmt failed" message "See Console for details"
    end tell' >/dev/null
fi
