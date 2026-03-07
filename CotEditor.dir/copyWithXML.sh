#!/usr/bin/env bash
# Copy CotEditor selection wrapped in appropriate XML tags
# %%%{CotEditorXInput=Selection}%%%
# %%%{CotEditorXOutput=Pasteboard}%%%

SYNTAX=$(osascript -e '
  tell application "CotEditor"
    get coloring style of front document
  end tell
')

case "$SYNTAX" in
"Plain Text") XML="command_output" ;;
*) XML="$SYNTAX" ;;
esac

printf "<%s>\n" "$XML"
cat
printf "</%s>\n" "$XML"
