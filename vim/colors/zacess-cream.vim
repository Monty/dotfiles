" zacess-cream — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-cream.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=light
let g:colors_name = "zacess-cream"

hi Normal guifg=#000000 guibg=#fdf6e3
hi NormalNC guifg=#000000 guibg=#fdf6e3
hi NormalFloat guifg=#000000 guibg=#f2efe9
hi FloatBorder guifg=#6e6555 guibg=#f2efe9
hi FloatTitle guifg=#000000 guibg=#f2efe9 gui=bold
hi Cursor guifg=#fdf6e3 guibg=#000000
hi lCursor guifg=#fdf6e3 guibg=#000000
hi CursorIM guifg=#fdf6e3 guibg=#000000
hi TermCursor guifg=#fdf6e3 guibg=#000000
hi CursorLine guibg=#c8dadd
hi CursorColumn guibg=#c8dadd
hi ColorColumn guibg=#c8dadd
hi CursorLineNr guifg=#000000 guibg=#c8dadd gui=bold
hi LineNr guifg=#4a4337 guibg=#fdf6e3
hi SignColumn guifg=#4a4337 guibg=#fdf6e3
hi FoldColumn guifg=#4a4337 guibg=#fdf6e3
hi Folded guifg=#3f382c guibg=#f2efe9 gui=italic
hi Visual guifg=#fdf6e3 guibg=#7401ca
hi VisualNOS guifg=#fdf6e3 guibg=#7401ca
hi Search guisp=#000000 gui=underline
hi CurSearch guifg=#000000 guibg=#ffd400 gui=bold
hi IncSearch guifg=#000000 guibg=#ffd400 gui=bold
hi Substitute guifg=#000000 guibg=#ffd400
hi MatchParen guisp=#004498 gui=bold,underline
hi NonText guifg=#766c5b
hi Whitespace guifg=#766c5b
hi SpecialKey guifg=#766c5b
hi EndOfBuffer guifg=#766c5b
hi Conceal guifg=#3f382c
hi Directory guifg=#004498 gui=bold
hi Title guifg=#530093 gui=bold
hi ErrorMsg guifg=#770004 gui=bold
hi WarningMsg guifg=#513100 gui=bold
hi ModeMsg guifg=#000000 gui=bold
hi MoreMsg guifg=#004498 gui=bold
hi Question guifg=#004498 gui=bold
hi StatusLine guifg=#000000 guibg=#e9e5dd
hi StatusLineNC guifg=#3f382c guibg=#f2efe9
hi TabLine guifg=#3f382c guibg=#f2efe9
hi TabLineFill guibg=#f2efe9
hi TabLineSel guifg=#000000 guibg=#fdf6e3 guisp=#004498 gui=bold,underline
hi WinSeparator guifg=#6e6555
hi VertSplit guifg=#6e6555
hi WinBar guifg=#000000 guibg=#fdf6e3 gui=bold
hi WinBarNC guifg=#3f382c guibg=#fdf6e3
hi Pmenu guifg=#000000 guibg=#f2efe9
hi PmenuSel guifg=#000000 guibg=#f9e79a gui=bold
hi PmenuSbar guibg=#e9e5dd
hi PmenuThumb guibg=#857b69
hi PmenuMatch guifg=#004498 gui=bold
hi WildMenu guifg=#000000 guibg=#f9e79a
hi QuickFixLine guibg=#f9e79a
hi SpellBad guisp=#770004 gui=undercurl
hi SpellCap guisp=#513100 gui=undercurl
hi SpellLocal guisp=#00357a gui=undercurl
hi SpellRare guisp=#00357a gui=undercurl
hi DiffAdd guibg=#e4f1d8
hi DiffDelete guifg=#540002 guibg=#f9e3d8
hi DiffChange guibg=#f9e79a
hi DiffText guibg=#f9e79a guisp=#001538 gui=bold,underline
hi GitSignsAdd guifg=#005512 guibg=#fdf6e3
hi GitSignsChange guifg=#001538 guibg=#fdf6e3
hi GitSignsDelete guifg=#540002 guibg=#fdf6e3
hi GitSignsChangedelete guifg=#001538 guibg=#fdf6e3
hi GitSignsTopdelete guifg=#540002 guibg=#fdf6e3
hi GitSignsUntracked guifg=#005512 guibg=#fdf6e3
hi MiniDiffSignAdd guifg=#005512 guibg=#fdf6e3
hi MiniDiffSignChange guifg=#001538 guibg=#fdf6e3
hi MiniDiffSignDelete guifg=#540002 guibg=#fdf6e3
hi SignifySignAdd guifg=#005512 guibg=#fdf6e3
hi SignifySignChange guifg=#001538 guibg=#fdf6e3
hi SignifySignDelete guifg=#540002 guibg=#fdf6e3
hi Added guifg=#005512
hi Removed guifg=#540002
hi Changed guifg=#001538
hi diffAdded guifg=#005512
hi diffRemoved guifg=#540002
hi diffChanged guifg=#001538
hi Comment guifg=#8b0162 gui=italic
hi Constant guifg=#451700
hi String guifg=#00440c
hi Character guifg=#00440c
hi Number guifg=#451700
hi Boolean guifg=#451700
hi Float guifg=#451700
hi Identifier guifg=#000000
hi Function guifg=#004498
hi Statement guifg=#530093 gui=bold
hi Conditional guifg=#550036 gui=bold
hi Repeat guifg=#550036 gui=bold
hi Label guifg=#550036 gui=bold
hi Operator guifg=#000000
hi Keyword guifg=#530093 gui=bold
hi Exception guifg=#550036 gui=bold
hi PreProc guifg=#530093 gui=bold
hi Include guifg=#550036 gui=bold
hi Define guifg=#530093 gui=bold
hi Macro guifg=#004498
hi PreCondit guifg=#530093 gui=bold
hi Type guifg=#003232
hi StorageClass guifg=#530093 gui=bold
hi Structure guifg=#530093 gui=bold
hi Typedef guifg=#530093 gui=bold
hi Special guifg=#52001c
hi SpecialChar guifg=#52001c
hi Tag guifg=#530093 gui=bold
hi Delimiter guifg=#000000
hi SpecialComment guifg=#8b0162 gui=italic
hi Debug guifg=#550036 gui=bold
hi Underlined guifg=#004498 gui=underline
hi Error guifg=#540002 guisp=#540002 gui=underline
hi Todo guifg=#550036 gui=bold,italic
hi DiagnosticError guifg=#770004
hi DiagnosticWarn guifg=#513100
hi DiagnosticInfo guifg=#00357a
hi DiagnosticHint guifg=#3f382c
hi DiagnosticOk guifg=#005512
hi DiagnosticUnderlineError guisp=#770004 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#513100 gui=undercurl
hi DiagnosticUnderlineInfo guisp=#00357a gui=undercurl
hi DiagnosticUnderlineHint guisp=#3f382c gui=undercurl
hi DiagnosticUnnecessary guifg=#3f382c gui=italic
hi DiagnosticDeprecated guisp=#3f382c gui=strikethrough
hi LspReferenceText guisp=#6e6555 gui=underline
hi LspReferenceRead guisp=#6e6555 gui=underline
hi LspReferenceWrite guisp=#004498 gui=underline
hi LspInlayHint guifg=#3f382c guibg=#f2efe9

" Vim terminal palette
let g:terminal_ansi_colors = ['#000000', '#c1000a', '#016f1b', '#815601', '#015ac2', '#a901a6', '#016969', '#434343', '#484848', '#df0010', '#008120', '#966501', '#0069e3', '#c500bf', '#027b7b', '#000000']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
