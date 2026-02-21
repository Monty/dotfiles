#!/bin/sh
# %%%{CotEditorXInput=AllText}%%%
# %%%{CotEditorXOutput=ReplaceAllText}%%%

/Users/monty/.swiftly/bin/swiftformat --swiftversion 6.2.3 --disable docComments --stdinpath "$1"
