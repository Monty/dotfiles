#!/usr/bin/env bash
# Convert XML-tagged blocks to fenced markdown code blocks
# %%%{CotEditorXInput=None}%%%
# %%%{CotEditorXOutput=Discard}%%%

SYNTAX=$(osascript -e '
  tell application "CotEditor"
    get coloring style of front document
  end tell
')

FILEPATH=$(osascript -e '
  tell application "CotEditor"
    POSIX path of (get file of front document)
  end tell
')

# shellcheck disable=SC2016
case "$SYNTAX" in
"Markdown" | "Plain Text")
    "$HOME"/.cargo/bin/sd '^<div>$' '<div> ' "$FILEPATH"
    "$HOME"/.cargo/bin/sd '^<([a-z_][a-z_ ]+)>$' '```$1' "$FILEPATH"
    "$HOME"/.cargo/bin/sd '^</[a-z_][a-z_ ]+>$' '```' "$FILEPATH"
    ;;
*) osascript -e 'tell application "CotEditor"
  display alert "convertXML not available for '"$SYNTAX"' documents"
end tell' >/dev/null ;;
esac
