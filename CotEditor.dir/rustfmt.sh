#!/usr/bin/env bash
# Used to format Rust files in CotEditor

echo "$1" >/dev/stderr

"$HOME"/.cargo/bin/rustfmt "$1"
