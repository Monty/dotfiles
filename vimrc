call pathogen#infect()
call pathogen#helptags()

set nocompatible          " We're running Vim, not Vi!
set ignorecase            " Case-insensitive search
set smartcase             " Case sensitive when uc present
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

if has('gui_running')
    set background=light
    colorscheme asu1dark
else
    set background=dark
    colorscheme delek
endif

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent Ruby and Javascript with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,javascript set ai sw=2 sts=2 et
  " prettyprint javascript files with prettier-eslint
  autocmd FileType javascript set formatprg=prettier-eslint\ --stdin
  " set filetype of .function files for IMDb_xref
  autocmd BufRead,BufNewFile *.function set filetype=sh
  " set spellcheck in .md file
  autocmd BufRead,BufNewFile *.md setlocal filetype=markdown spell incsearch
  " copy/preserve indent in go, never expand tabs
  au BufNewFile,BufReadPost *.go set noet ci pi sts=0 sw=4 ts=4
  " autoindent Topaz with four spaces, always expand tabs
  au BufNewFile,BufReadPost *.topaz set ai sw=4 sts=8 et
  " Keep tabs in Makefiles
  au BufNewFile,BufReadPost Makefile,*.csv set noexpandtab
augroup END

let g:shfmt_switches = ['-i 4']

set encoding=utf-8
set expandtab
set grepprg=rg\ -Sn
set incsearch
set linebreak
set list listchars=tab:»·,trail:·,nbsp:·,extends:>,precedes:<
set nojoinspaces
set ruler
set scrolloff=1
set shiftround
set shiftwidth=4
set splitbelow
set splitright
set tabstop=4
set textwidth=80

setlocal spelllang=en_us
setlocal spellfile=~/.vim/spell/en.utf-8.add
setlocal spellfile+=~/.vim/spell/jargon/IMDb.utf-8.add

