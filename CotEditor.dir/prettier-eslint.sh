#!/usr/bin/env bash
# Used to format JavaScript files in CotEditor

"$HOME"/.volta/bin/eslint --fix --config \
    "$HOME"/Projects/WhatsStreamingToday/eslint.config.mjs "$1"

if [[ $? -ne 1 ]]; then
    "$HOME"/.volta/bin/prettier --write "$1"
fi
