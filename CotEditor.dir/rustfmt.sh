#!/usr/bin/env bash
# Used to format Rust files in CotEditor

rustfmt_output=$("$HOME"/.cargo/bin/rustfmt "$1" 2>&1)
rustfmt_exit=$?

if [[ $rustfmt_exit -ne 0 ]]; then
    printf "rustfmt error (exit %s):\n" "$rustfmt_exit" >&2
    printf "%s\n" "$rustfmt_output" >&2
    osascript -e '
    tell application "CotEditor"
        display alert "rustfmt failed" message "See Console for details"
    end tell' >/dev/null
fi
