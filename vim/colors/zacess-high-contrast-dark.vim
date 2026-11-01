" zacess-high-contrast-dark — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-high-contrast-dark.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "zacess-high-contrast-dark"

hi Normal guifg=#ffffff guibg=#000000
hi NormalNC guifg=#ffffff guibg=#000000
hi NormalFloat guifg=#ffffff guibg=#000000
hi FloatBorder guifg=#a6a6a6 guibg=#000000
hi FloatTitle guifg=#ffffff guibg=#000000 gui=bold
hi Cursor guifg=#000000 guibg=#f5c400
hi lCursor guifg=#000000 guibg=#f5c400
hi CursorIM guifg=#000000 guibg=#f5c400
hi TermCursor guifg=#000000 guibg=#f5c400
hi CursorLine guibg=#262626
hi CursorColumn guibg=#262626
hi ColorColumn guibg=#262626
hi CursorLineNr guifg=#f5c400 guibg=#262626 gui=bold
hi LineNr guifg=#e6e6e6 guibg=#000000
hi SignColumn guifg=#e6e6e6 guibg=#000000
hi FoldColumn guifg=#e6e6e6 guibg=#000000
hi Folded guifg=#e0e0e0 guibg=#000000 gui=italic
hi Visual guifg=#000000 guibg=#bf96ff
hi VisualNOS guifg=#000000 guibg=#bf96ff
hi Search guisp=#f5c400 gui=underline
hi CurSearch guifg=#ffffff guibg=#493900 gui=bold
hi IncSearch guifg=#ffffff guibg=#493900 gui=bold
hi Substitute guifg=#ffffff guibg=#493900
hi MatchParen guisp=#8fd0ff gui=bold,underline
hi NonText guifg=#8c8c8c
hi Whitespace guifg=#8c8c8c
hi SpecialKey guifg=#8c8c8c
hi EndOfBuffer guifg=#8c8c8c
hi Conceal guifg=#e0e0e0
hi Directory guifg=#8fd0ff gui=bold
hi Title guifg=#f5c400 gui=bold
hi ErrorMsg guifg=#ff9e94 gui=bold
hi WarningMsg guifg=#ffd28a gui=bold
hi ModeMsg guifg=#ffffff gui=bold
hi MoreMsg guifg=#f5c400 gui=bold
hi Question guifg=#f5c400 gui=bold
hi StatusLine guifg=#ffffff guibg=#0f0f0f
hi StatusLineNC guifg=#e0e0e0 guibg=#000000
hi TabLine guifg=#e0e0e0 guibg=#000000
hi TabLineFill guibg=#000000
hi TabLineSel guifg=#ffffff guibg=#000000 guisp=#f5c400 gui=bold,underline
hi WinSeparator guifg=#a6a6a6
hi VertSplit guifg=#a6a6a6
hi WinBar guifg=#ffffff guibg=#000000 gui=bold
hi WinBarNC guifg=#e0e0e0 guibg=#000000
hi Pmenu guifg=#ffffff guibg=#000000
hi PmenuSel guifg=#ffffff guibg=#0a2552 gui=bold
hi PmenuSbar guibg=#0f0f0f
hi PmenuThumb guibg=#8c8c8c
hi PmenuMatch guifg=#f5c400 gui=bold
hi WildMenu guifg=#ffffff guibg=#0a2552
hi QuickFixLine guibg=#0a2552
hi SpellBad guisp=#ff9e94 gui=undercurl
hi SpellCap guisp=#ffd28a gui=undercurl
hi SpellLocal guisp=#a9d4ff gui=undercurl
hi SpellRare guisp=#a9d4ff gui=undercurl
hi DiffAdd guibg=#00290d
hi DiffDelete guifg=#ffaba3 guibg=#3d0008
hi DiffChange guibg=#0a2552
hi DiffText guibg=#0a2552 guisp=#e6f2ff gui=bold,underline
hi GitSignsAdd guifg=#3bff59 guibg=#000000
hi GitSignsChange guifg=#e6f2ff guibg=#000000
hi GitSignsDelete guifg=#ffaba3 guibg=#000000
hi GitSignsChangedelete guifg=#e6f2ff guibg=#000000
hi GitSignsTopdelete guifg=#ffaba3 guibg=#000000
hi GitSignsUntracked guifg=#3bff59 guibg=#000000
hi MiniDiffSignAdd guifg=#3bff59 guibg=#000000
hi MiniDiffSignChange guifg=#e6f2ff guibg=#000000
hi MiniDiffSignDelete guifg=#ffaba3 guibg=#000000
hi SignifySignAdd guifg=#3bff59 guibg=#000000
hi SignifySignChange guifg=#e6f2ff guibg=#000000
hi SignifySignDelete guifg=#ffaba3 guibg=#000000
hi Added guifg=#3bff59
hi Removed guifg=#ffaba3
hi Changed guifg=#e6f2ff
hi diffAdded guifg=#3bff59
hi diffRemoved guifg=#ffaba3
hi diffChanged guifg=#e6f2ff
hi Comment guifg=#c7b404 gui=italic
hi Constant guifg=#ffb27a
hi String guifg=#20fe34
hi Character guifg=#20fe34
hi Number guifg=#ffb27a
hi Boolean guifg=#ffb27a
hi Float guifg=#ffb27a
hi Identifier guifg=#ffffff
hi Function guifg=#8fd0ff
hi Statement guifg=#f5c400 gui=bold
hi Conditional guifg=#ffcdf0 gui=bold
hi Repeat guifg=#ffcdf0 gui=bold
hi Label guifg=#ffcdf0 gui=bold
hi Operator guifg=#ffffff
hi Keyword guifg=#f5c400 gui=bold
hi Exception guifg=#ffcdf0 gui=bold
hi PreProc guifg=#f5c400 gui=bold
hi Include guifg=#ffcdf0 gui=bold
hi Define guifg=#f5c400 gui=bold
hi Macro guifg=#8fd0ff
hi PreCondit guifg=#f5c400 gui=bold
hi Type guifg=#00f4e0
hi StorageClass guifg=#f5c400 gui=bold
hi Structure guifg=#f5c400 gui=bold
hi Typedef guifg=#f5c400 gui=bold
hi Special guifg=#ffa6c9
hi SpecialChar guifg=#ffa6c9
hi Tag guifg=#f5c400 gui=bold
hi Delimiter guifg=#ffffff
hi SpecialComment guifg=#c7b404 gui=italic
hi Debug guifg=#ffcdf0 gui=bold
hi Underlined guifg=#8fd0ff gui=underline
hi Error guifg=#ff9e94 guisp=#ff9e94 gui=underline
hi Todo guifg=#ffcdf0 gui=bold,italic
hi DiagnosticError guifg=#ff9e94
hi DiagnosticWarn guifg=#ffd28a
hi DiagnosticInfo guifg=#a9d4ff
hi DiagnosticHint guifg=#e0e0e0
hi DiagnosticOk guifg=#3bff59
hi DiagnosticUnderlineError guisp=#ff9e94 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#ffd28a gui=undercurl
hi DiagnosticUnderlineInfo guisp=#a9d4ff gui=undercurl
hi DiagnosticUnderlineHint guisp=#e0e0e0 gui=undercurl
hi DiagnosticUnnecessary guifg=#e0e0e0 gui=italic
hi DiagnosticDeprecated guisp=#e0e0e0 gui=strikethrough
hi LspReferenceText guisp=#a6a6a6 gui=underline
hi LspReferenceRead guisp=#a6a6a6 gui=underline
hi LspReferenceWrite guisp=#8fd0ff gui=underline
hi LspInlayHint guifg=#e0e0e0 guibg=#000000

" Vim terminal palette
let g:terminal_ansi_colors = ['#b3b3b3', '#ff9e94', '#26f444', '#f5c400', '#8fd0ff', '#f2a6ff', '#00f4e0', '#e0e0e0', '#cccccc', '#ffc4bd', '#95ff98', '#ffe08a', '#c8e6ff', '#ffcdf7', '#56fff3', '#ffffff']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
