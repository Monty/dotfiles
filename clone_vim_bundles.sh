#!/usr/bin/env bash

DIRNAME=$(dirname "$0")
cd $DIRNAME/vim/bundle

printf "==> Cloning vim bundles:\n"

for repo in https://github.com/vim-scripts/ScrollColors.git \
    https://github.com/tpope/vim-commentary.git \
    https://github.com/tpope/vim-fugitive.git \
    https://github.com/adelarsq/vim-matchit.git \
    https://github.com/z0mbix/vim-shfmt.git \
    https://github.com/dpc/vim-smarttabs.git \
    https://github.com/micarmst/vim-spellsync.git \
    https://github.com/tpope/vim-unimpaired.git; do
    directory="$(basename -s .git $repo)"
    if [ -e "$directory" ]; then
        printf "$directory already exists.\n"
    else
        printf "Cloning $repo into $directory\n"
        git clone -q "$repo"
    fi
done

# Reasonable bundle candidates
# ScrollColors      Add :COLORSCROLL
# vim-commentary    Comment/Uncomment
# vim-fugitive      Add :git
# vim-matchit       Extended matching for the % operator
# vim-shfmt         Format shell scripts with :Shfmt -i 4 -s
# vim-smarttabs     Indent with tabs, align with spaces
# vim-spellsync     Regenerate Vim spell files from word lists at startup.
# vim-unimpaired    Pairs of handy bracket mappings

# Possible future bundle candidates
# vim-polyglot      A collection of language packs      https://github.com/sheerun/vim-polyglot.git
# vim-sensible      Reasonable settings                  https://github.com/tpope/vim-sensible.git
