#!/bin/sh
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "$1" >/dev/stderr

printf "$PATH" | tr ':' '\n' >/dev/stderr
echo ""
echo "ENV = $(env)"
