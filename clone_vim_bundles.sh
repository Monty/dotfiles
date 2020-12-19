#!/usr/bin/env bash

DIRNAME=$(dirname "$0")
cd $DIRNAME

printf "==> Vim bundles: \n"
printf "==> ScrollColors vim-fugitive vim-matchit vim-shfmt vim-smarttabs vim-unimpaired\n"

cd vim/bundle

git clone -q https://github.com/vim-scripts/ScrollColors.git
git clone -q https://github.com/tpope/vim-commentary.git
git clone -q https://github.com/tpope/vim-fugitive.git
git clone -q https://github.com/adelarsq/vim-matchit.git
git clone -q https://github.com/dpc/vim-smarttabs.git
git clone -q https://github.com/z0mbix/vim-shfmt.git
git clone -q https://github.com/tpope/vim-unimpaired.git
