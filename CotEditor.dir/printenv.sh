#!/usr/bin/env bash
# Used to print $PATH and $env in CotEditor for debugging
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

# shellcheck disable=SC2016,SC2059

echo '==> $PATH is:'
printf "$PATH" | tr ':' '\n'
echo ""
echo ""
echo '==> $env is:'
env
