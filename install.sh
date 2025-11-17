#!/usr/bin/env bash
# Create links in ~, ~/.config, and ~/.local/share to files in ~/dotfiles

# Prevent cascading or pipe failures
set -euo pipefail

# Check for dry run arguments
DRY_RUN=false
case ${1-} in
"") ;; # no argument → no dry run, no error
-d | --dry-run)
    DRY_RUN=true
    printf "==> Starting dry run...\n"
    ;;
*)
    printf "[Warning] Ignoring invalid argument: '%s'\n" "$1" >&2
    exit 1
    ;;
esac

# Function to execute command unless in dry-run mode
maybe_run() {
    if [[ $DRY_RUN == false ]]; then
        "$@"
    fi
}

DOTDIR="${HOME}/dotfiles"
cd "${HOME}" || exit

printf "# Creating links to %s in %s\n" "${DOTDIR#"$HOME"/}" "${HOME}"

# Skip files with . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg '\.'); do
    printf "==> Ignoring %s\n" "${file}"
done

# Link files without . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg -v '\.'); do
    printf "==> Linking .%s\n" "${file}"
    maybe_run rm -f ."${file}"
    maybe_run ln -s "${DOTDIR}"/"${file}" ."${file}" # Add a leading . and link
done

# .bash_aliases and .zsh_aliases should both link to dotfiles/aliases
printf "# Creating links to dotfiles/aliases in %s\n" "${HOME}"
printf "==> Linking .bash_aliases\n"
maybe_run ln -sf "${DOTDIR}"/aliases .bash_aliases
printf "==> Linking .zsh_aliases\n"
maybe_run ln -sf "${DOTDIR}"/aliases .zsh_aliases

# By convention, config files are kept in directories under ~/.config
# Create links in ~/.config to directories in dotfiles/config.dir
LINKDIR="${HOME}/dotfiles/config.dir"
TARGETDIR="${HOME}/.config"
maybe_run mkdir -p "${TARGETDIR}"
printf "# Creating links to %s in %s\n" \
    "${LINKDIR#"$HOME"/}" "${TARGETDIR#"$HOME"/}"
cd "${TARGETDIR}" || exit
for dir in $(eza -D "${LINKDIR}"); do
    printf "==> Linking %s\n" "${dir}"
    maybe_run rm -rf "${dir}"
    maybe_run ln -s "${LINKDIR}"/"${dir}" "${dir}"
done

# Special location required for fastfetch presets
LINKDIR="${LINKDIR}/fastfetch"
TARGETDIR="${HOME}/.local/share"
maybe_run mkdir -p "${TARGETDIR}"
printf "# Creating link to %s in %s\n" \
    "${LINKDIR#"$HOME"/}" "${TARGETDIR#"$HOME"/}"
printf "==> Linking fastfetch\n"
maybe_run ln -sf "${LINKDIR}" "${TARGETDIR}"
