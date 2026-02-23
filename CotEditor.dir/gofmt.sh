#!/usr/bin/env bash
# Used to format Go files in CotEditor

echo "$1" >/dev/stderr

/usr/local/go/bin/gofmt -w "$1"
