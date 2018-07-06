#!/usr/bin/env bash

DOTDIR="${HOME}/dotfiles"
HOMEDIR="${HOME}"
printf "==> Setting up links to \n${DOTDIR} in \n${HOMEDIR}\n\n"
cd ${HOMEDIR}

for file in $(ls ${DOTDIR}); do
	if [[ ${file} =~ \.sh$ ]] || [[ ${file} =~ \.txt$ ]] ||
		[[ ${file} =~ \.rdoc$ ]] || [[ ${file} =~ \.dir$ ]]; then
		printf "==> Skipping ${file}\n"
	else
		printf "==> Processing ${file}\n"
		rm -rf .${file}
		ln -s ${DOTDIR}/${file} .${file}
	fi
done

echo ""

for LINKDIR in $(ls -d ${DOTDIR}/*.dir); do
	TARGETDIR="${HOMEDIR}/.$(basename ${LINKDIR} .dir)"
	mkdir -p ${TARGETDIR}
	printf "==> Setting up links to \n${LINKDIR} in \n${TARGETDIR}\n"
	cd ${TARGETDIR}
	for file in $(ls ${LINKDIR}); do
		printf "==> Processing ${file}\n"
		rm -rf ${file}
		ln -s ${LINKDIR}/${file} ${file}
	done
done
