" zacess-light — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-light.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=light
let g:colors_name = "zacess-light"

hi Normal guifg=#111111 guibg=#ffffff
hi NormalNC guifg=#111111 guibg=#ffffff
hi NormalFloat guifg=#111111 guibg=#f4f4f4
hi FloatBorder guifg=#707070 guibg=#f4f4f4
hi FloatTitle guifg=#111111 guibg=#f4f4f4 gui=bold
hi Cursor guifg=#ffffff guibg=#111111
hi lCursor guifg=#ffffff guibg=#111111
hi CursorIM guifg=#ffffff guibg=#111111
hi TermCursor guifg=#ffffff guibg=#111111
hi CursorLine guibg=#d6dde8
hi CursorColumn guibg=#d6dde8
hi ColorColumn guibg=#d6dde8
hi CursorLineNr guifg=#111111 guibg=#d6dde8 gui=bold
hi LineNr guifg=#4d4d4d guibg=#ffffff
hi SignColumn guifg=#4d4d4d guibg=#ffffff
hi FoldColumn guifg=#4d4d4d guibg=#ffffff
hi Folded guifg=#424242 guibg=#f4f4f4 gui=italic
hi Visual guifg=#ffffff guibg=#0150b2
hi VisualNOS guifg=#ffffff guibg=#0150b2
hi Search guisp=#111111 gui=underline
hi CurSearch guifg=#111111 guibg=#ffd400 gui=bold
hi IncSearch guifg=#111111 guibg=#ffd400 gui=bold
hi Substitute guifg=#111111 guibg=#ffd400
hi MatchParen guisp=#0049a3 gui=bold,underline
hi NonText guifg=#767676
hi Whitespace guifg=#767676
hi SpecialKey guifg=#767676
hi EndOfBuffer guifg=#767676
hi Conceal guifg=#424242
hi Directory guifg=#0049a3 gui=bold
hi Title guifg=#59029f gui=bold
hi ErrorMsg guifg=#810005 gui=bold
hi WarningMsg guifg=#583600 gui=bold
hi ModeMsg guifg=#111111 gui=bold
hi MoreMsg guifg=#0049a3 gui=bold
hi Question guifg=#0049a3 gui=bold
hi StatusLine guifg=#111111 guibg=#ededed
hi StatusLineNC guifg=#424242 guibg=#f4f4f4
hi TabLine guifg=#424242 guibg=#f4f4f4
hi TabLineFill guibg=#f4f4f4
hi TabLineSel guifg=#111111 guibg=#ffffff guisp=#0049a3 gui=bold,underline
hi WinSeparator guifg=#707070
hi VertSplit guifg=#707070
hi WinBar guifg=#111111 guibg=#ffffff gui=bold
hi WinBarNC guifg=#424242 guibg=#ffffff
hi Pmenu guifg=#111111 guibg=#f4f4f4
hi PmenuSel guifg=#111111 guibg=#fff1a8 gui=bold
hi PmenuSbar guibg=#ededed
hi PmenuThumb guibg=#8a8a8a
hi PmenuMatch guifg=#0049a3 gui=bold
hi WildMenu guifg=#111111 guibg=#fff1a8
hi QuickFixLine guibg=#fff1a8
hi SpellBad guisp=#810005 gui=undercurl
hi SpellCap guisp=#583600 gui=undercurl
hi SpellLocal guisp=#003a84 gui=undercurl
hi SpellRare guisp=#003a84 gui=undercurl
hi DiffAdd guibg=#e3f5e6
hi DiffDelete guifg=#5d0002 guibg=#fdeaea
hi DiffChange guibg=#fff1a8
hi DiffText guibg=#fff1a8 guisp=#001940 gui=bold,underline
hi GitSignsAdd guifg=#005b14 guibg=#ffffff
hi GitSignsChange guifg=#001940 guibg=#ffffff
hi GitSignsDelete guifg=#5d0002 guibg=#ffffff
hi GitSignsChangedelete guifg=#001940 guibg=#ffffff
hi GitSignsTopdelete guifg=#5d0002 guibg=#ffffff
hi GitSignsUntracked guifg=#005b14 guibg=#ffffff
hi MiniDiffSignAdd guifg=#005b14 guibg=#ffffff
hi MiniDiffSignChange guifg=#001940 guibg=#ffffff
hi MiniDiffSignDelete guifg=#5d0002 guibg=#ffffff
hi SignifySignAdd guifg=#005b14 guibg=#ffffff
hi SignifySignChange guifg=#001940 guibg=#ffffff
hi SignifySignDelete guifg=#5d0002 guibg=#ffffff
hi Added guifg=#005b14
hi Removed guifg=#5d0002
hi Changed guifg=#001940
hi diffAdded guifg=#005b14
hi diffRemoved guifg=#5d0002
hi diffChanged guifg=#001940
hi Comment guifg=#97016b gui=italic
hi Constant guifg=#4c1b00
hi String guifg=#004a0e
hi Character guifg=#004a0e
hi Number guifg=#4c1b00
hi Boolean guifg=#4c1b00
hi Float guifg=#4c1b00
hi Identifier guifg=#111111
hi Function guifg=#0049a3
hi Statement guifg=#59029f gui=bold
hi Conditional guifg=#5e003c gui=bold
hi Repeat guifg=#5e003c gui=bold
hi Label guifg=#5e003c gui=bold
hi Operator guifg=#111111
hi Keyword guifg=#59029f gui=bold
hi Exception guifg=#5e003c gui=bold
hi PreProc guifg=#59029f gui=bold
hi Include guifg=#5e003c gui=bold
hi Define guifg=#59029f gui=bold
hi Macro guifg=#0049a3
hi PreCondit guifg=#59029f gui=bold
hi Type guifg=#003737
hi StorageClass guifg=#59029f gui=bold
hi Structure guifg=#59029f gui=bold
hi Typedef guifg=#59029f gui=bold
hi Special guifg=#5b0020
hi SpecialChar guifg=#5b0020
hi Tag guifg=#59029f gui=bold
hi Delimiter guifg=#111111
hi SpecialComment guifg=#97016b gui=italic
hi Debug guifg=#5e003c gui=bold
hi Underlined guifg=#0049a3 gui=underline
hi Error guifg=#5d0002 guisp=#5d0002 gui=underline
hi Todo guifg=#5e003c gui=bold,italic
hi DiagnosticError guifg=#810005
hi DiagnosticWarn guifg=#583600
hi DiagnosticInfo guifg=#003a84
hi DiagnosticHint guifg=#424242
hi DiagnosticOk guifg=#005b14
hi DiagnosticUnderlineError guisp=#810005 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#583600 gui=undercurl
hi DiagnosticUnderlineInfo guisp=#003a84 gui=undercurl
hi DiagnosticUnderlineHint guisp=#424242 gui=undercurl
hi DiagnosticUnnecessary guifg=#424242 gui=italic
hi DiagnosticDeprecated guisp=#424242 gui=strikethrough
hi LspReferenceText guisp=#707070 gui=underline
hi LspReferenceRead guisp=#707070 gui=underline
hi LspReferenceWrite guisp=#0049a3 gui=underline
hi LspInlayHint guifg=#424242 guibg=#f4f4f4

" Vim terminal palette
let g:terminal_ansi_colors = ['#111111', '#ca010e', '#01751c', '#885a00', '#005fcc', '#b301ae', '#026f6f', '#484848', '#4d4d4d', '#e90112', '#008722', '#9d6902', '#006eed', '#cf01c7', '#028181', '#111111']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
