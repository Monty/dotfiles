#!/usr/bin/env bash
# Create links in ~/bin to files in ~/dotfiles/bin.dir

# Prevent cascading or pipe failures
set -euo pipefail

# trap ctrl-c and SIGTERM -- call cleanup and exit
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM
#
function cleanup() {
    stty sane
    printf "\n"
}

ERROR="\e[0;31m[Error]\e[0m"
WARNING="\e[0;31m[Warning]\e[0m"
INFO="\e[0;34m[Info]\e[0m"

help() {
    cat <<EOF
installBinFiles.sh

Creates symbolic links in ~/bin pointing to executable scripts in
~/dotfiles/bin.dir, allowing your scripts to be version-controlled
while remaining accessible in your PATH.

BEHAVIOR:
    - Only links files that exist in both locations with identical content
    - Only processes executable script files (non-scripts are ignored)
    - Skips files with content mismatches (warns instead of overwriting)
    - Updates existing links to point to the correct location

EXAMPLE:
    ~/dotfiles/bin.dir/findShow -> ~/bin/findShow

USAGE:
    ./installBinFiles.sh [OPTIONS]

OPTIONS:
    -h, --help      Show this help message and exit
    -d, --dry-run   Preview actions without making changes
    -v, --verbose   Show all actions including skipped/ignored files

EOF
}

# Check for options
DRY_RUN=false
VERBOSE=false
while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
        help
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
    *)
        printf "$ERROR Invalid argument: '%s'\n" "$1" >&2
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

LINKDIR="${HOME}/dotfiles/bin.dir"
TARGETDIR="${HOME}/bin"

cd "${TARGETDIR}" || exit

[[ $VERBOSE == false ]] && printf "%s\n" \
    "--- Note: There may be no links to create"

printf "# Creating links to files in ~/%s in ~/%s\n" \
    "${LINKDIR#"$HOME"/}" "${TARGETDIR#"$HOME"/}"

for file in $(fd -d 1 -t f); do
    if [[ -f "${LINKDIR}/${file}" ]] && file "${LINKDIR}/${file}" |
        grep -q 'script text executable'; then
        if ! cmp -s "${file}" "${LINKDIR}/${file}"; then
            printf "==> $WARNING Skipping %s as ~/%s is different\n" \
                "${file}" "${LINKDIR#"$HOME"/}/${file}"
        else
            printf "    Linking %s\n" "${file}"
            maybe_run ln -sf "${LINKDIR}/${file}" "${file}"
        fi
    else
        [[ $VERBOSE == true ]] && printf "    Ignoring %s\n" "${file}"
    fi
done
