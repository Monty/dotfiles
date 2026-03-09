#!/usr/bin/env bash
# Install scripts in CotEditor directory

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
WARNING="\e[0;31m[Warning]\e[0m"
INFO="\e[0;34m[Info]\e[0m"

help() {
    cat <<EOF
installCotEditorFiles.sh

Copies CotEditor scripts into the CotEditor Application Scripts directory,
organizing top-level scripts & library scripts into the correct locations.

BEHAVIOR:
    - Top-level scripts (filenames starting with a digit) are copied
      to the CotEditor scripts directory
    - Library scripts (filenames not starting with a digit) are copied
      to the _lib subdirectory
    - Only copies files that are new or have changed (skips identical files)
    - Warns about unknown files in the CotEditor directory
    - Warns if the CotEditor scripts directory does not exist

EXAMPLE:
    ./installScripts
    ./installScripts --dry-run --verbose

USAGE:
    ./installScripts [OPTIONS]

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
        # shellcheck disable=SC2059
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

SCRIPTDIR="$HOME/Library/Application Scripts/com.coteditor.CotEditor"
LIBDIR="$SCRIPTDIR/_lib"

cd "$HOME/dotfiles/CotEditor.dir" || exit

printf "The script directory is:\n"
printf '"%s"\n' "${SCRIPTDIR/$HOME/\$HOME}"
printf "\n"

if [[ -d $SCRIPTDIR ]]; then
    maybe_run mkdir -p "$LIBDIR"

    # Helper: copy file only if destination is missing or content has changed
    install_file() {
        local src="$1" dest="$2"
        if [[ ! -f $dest ]]; then
            printf "    Installing %s (new)\n" "$src"
            maybe_run cp -p "$src" "$dest"
        elif ! cmp -s "$src" "$dest"; then
            printf "    Updating %s (changed)\n" "$src"
            maybe_run cp -p "$src" "$dest"
        else
            if [[ $VERBOSE == true ]]; then
                # shellcheck disable=SC2059
                printf "    Skipping %s (unchanged)\n" "$src"
            fi
        fi
    }

    # Track all source filenames so we can detect unknowns later
    declare -a known_top=()
    declare -a known_lib=()

    # Top-level scripts (start with a digit)
    while read -r file; do
        known_top+=("$file")
        install_file "$file" "$SCRIPTDIR/$file"
    done < <(fd -d 1 -t f '^[0-9]')

    # Library scripts (don't start with a digit)
    while read -r file; do
        known_lib+=("$file")
        install_file "$file" "$LIBDIR/$file"
    done < <(fd -d 1 -t f '^[^0-9]')

    # Warn about files in SCRIPTDIR not managed by this script
    while read -r dest_file; do
        base="$(basename "$dest_file")"
        found=false
        for k in "${known_top[@]:-}"; do
            [[ $k == "$base" ]] && found=true && break
        done
        # shellcheck disable=SC2059
        [[ $found == false ]] && printf "==> $WARNING Unknown file in ~/%s: %s\n" \
            "${SCRIPTDIR#"$HOME"/}" "$base"
    done < <([[ -d $SCRIPTDIR ]] && fd -d 1 -t f . "$SCRIPTDIR" || true)

    # Warn about files in LIBDIR not managed by this script
    while read -r dest_file; do
        base="$(basename "$dest_file")"
        found=false
        for k in "${known_lib[@]:-}"; do
            [[ $k == "$base" ]] && found=true && break
        done
        # shellcheck disable=SC2059
        [[ $found == false ]] && printf "==> $WARNING Unknown file in ~/%s: %s\n" \
            "${LIBDIR#"$HOME"/}" "$base"
    done < <([[ -d $LIBDIR ]] && fd -d 1 -t f . "$LIBDIR" || true)

    if [[ $VERBOSE == true ]]; then
        printf "\nCotEditor scripts directory:\n"
        eza -lT "$SCRIPTDIR"
    fi
else
    # shellcheck disable=SC2059
    printf "==> $WARNING The script directory does not exist, no scripts were copied.\n"
fi
