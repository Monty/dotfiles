#!/usr/bin/env bash

DOTDIR="${HOME}/dotfiles"
printf "==> Setting up links to ${DOTDIR} \n    in ${HOME}\n\n"
cd ${HOME} || exit

printf "==> Processing aliases\n"
rm -f .bash_aliases .zsh_aliases
printf "    Linking to .bash_aliases\n"
ln -s ${DOTDIR}/aliases .bash_aliases
printf "    Linking to .zsh_aliases\n"
ln -s ${DOTDIR}/aliases .zsh_aliases

for file in $(ls ${DOTDIR}); do
    if [[ ${file} =~ aliases$ ]] ||
        [[ ${file} =~ \. ]]; then
        printf "==> Skipping ${file}\n"
    else
        printf "==> Linking ${file}\n"
        rm -f .${file}
        ln -s ${DOTDIR}/${file} .${file}
    fi
done

echo ""

for LINKDIR in $(ls -d ${DOTDIR}/*.dir); do
    TARGETDIR="${HOME}/.$(basename ${LINKDIR} .dir)"
    mkdir -p ${TARGETDIR}
    printf "==> Setting up links to ${LINKDIR} \n    in ${TARGETDIR}\n"
    cd ${TARGETDIR}
    for file in $(ls ${LINKDIR}); do
        printf "==> Linking ${file}\n"
        rm -f ${file}
        ln -s ${LINKDIR}/${file} ${file}
    done
done
