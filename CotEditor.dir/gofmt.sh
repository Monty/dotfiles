#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

echo "" >/dev/stderr

/usr/local/go/bin/gofmt -w "$1"
