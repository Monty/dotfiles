call pathogen#infect()
call pathogen#helptags()

set nocompatible          " We're running Vim, not Vi!
set ignorecase            " Case-insensitive search
set smartcase             " Case sensitive when uc present
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins
set re=2                  " Fix hang when editing TypeScript files

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j
endif

set termguicolors
set laststatus=2

let g:tokyonight_disable_italic_comment = 1

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

let g:airline_section_c = '%f%m'
let g:airline_section_x = '%y'
let g:airline_section_y = ''
let g:airline_section_z = '%l/%L:%c'

" Use different colorscheme for SSH vs local
if !empty($SSH_TTY)
    colorscheme darkblue
else
    colorscheme monty_torte
endif

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent Ruby and JavaScript with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml,javascript,css,typescript set ai sw=2 sts=2 et
    " prettyprint JavaScript, TypeScript, css, html, md files with prettier-eslint
    autocmd FileType javascript,typescript,css,html,md set formatprg=prettier-eslint\ --stdin
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
setlocal spellfile+=~/.vim/spell/jargon/dotfiles.utf-8.add

