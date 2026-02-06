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
bash-template-manyArgs.sh <version number>

Copy and edit this template to create a bash script
that accepts both options and regular arguments.

USAGE:
    <command> [OPTIONS] [FILE]...

ARGUMENTS:
    [FILE]...  File(s) to process

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
ARGS=()
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
        ARGS+=("$1")
        shift
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

# Argument with count
for i in "${!ARGS[@]}"; do
    printf 'Argument # %d: %s\n' "$((i + 1))" "${ARGS[$i]}"
done

# Argument without count
for i in ${ARGS[@]+"${ARGS[@]}"}; do
    printf 'Argument: %s\n' "${i}"
done

# As many as needed -- replace everything after maybe_run
maybe_run printf "==> $INFO %s\n" "XX <maybe_run ran this command>"
