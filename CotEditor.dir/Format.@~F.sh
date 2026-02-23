#!/usr/bin/env bash
# Map CotEditor syntax types to formatting scripts

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

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

# shellcheck disable=SC2154
case "$SYNTAX" in
"AWK") "$SCRIPT_DIR/_lib/awkfmt.sh" "$FILEPATH" ;;
"CSS" | "HTML" | "JSON" | "YAML")
    "$SCRIPT_DIR/_lib/prettier.sh" "$FILEPATH"
    ;;
"Go") "$SCRIPT_DIR/_lib/gofmt.sh" "$FILEPATH" ;;
"JavaScript") "$SCRIPT_DIR/_lib/jsfmt.sh" "$FILEPATH" ;;
"Python") "$SCRIPT_DIR/_lib/ruff.sh" "$FILEPATH" ;;
"Rust") "$SCRIPT_DIR/_lib/rustfmt.sh" "$FILEPATH" ;;
"Shell Script") "$SCRIPT_DIR/_lib/shfmt.sh" "$FILEPATH" ;;
"Swift") "$SCRIPT_DIR/_lib/swiftformat.sh" "$FILEPATH" ;;
*) osascript -e "tell app \"CotEditor\" to display alert \
     \"No formatter for '$SYNTAX'\"" ;;
esac
