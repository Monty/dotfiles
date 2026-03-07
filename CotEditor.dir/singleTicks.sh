#!/usr/bin/env bash
# Surround CotEditor Inline Code with single backticks
# %%%{CotEditorXInput=Selection}%%%
# %%%{CotEditorXOutput=ReplaceSelection}%%%

printf '`'
cat
printf '`'
