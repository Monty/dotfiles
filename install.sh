#!/usr/bin/env bash
# Create appropriate links in ~ to files in ~/dotfiles

DOTDIR="${HOME}/dotfiles"
cd "${HOME}" || exit

printf "# Creating links to %s in %s\n" "${DOTDIR#$HOME/}" "${HOME}"
# Skip files with . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg '\.'); do
    printf "==> Skipping %s\n" "${file}"
done

# Link files without . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg -v '\.'); do
    printf "==> Linking .%s\n" "${file}"
    rm -f ."${file}"
    ln -s "${DOTDIR}"/"${file}" ."${file}" # Add a leading . and link
done

# .bash_aliases and .zsh_aliases should both link to dotfiles/aliases
printf "# Creating links to dotfiles/aliases\n"
rm -f .bash_aliases .zsh_aliases
printf "==> Linking .bash_aliases\n"
ln -s "${DOTDIR}"/aliases .bash_aliases
printf "==> Linking .zsh_aliases\n"
ln -s "${DOTDIR}"/aliases .zsh_aliases

# By convention, config files are kept in directories under ~/.config
# Create links in ~/.config to directories in dotfiles/config.dir
LINKDIR="${HOME}/dotfiles/config.dir"
TARGETDIR="${HOME}/.config"
mkdir -p "${TARGETDIR}"
printf "# Creating links to %s in %s\n" \
    "${LINKDIR#$HOME/}" "${TARGETDIR#$HOME/}"
cd "${TARGETDIR}" || exit
for dir in $(eza -D "${LINKDIR}"); do
    printf "==> Linking %s\n" "${dir}"
    rm -rf "${dir}"
    ln -s "${LINKDIR}"/"${dir}" "${dir}"
done
