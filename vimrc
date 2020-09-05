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
  " autoindent go with four spaces, always expand tabs
  au BufNewFile,BufReadPost *.go set noet ci pi sts=0 sw=4 ts=4
  " autoindent Topaz with four spaces, always expand tabs
  au BufNewFile,BufReadPost *.topaz set ai sw=4 sts=8 et
  " Keep tabs in Makefiles
  au BufNewFile,BufReadPost Makefile set noexpandtab
augroup END

let g:shfmt_switches = ['-i 4']

set list listchars=tab:>-,trail:.,extends:>,precedes:<
set tabstop=4
set shiftwidth=4
set expandtab

