#!/usr/bin/env bash

DOTDIR="${HOME}/dotfiles"
HOMEDIR="${HOME}"
printf "==> Setting up links to \n${DOTDIR} in \n${HOMEDIR}\n"
cd ${HOMEDIR}

echo ""

for file in $(ls ${DOTDIR}); do
	if [[ ${file} =~ \.sh$ ]] || [[ ${file} =~ \.txt$ ]] ||
		[[ ${file} =~ \.rdoc$ ]] || [[ ${file} =~ \.dir$ ]]; then
		echo "==> Skipping ${file}"
	else
		echo "==> Processing ${file}"
		echo "rm -rf .${file}"
		echo "ln -s ${DOTDIR}/${file} .${file}"
	fi
done

echo ""

for LINKDIR in $(ls -d ${DOTDIR}/*.dir); do
	TARGETDIR="${HOMEDIR}/.$(basename ${LINKDIR} .dir)"
	mkdir -p ${TARGETDIR}
	printf "==> Setting up links to \n${LINKDIR} in \n${TARGETDIR}\n"
    cd ${TARGETDIR}
    pwd
	for file in $(ls ${LINKDIR}); do
		if [[ ${file} =~ \.sh$ ]] || [[ ${file} =~ \.txt$ ]] ||
			[[ ${file} =~ \.rdoc$ ]] || [[ ${file} =~ \.dir$ ]]; then
			echo "==> Skipping ${file}"
		else
			echo "==> Processing ${file}"
			echo "rm -rf ${file}"
			echo "ln -s ${LINKDIR}/${file} ${file}"
		fi
	done
done
