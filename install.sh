#!/usr/bin/env bash
# Create links in ~, ~/.config, and ~/.local/share to files in ~/dotfiles

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
INFO="\e[0;34m[Info]\e[0m"

help() {
    cat <<EOF
install.sh

Creates symbolic links from ~/dotfiles to standard locations in your
home directory.

LINKING RULES:
    Files in ~/dotfiles (without dot prefix):
        Linked as dotfiles in ~
        Example: ~/dotfiles/bashrc -> ~/.bashrc

    Alias file (~/dotfiles/aliases):
        Linked as both ~/.bash_aliases and ~/.zsh_aliases

    Directories in ~/dotfiles/config.dir:
        Linked into ~/.config
        Example: ~/dotfiles/config.dir/kitty -> ~/.config/kitty

    Fastfetch configuration:
        ~/dotfiles/config.dir/fastfetch -> ~/.local/share/fastfetch

USAGE:
    ./install.sh [OPTIONS]

OPTIONS:
    -h, --help      Show this help message and exit
    -d, --dry-run   Preview actions without making changes
    -v, --verbose   Show all actions including skipped links

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

# Helper function to create or skip symbolic links
# Usage: link_if_needed <source> <target> <label>
link_if_needed() {
    local source="$1"
    local target="$2"
    local label="${3:-$target}"
    if [[ -L ${target} ]] &&
        [[ "$(readlink "${target}")" == "${source}" ]]; then
        [[ $VERBOSE == true ]] &&
            printf "    Skipping %s\n" "$label"
        return 0
    else
        printf "    Linking %s\n" "${label}"
        maybe_run rm -rf "${target}"
        maybe_run ln -s "${source}" "${target}"
    fi
}

# shellcheck disable=SC2059
[[ $DRY_RUN == true ]] && printf "==> $INFO Starting dry run...\n\n"

DOTDIR="${HOME}/dotfiles"
cd "${HOME}" || exit

[[ $VERBOSE == false ]] && printf "%s\n" \
    "--- Note: Some sections may have no links to create or update"

printf "# Creating links to %s in %s\n" "${DOTDIR#"$HOME"/}" "${HOME}"

# Skip files with . in filename
if [[ $VERBOSE == true ]]; then
    for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg '\.'); do
        printf "    Ignoring %s\n" "${file}"
    done
fi

# Link files without . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg -v '\.'); do
    link_if_needed "${DOTDIR}/${file}" ".${file}" ".${file}"
done

# .bash_aliases and .zsh_aliases should both link to dotfiles/aliases
printf "# Creating links to dotfiles/aliases in %s\n" "${HOME}"
for aliasfile in .bash_aliases .zsh_aliases; do
    link_if_needed "${DOTDIR}/aliases" "${aliasfile}" "${aliasfile}"
done

# By convention, config files are kept in directories under ~/.config
# Create links in ~/.config to directories in dotfiles/config.dir
LINKDIR="${HOME}/dotfiles/config.dir"
TARGETDIR="${HOME}/.config"
maybe_run mkdir -p "${TARGETDIR}"
printf "# Creating links to %s in %s\n" \
    "${LINKDIR#"$HOME"/}" "${TARGETDIR#"$HOME"/}"
cd "${TARGETDIR}" || exit
for dir in $(eza -D "${LINKDIR}"); do
    link_if_needed "${LINKDIR}/${dir}" "${dir}" "${dir}"
done

# Special location required for fastfetch presets
LINKDIR="${LINKDIR}/fastfetch"
TARGETDIR="${HOME}/.local/share"
maybe_run mkdir -p "${TARGETDIR}"
printf "# Creating link to %s in %s\n" \
    "${LINKDIR#"$HOME"/}" "${TARGETDIR#"$HOME"/}"
link_if_needed "${LINKDIR}" "${TARGETDIR}/fastfetch" "fastfetch"
