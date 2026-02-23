#!/usr/bin/env bash
# Used to print $PATH and $env in CotEditor for debugging
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "$1" >/dev/stderr

printf "$PATH" | tr ':' '\n' >/dev/stderr
echo ""
echo "ENV = $(env)"
