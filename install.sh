#! /bin/bash

DOTDIR=`pwd`
echo "==> Setting up $DOTDIR"
cd $HOME

for file in `ls $DOTDIR`; do
    if [[ "${file}" =~ \.sh$ ]] || [[ "${file}" =~ \.txt$ ]] \
    || [[ "${file}" =~ \.rdoc$ ]]; then
        echo "==> Skipping ${file}"
    else
        echo "==> Processing ${file}"
        rm -rf .${file}
        ln -s $DOTDIR/${file} .${file}
    fi
done
