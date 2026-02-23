#!/usr/bin/env bash
# Used to format JavaScript files in CotEditor

echo "$1" >/dev/stderr

"$HOME"/.volta/bin/eslint --fix --config \
    "$HOME"/Projects/WhatsStreamingToday/eslint.config.mjs "$1"

if [[ $? -ne 1 ]]; then
    "$HOME"/.volta/bin/prettier --write "$1"
fi
