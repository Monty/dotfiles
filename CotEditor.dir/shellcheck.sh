#!/bin/sh
# %%%{CotEditorXInput=AllText}%%%
# %%%{CotEditorXOutput=NewDocument}%%%

echo "" >/dev/stderr

"$HOME"/bin/shellcheck -s bash - || true
