#!/usr/bin/env bash
# Replace XX ... XX sections as appropriate
# XX <Basic description> XX
# shellcheck disable=SC2034

# Prevent cascading or pipe failures
set -euo pipefail

ERROR="\e[0;31m[Error]\e[0m"
WARNING="\e[0;33m[Warning]\e[0m"
INFO="\e[0;34m[Info]\e[0m"

# Check for either dry run or verbose option
DRY_RUN=false
VERBOSE=false
while [[ $# -gt 0 ]]; do
    case $1 in
    -d | --dry-run)
        DRY_RUN=true
        shift
        ;;
    -v | --verbose)
        VERBOSE=true
        shift
        ;;
    *)
        printf "$ERROR Invalid argument: '%s'\n" "$1" >&2
        exit 1
        ;;
    esac
done

# shellcheck disable=SC2059
if [[ $DRY_RUN == true ]]; then
    printf "==> $INFO Starting dry run...\n\n"
fi

# Helper function to execute command unless in dry-run mode
maybe_run() {
    if [[ $DRY_RUN == false ]]; then
        "$@"
    fi
}

cat <<EOF >&2
This will XX <what it will do> XX
    Use "-d | --dry-run" to preview actions that would be taken
    Use "-v | --verbose" to see every action

EOF

read -r -n 1 -s -p "Hit any key to continue, '^C' to quit. "
printf "\n\n"

[[ $VERBOSE == false ]] && printf "==> $INFO %s\n" \
    "XX <if not verbose> XX"

[[ $VERBOSE == true ]] && printf "==> $INFO %s\n" \
    "XX <if verbose> XX"

# As many as needed -- replace everything after maybe_run
maybe_run printf "==> $INFO %s\n" "XX <maybe_run ran this command> XX"
