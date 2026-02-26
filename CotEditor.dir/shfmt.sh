#!/usr/bin/env bash
# Used to format Shell Scripts in CotEditor

"$HOME"/go/bin/shfmt -i 4 -s -w "$1"
