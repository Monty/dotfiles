#!/usr/bin/env bash
# Create links in ~, ~/.config, and ~/.local/share to files in ~/dotfiles

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
