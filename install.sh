#!/usr/bin/env bash

DOTDIR="${HOME}/dotfiles"
cd "${HOME}" || exit

printf "# Setting up links to %s in %s\n" "${DOTDIR}" "${HOME}"
# Skip files with . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg '\.'); do
    printf "==> Skipping %s\n" "${file}"
done

# Link files with . in filename
for file in $(eza -1 "${DOTDIR}" | rg -v "aliases$" | rg -v '\.'); do
    printf "==> Linking .%s\n" "${file}"
    rm -f ."${file}"
    ln -s "${DOTDIR}"/"${file}" ."${file}" # Add a leading . and link
done

# .bash_aliases and .zsh_aliases should both link to dotfiles/aliases
printf "==> Processing aliases\n"
rm -f .bash_aliases .zsh_aliases
printf "    Linking to .bash_aliases\n"
ln -s "${DOTDIR}"/aliases .bash_aliases
printf "    Linking to .zsh_aliases\n"
ln -s "${DOTDIR}"/aliases .zsh_aliases

# eslint.config.mjs belongs in the home directory
printf "==> Linking eslint.config.mjs\n"
rm -f eslint.config.mjs
ln -s "${DOTDIR}"/eslint.config.mjs eslint.config.mjs
echo ""

# By convention.link all files in any directories that end in .dir
# But strip the .dir first so .config links to dotfiles/config.dir
for LINKDIR in $(eza -d "${DOTDIR}"/*.dir); do
    TARGETDIR="${HOME}/.${LINKDIR##*/}"
    TARGETDIR="${TARGETDIR%.dir}"
    mkdir -p "${TARGETDIR}"
    printf "# Setting up links to %s in %s\n" "${LINKDIR}" "${TARGETDIR}"
    cd "${TARGETDIR}" || exit
    for file in $(eza "${LINKDIR}"); do
        printf "==> Linking %s\n" "${file}"
        rm -f "${file}"
        ln -s "${LINKDIR}"/"${file}" "${file}"
    done
done
