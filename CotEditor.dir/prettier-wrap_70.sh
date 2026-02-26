#!/usr/bin/env bash
# Used to prose-wrap markdown files to 70 characters

"$HOME"/.volta/bin/prettier --prose-wrap always \
    --print-width 70 --write "$1"
