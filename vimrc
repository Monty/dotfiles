call pathogen#infect()
call pathogen#helptags()

set nocompatible          " We're running Vim, not Vi!
set ignorecase            " Case-insensitive search
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

if has('gui_running')
    set background=light
else
    set background=dark
endif
colorscheme solarized

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent Ruby with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
  " autoindent Topaz with four spaces, always expand tabs
  au BufNewFile,BufReadPost *.topaz set ai sw=4 sts=8 et
  " Keep tabs in Makefiles
  au BufNewFile,BufReadPost Makefile set noexpandtab
augroup END

set tabstop=4
set shiftwidth=4
set expandtab

