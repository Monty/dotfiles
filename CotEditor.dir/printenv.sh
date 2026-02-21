#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "" >/dev/stderr

printf "$PATH" | tr ':' '\n' >/dev/stderr
echo ""

echo "FILE = $1"
echo ""
echo "ENV = $(env)"
