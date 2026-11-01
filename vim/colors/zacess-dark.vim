" zacess-dark — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-dark.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "zacess-dark"

hi Normal guifg=#f5f5f5 guibg=#121212
hi NormalNC guifg=#f5f5f5 guibg=#121212
hi NormalFloat guifg=#f5f5f5 guibg=#1a1a1a
hi FloatBorder guifg=#7a7a7a guibg=#1a1a1a
hi FloatTitle guifg=#f5f5f5 guibg=#1a1a1a gui=bold
hi Cursor guifg=#121212 guibg=#ffd400
hi lCursor guifg=#121212 guibg=#ffd400
hi CursorIM guifg=#121212 guibg=#ffd400
hi TermCursor guifg=#121212 guibg=#ffd400
hi CursorLine guibg=#2f2f2f
hi CursorColumn guibg=#2f2f2f
hi ColorColumn guibg=#2f2f2f
hi CursorLineNr guifg=#f5f5f5 guibg=#2f2f2f gui=bold
hi LineNr guifg=#b8b8b8 guibg=#121212
hi SignColumn guifg=#b8b8b8 guibg=#121212
hi FoldColumn guifg=#b8b8b8 guibg=#121212
hi Folded guifg=#c8c8c8 guibg=#1a1a1a gui=italic
hi Visual guifg=#121212 guibg=#4fbdff
hi VisualNOS guifg=#121212 guibg=#4fbdff
hi Search guisp=#ffd400 gui=underline
hi CurSearch guifg=#f5f5f5 guibg=#4d4000 gui=bold
hi IncSearch guifg=#f5f5f5 guibg=#4d4000 gui=bold
hi Substitute guifg=#f5f5f5 guibg=#4d4000
hi MatchParen guisp=#8cbcff gui=bold,underline
hi NonText guifg=#7a7a7a
hi Whitespace guifg=#7a7a7a
hi SpecialKey guifg=#7a7a7a
hi EndOfBuffer guifg=#7a7a7a
hi Conceal guifg=#c8c8c8
hi Directory guifg=#84b7fa gui=bold
hi Title guifg=#d3bdff gui=bold
hi ErrorMsg guifg=#ffccc4 gui=bold
hi WarningMsg guifg=#ffd182 gui=bold
hi ModeMsg guifg=#f5f5f5 gui=bold
hi MoreMsg guifg=#8cbcff gui=bold
hi Question guifg=#8cbcff gui=bold
hi StatusLine guifg=#f5f5f5 guibg=#232323
hi StatusLineNC guifg=#c8c8c8 guibg=#1a1a1a
hi TabLine guifg=#c8c8c8 guibg=#1a1a1a
hi TabLineFill guibg=#1a1a1a
hi TabLineSel guifg=#f5f5f5 guibg=#121212 guisp=#8cbcff gui=bold,underline
hi WinSeparator guifg=#7a7a7a
hi VertSplit guifg=#7a7a7a
hi WinBar guifg=#f5f5f5 guibg=#121212 gui=bold
hi WinBarNC guifg=#c8c8c8 guibg=#121212
hi Pmenu guifg=#f5f5f5 guibg=#1a1a1a
hi PmenuSel guifg=#f5f5f5 guibg=#1a2436 gui=bold
hi PmenuSbar guibg=#232323
hi PmenuThumb guibg=#6b6b6b
hi PmenuMatch guifg=#8cbcff gui=bold
hi WildMenu guifg=#f5f5f5 guibg=#1a2436
hi QuickFixLine guibg=#1a2436
hi SpellBad guisp=#ffccc4 gui=undercurl
hi SpellCap guisp=#ffd182 gui=undercurl
hi SpellLocal guisp=#bddaff gui=undercurl
hi SpellRare guisp=#bddaff gui=undercurl
hi DiffAdd guibg=#0f2a17
hi DiffDelete guifg=#f39992 guibg=#331414
hi DiffChange guibg=#1a2436
hi DiffText guibg=#1a2436 guisp=#c9e0ff gui=bold,underline
hi GitSignsAdd guifg=#01ea45 guibg=#121212
hi GitSignsChange guifg=#c9e0ff guibg=#121212
hi GitSignsDelete guifg=#f39992 guibg=#121212
hi GitSignsChangedelete guifg=#c9e0ff guibg=#121212
hi GitSignsTopdelete guifg=#f39992 guibg=#121212
hi GitSignsUntracked guifg=#01ea45 guibg=#121212
hi MiniDiffSignAdd guifg=#01ea45 guibg=#121212
hi MiniDiffSignChange guifg=#c9e0ff guibg=#121212
hi MiniDiffSignDelete guifg=#f39992 guibg=#121212
hi SignifySignAdd guifg=#01ea45 guibg=#121212
hi SignifySignChange guifg=#c9e0ff guibg=#121212
hi SignifySignDelete guifg=#f39992 guibg=#121212
hi Added guifg=#01ea45
hi Removed guifg=#f39992
hi Changed guifg=#c9e0ff
hi diffAdded guifg=#01ea45
hi diffRemoved guifg=#f39992
hi diffChanged guifg=#c9e0ff
hi Comment guifg=#80c201 gui=italic
hi Constant guifg=#ffd9ba
hi String guifg=#1ee646
hi Character guifg=#1ee646
hi Number guifg=#ffd9ba
hi Boolean guifg=#ffd9ba
hi Float guifg=#ffd9ba
hi Identifier guifg=#f5f5f5
hi Function guifg=#84b7fa
hi Statement guifg=#d3bdff gui=bold
hi Conditional guifg=#ffd2e6 gui=bold
hi Repeat guifg=#ffd2e6 gui=bold
hi Label guifg=#ffd2e6 gui=bold
hi Operator guifg=#f5f5f5
hi Keyword guifg=#d3bdff gui=bold
hi Exception guifg=#ffd2e6 gui=bold
hi PreProc guifg=#d3bdff gui=bold
hi Include guifg=#ffd2e6 gui=bold
hi Define guifg=#d3bdff gui=bold
hi Macro guifg=#84b7fa
hi PreCondit guifg=#d3bdff gui=bold
hi Type guifg=#03dedd
hi StorageClass guifg=#d3bdff gui=bold
hi Structure guifg=#d3bdff gui=bold
hi Typedef guifg=#d3bdff gui=bold
hi Special guifg=#f3989e
hi SpecialChar guifg=#f3989e
hi Tag guifg=#d3bdff gui=bold
hi Delimiter guifg=#f5f5f5
hi SpecialComment guifg=#80c201 gui=italic
hi Debug guifg=#ffd2e6 gui=bold
hi Underlined guifg=#8cbcff gui=underline
hi Error guifg=#ffd7d2 guisp=#ffd7d2 gui=underline
hi Todo guifg=#ffd2e6 gui=bold,italic
hi DiagnosticError guifg=#ffccc4
hi DiagnosticWarn guifg=#ffd182
hi DiagnosticInfo guifg=#bddaff
hi DiagnosticHint guifg=#c8c8c8
hi DiagnosticOk guifg=#01ea45
hi DiagnosticUnderlineError guisp=#ffccc4 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#ffd182 gui=undercurl
hi DiagnosticUnderlineInfo guisp=#bddaff gui=undercurl
hi DiagnosticUnderlineHint guisp=#c8c8c8 gui=undercurl
hi DiagnosticUnnecessary guifg=#c8c8c8 gui=italic
hi DiagnosticDeprecated guisp=#c8c8c8 gui=strikethrough
hi LspReferenceText guisp=#7a7a7a gui=underline
hi LspReferenceRead guisp=#7a7a7a gui=underline
hi LspReferenceWrite guisp=#8cbcff gui=underline
hi LspInlayHint guifg=#c8c8c8 guibg=#1a1a1a

" Vim terminal palette
let g:terminal_ansi_colors = ['#a3a3a3', '#ffa79b', '#1bdb41', '#f0b40b', '#90c1ff', '#f7a0f1', '#37d2cf', '#e6e6e6', '#c8c8c8', '#ffd5ce', '#34ff57', '#ffda8a', '#c9e0ff', '#ffd0fa', '#23f6f8', '#ffffff']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
