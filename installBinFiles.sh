#!/usr/bin/env bash
#
# Create appropriate links in ~/bin to files in ~/dotfiles/bin.dir

WARNING="\e[0;31m[Warning]\e[0m"

LINKDIR="${HOME}/dotfiles/bin.dir"
TARGETDIR="${HOME}/bin"

cd "${TARGETDIR}" || exit

printf "# Creating links to files in %s in %s\n" \
    "${LINKDIR#"$HOME"/}" "${TARGETDIR#"$HOME"/}"

for file in $(fd -d 1 -t f); do
    if [ -f "${LINKDIR}/${file}" ] && file "${LINKDIR}/${file}" |
        grep -q 'script text executable'; then
        if ! cmp -s "${file}" "${LINKDIR}/${file}"; then
            printf "==> $WARNING Skipping %s as %s is different\n" \
                "${file}" "${LINKDIR#"$HOME"/}/${file}"
        else
            printf "==> Linking %s\n" "${file}"
            ln -sf "${LINKDIR}/${file}" "${file}"
        fi
    else
        printf "==> Skipping %s\n" "${file}"
    fi
done
