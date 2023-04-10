require('plugins')
require('mason-config')

vim.cmd([[
set ignorecase            " Case-insensitive search
set smartcase             " Case sensitive when uc present
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

set formatoptions+=j

" Use different colorscheme for SSH vs local
if !empty($SSH_TTY)
    colorscheme murphy
else
    colorscheme torte
endif

augroup myfiletypes
    " Clear old autocmds in group
    autocmd!
    " autoindent Ruby and Javascript with two spaces, always expand tabs
    autocmd FileType ruby,eruby,yaml,javascript,css,typescript set ai sw=2 sts=2 et
    " prettyprint javascript and typescript files with prettier-eslint
    autocmd FileType javascript,typescript set formatprg=prettier-eslint\ --stdin
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
set splitbelow splitright
set tabstop=4
set textwidth=80
set mouse=
]])
