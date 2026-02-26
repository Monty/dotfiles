#!/usr/bin/env bash
# Used to print $PATH and $env in CotEditor for debugging
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "==> \$PATH is:"
# shellcheck disable=SC2059
printf "$PATH" | tr ':' '\n'
echo ""
echo ""
echo "==> \$env is:"
echo "$(env)"
