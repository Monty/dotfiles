#!/usr/bin/env bash
# Used to format Shell Scripts in CotEditor

echo "$1" >/dev/stderr

"$HOME"/go/bin/shfmt -i 4 -s -w "$1"
