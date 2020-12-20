#!/usr/bin/env bash

DIRNAME=$(dirname "$0")
cd $DIRNAME/vim/bundle

printf "==> Cloning vim bundles:\n"

for repo in https://github.com/vim-scripts/ScrollColors.git \
    https://github.com/tpope/vim-commentary.git \
    https://github.com/tpope/vim-fugitive.git \
    https://github.com/adelarsq/vim-matchit.git \
    https://github.com/dpc/vim-smarttabs.git \
    https://github.com/z0mbix/vim-shfmt.git \
    https://github.com/tpope/vim-unimpaired.git; do
    directory="$(basename -s .git $repo)"
    if [ -e "$directory" ]; then
        printf "$directory already exists.\n"
    else
        printf "Cloning $repo into $directory\n"
        git clone -q "$repo"
    fi
done

# Possible bundle candidates
# ScrollColors      Add :COLORSCROLL
# vim-commentary    Comment/Uncomment
# vim-fugitive      Add :git
# vim-matchit       Extended matching for the % operator
# vim-polyglot      A collection of language packs
# vim-sensible      Reasonabe settings
# vim-shfmt         Format shell scripts with :Shfmt -i 4 -s
# vim-smarttabs     Indent with tabs, align with spaces
# vim-unimpaired    Pairs of handy bracket mappings
