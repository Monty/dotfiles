#!/usr/bin/env bash
# Replace XX... sections as appropriate
# XX <Basic description>
# shellcheck disable=SC2034

# Prevent cascading or pipe failures
set -euo pipefail

# trap and locate errors that might arise from pipefail
trap 'printf "${ERROR} at or near line %s:\n\t%s\n" \
    "$LINENO" "$BASH_COMMAND" >&2' ERR

# trap ctrl-c and SIGTERM -- call cleanup and exit
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM
#
function cleanup() {
    stty sane
    printf "\n"
}

ERROR="\e[0;31m[Error]\e[0m"
WARNING="\e[0;33m[Warning]\e[0m"
INFO="\e[0;34m[Info]\e[0m"

help() {
    cat <<EOF
bash-template-noArgs.sh <version number>

Copy and edit this template to create a bash script
that accepts options but no regular arguments.

USAGE:
    <command> [OPTIONS]

OPTIONS:
    -h | --help     Print this message.
    -d | --dry-run  Preview actions that would be taken
    -v | --verbose  See all actions that would normally have no output

EOF
}

# Check for options
DRY_RUN=false
VERBOSE=false
QUIET=false
while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
        help
        shift
        # or
        exit
        ;;
    -d | --dry-run)
        DRY_RUN=true
        shift
        ;;
    -v | --verbose)
        VERBOSE=true
        shift
        ;;
    -q | --quiet)
        QUIET=true
        shift
        ;;
    *)
        # shellcheck disable=SC2059
        if [[ $1 == -* ]]; then
            printf "${ERROR} Unknown option: %s\n" "$1"
            printf "${INFO}  Run with --help to see available options\n"
        else
            printf "${ERROR} Invalid argument: %s\n" "$1"
            printf "${INFO}  This script does not accept positional arguments\n"
        fi
        exit 1
        ;;
    esac
done

# Helper function to execute command unless in dry-run mode
maybe_run() {
    if [[ $DRY_RUN == false ]]; then
        "$@"
    fi
}

# shellcheck disable=SC2059
[[ $DRY_RUN == true ]] && printf "==> $INFO Starting dry run...\n\n"

# Explain before running
help

read -r -n 1 -s -p "Hit any key to continue, '^C' to quit. "
printf "\n\n"

[[ $VERBOSE == false ]] && printf "==> $INFO %s\n" \
    "XX <if not verbose>"

[[ $VERBOSE == true ]] && printf "==> $INFO %s\n" \
    "XX <if verbose>"

if [[ $VERBOSE == true ]]; then
    printf "==> $INFO %s\n" \
        "XX <long if verbose>"
else
    printf "==> $INFO %s\n" \
        "XX <long if not verbose>"
fi

# As many as needed -- replace everything after maybe_run
maybe_run printf "==> $INFO %s\n" "XX <maybe_run ran this command>"
