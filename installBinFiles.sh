#!/usr/bin/env bash
# Create links in ~/bin to files in ~/dotfiles/bin.dir

# Prevent cascading or pipe failures
set -euo pipefail

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
        printf "[Error] Invalid argument: '%s'\n" "$1" >&2
        exit 1
        ;;
    esac
done

if [[ $DRY_RUN == true ]]; then
    printf "==> Starting dry run...\n\n"
fi

# Helper function to execute command unless in dry-run mode
maybe_run() {
    if [[ $DRY_RUN == false ]]; then
        "$@"
    fi
}

WARNING="\e[0;31m[Warning]\e[0m"

LINKDIR="${HOME}/dotfiles/bin.dir"
TARGETDIR="${HOME}/bin"

cd "${TARGETDIR}" || exit

[[ $VERBOSE == false ]] && printf "%s\n" \
    "--- Note: There may be no links to create"

printf "# Creating links to files in %s in %s\n" \
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
