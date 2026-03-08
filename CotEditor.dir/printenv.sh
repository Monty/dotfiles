#!/usr/bin/env bash
# Used to print $PATH and $env in CotEditor for debugging
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

# shellcheck disable=SC2016

printf '==> $PATH is:\n'
printf '%s' "$PATH" | tr ':' '\n'
printf '\n\n==> $env is:\n'
env
