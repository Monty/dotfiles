#!/usr/bin/env bash
# Used to line wrap text files to 70 characters

trap 'rm -f "$TMPFILE"' EXIT

TMPFILE=$(mktemp) || exit 1
fmt -w 70 "$1" >"$TMPFILE"
cp -p "$TMPFILE" "$1"
