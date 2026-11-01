" zacess-high-contrast-light — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-high-contrast-light.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=light
let g:colors_name = "zacess-high-contrast-light"

hi Normal guifg=#000000 guibg=#ffffff
hi NormalNC guifg=#000000 guibg=#ffffff
hi NormalFloat guifg=#000000 guibg=#f7f7f7
hi FloatBorder guifg=#262626 guibg=#f7f7f7
hi FloatTitle guifg=#000000 guibg=#f7f7f7 gui=bold
hi Cursor guifg=#ffffff guibg=#000000
hi lCursor guifg=#ffffff guibg=#000000
hi CursorIM guifg=#ffffff guibg=#000000
hi TermCursor guifg=#ffffff guibg=#000000
hi CursorLine guibg=#c3e5fe
hi CursorColumn guibg=#c3e5fe
hi ColorColumn guibg=#c3e5fe
hi CursorLineNr guifg=#000000 guibg=#c3e5fe gui=bold
hi LineNr guifg=#262626 guibg=#ffffff
hi SignColumn guifg=#262626 guibg=#ffffff
hi FoldColumn guifg=#262626 guibg=#ffffff
hi Folded guifg=#2e2e2e guibg=#f7f7f7 gui=italic
hi Visual guifg=#ffffff guibg=#015f5e
hi VisualNOS guifg=#ffffff guibg=#015f5e
hi Search guisp=#000000 gui=underline
hi CurSearch guifg=#000000 guibg=#ffd400 gui=bold
hi IncSearch guifg=#000000 guibg=#ffd400 gui=bold
hi Substitute guifg=#000000 guibg=#ffd400
hi MatchParen guisp=#003d99 gui=bold,underline
hi NonText guifg=#6e6e6e
hi Whitespace guifg=#6e6e6e
hi SpecialKey guifg=#6e6e6e
hi EndOfBuffer guifg=#6e6e6e
hi Conceal guifg=#2e2e2e
hi Directory guifg=#00347f gui=bold
hi Title guifg=#4b0091 gui=bold
hi ErrorMsg guifg=#8b0000 gui=bold
hi WarningMsg guifg=#5a3a00 gui=bold
hi ModeMsg guifg=#000000 gui=bold
hi MoreMsg guifg=#003d99 gui=bold
hi Question guifg=#003d99 gui=bold
hi StatusLine guifg=#000000 guibg=#efefef
hi StatusLineNC guifg=#2e2e2e guibg=#f7f7f7
hi TabLine guifg=#2e2e2e guibg=#f7f7f7
hi TabLineFill guibg=#f7f7f7
hi TabLineSel guifg=#000000 guibg=#ffffff guisp=#003d99 gui=bold,underline
hi WinSeparator guifg=#262626
hi VertSplit guifg=#262626
hi WinBar guifg=#000000 guibg=#ffffff gui=bold
hi WinBarNC guifg=#2e2e2e guibg=#ffffff
hi Pmenu guifg=#000000 guibg=#f7f7f7
hi PmenuSel guifg=#000000 guibg=#fff1a0 gui=bold
hi PmenuSbar guibg=#efefef
hi PmenuThumb guibg=#6e6e6e
hi PmenuMatch guifg=#003d99 gui=bold
hi WildMenu guifg=#000000 guibg=#fff1a0
hi QuickFixLine guibg=#fff1a0
hi SpellBad guisp=#8b0000 gui=undercurl
hi SpellCap guisp=#5a3a00 gui=undercurl
hi SpellLocal guisp=#00337f gui=undercurl
hi SpellRare guisp=#00337f gui=undercurl
hi DiffAdd guibg=#e0f5e3
hi DiffDelete guifg=#4a0000 guibg=#fde4e4
hi DiffChange guibg=#fff1a0
hi DiffText guibg=#fff1a0 guisp=#00307a gui=bold,underline
hi GitSignsAdd guifg=#005518 guibg=#ffffff
hi GitSignsChange guifg=#00307a guibg=#ffffff
hi GitSignsDelete guifg=#4a0000 guibg=#ffffff
hi GitSignsChangedelete guifg=#00307a guibg=#ffffff
hi GitSignsTopdelete guifg=#4a0000 guibg=#ffffff
hi GitSignsUntracked guifg=#005518 guibg=#ffffff
hi MiniDiffSignAdd guifg=#005518 guibg=#ffffff
hi MiniDiffSignChange guifg=#00307a guibg=#ffffff
hi MiniDiffSignDelete guifg=#4a0000 guibg=#ffffff
hi SignifySignAdd guifg=#005518 guibg=#ffffff
hi SignifySignChange guifg=#00307a guibg=#ffffff
hi SignifySignDelete guifg=#4a0000 guibg=#ffffff
hi Added guifg=#005518
hi Removed guifg=#4a0000
hi Changed guifg=#00307a
hi diffAdded guifg=#005518
hi diffRemoved guifg=#4a0000
hi diffChanged guifg=#00307a
hi Comment guifg=#1701fb gui=italic
hi Constant guifg=#521e00
hi String guifg=#005518
hi Character guifg=#005518
hi Number guifg=#521e00
hi Boolean guifg=#521e00
hi Float guifg=#521e00
hi Identifier guifg=#000000
hi Function guifg=#00347f
hi Statement guifg=#4b0091 gui=bold
hi Conditional guifg=#8a0046 gui=bold
hi Repeat guifg=#8a0046 gui=bold
hi Label guifg=#8a0046 gui=bold
hi Operator guifg=#000000
hi Keyword guifg=#4b0091 gui=bold
hi Exception guifg=#8a0046 gui=bold
hi PreProc guifg=#4b0091 gui=bold
hi Include guifg=#8a0046 gui=bold
hi Define guifg=#4b0091 gui=bold
hi Macro guifg=#00347f
hi PreCondit guifg=#4b0091 gui=bold
hi Type guifg=#004f4e
hi StorageClass guifg=#4b0091 gui=bold
hi Structure guifg=#4b0091 gui=bold
hi Typedef guifg=#4b0091 gui=bold
hi Special guifg=#720030
hi SpecialChar guifg=#720030
hi Tag guifg=#4b0091 gui=bold
hi Delimiter guifg=#000000
hi SpecialComment guifg=#1701fb gui=italic
hi Debug guifg=#8a0046 gui=bold
hi Underlined guifg=#003d99 gui=underline
hi Error guifg=#600000 guisp=#600000 gui=underline
hi Todo guifg=#8a0046 gui=bold,italic
hi DiagnosticError guifg=#8b0000
hi DiagnosticWarn guifg=#5a3a00
hi DiagnosticInfo guifg=#00337f
hi DiagnosticHint guifg=#2e2e2e
hi DiagnosticOk guifg=#005518
hi DiagnosticUnderlineError guisp=#8b0000 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#5a3a00 gui=undercurl
hi DiagnosticUnderlineInfo guisp=#00337f gui=undercurl
hi DiagnosticUnderlineHint guisp=#2e2e2e gui=undercurl
hi DiagnosticUnnecessary guifg=#2e2e2e gui=italic
hi DiagnosticDeprecated guisp=#2e2e2e gui=strikethrough
hi LspReferenceText guisp=#262626 gui=underline
hi LspReferenceRead guisp=#262626 gui=underline
hi LspReferenceWrite guisp=#003d99 gui=underline
hi LspInlayHint guifg=#2e2e2e guibg=#f7f7f7

" Vim terminal palette
let g:terminal_ansi_colors = ['#000000', '#ca0000', '#017424', '#875b00', '#005bdc', '#b400ac', '#006f6e', '#3d3d3d', '#333333', '#e90100', '#018726', '#9c6a01', '#016eee', '#cf00c6', '#028181', '#000000']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
