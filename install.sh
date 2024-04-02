#!/usr/bin/env bash

DOTDIR="${HOME}/dotfiles"
printf "# Setting up links to %s in %s\n" "${DOTDIR}" "${HOME}"
cd "${HOME}" || exit

# .bash_aliases and .zsh_aliases should both link to dotfiles/aliases
printf "==> Processing aliases\n"
rm -f .bash_aliases .zsh_aliases
printf "    Linking to .bash_aliases\n"
ln -s "${DOTDIR}"/aliases .bash_aliases
printf "    Linking to .zsh_aliases\n"
ln -s "${DOTDIR}"/aliases .zsh_aliases

for file in $(ls "${DOTDIR}"); do
    if [[ ${file} =~ aliases$ ]] ||               # Already proceesed above
        [[ ${file} =~ \. ]]; then                 # Skip files with . in filename
        printf "==> Skipping %s\n" "${file}"
    else
        printf "==> Linking %s\n" "${file}"
        rm -f ."${file}"
        ln -s "${DOTDIR}"/"${file}" ."${file}"    # Add leading . and link
    fi
done

echo ""

# By convention.link all files in any directories that end in .dir
# But strip the .dir first so .config links to dotfiles/config.dir
for LINKDIR in $(ls -d "${DOTDIR}"/*.dir); do
    TARGETDIR="${HOME}/.${LINKDIR##*/}"
    TARGETDIR="${TARGETDIR%.dir}"
    mkdir -p "${TARGETDIR}"
    printf "# Setting up links to %s in %s\n" "${LINKDIR}" "${TARGETDIR}"
    cd "${TARGETDIR}" || exit
    for file in $(ls "${LINKDIR}"); do
        printf "==> Linking %s\n" "${file}"
        rm -f "${file}"
        ln -s "${LINKDIR}"/"${file}" "${file}"
    done
done
