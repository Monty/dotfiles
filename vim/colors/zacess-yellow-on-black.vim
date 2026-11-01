" zacess-yellow-on-black — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-yellow-on-black.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "zacess-yellow-on-black"

hi Normal guifg=#ffeb3b guibg=#000000
hi NormalNC guifg=#ffeb3b guibg=#000000
hi NormalFloat guifg=#ffeb3b guibg=#000000
hi FloatBorder guifg=#7a7a7a guibg=#000000
hi FloatTitle guifg=#ffeb3b guibg=#000000 gui=bold
hi Cursor guifg=#000000 guibg=#ffffff
hi lCursor guifg=#000000 guibg=#ffffff
hi CursorIM guifg=#000000 guibg=#ffffff
hi TermCursor guifg=#000000 guibg=#ffffff
hi CursorLine guibg=#262626
hi CursorColumn guibg=#262626
hi ColorColumn guibg=#262626
hi CursorLineNr guifg=#ffeb3b guibg=#262626 gui=bold
hi LineNr guifg=#d9d9d9 guibg=#000000
hi SignColumn guifg=#d9d9d9 guibg=#000000
hi FoldColumn guifg=#d9d9d9 guibg=#000000
hi Folded guifg=#e6e6e6 guibg=#000000 gui=italic
hi Visual guifg=#000000 guibg=#09bcc4
hi VisualNOS guifg=#000000 guibg=#09bcc4
hi Search guisp=#ffffff gui=underline
hi CurSearch guifg=#ffeb3b guibg=#4b3a00 gui=bold
hi IncSearch guifg=#ffeb3b guibg=#4b3a00 gui=bold
hi Substitute guifg=#ffeb3b guibg=#4b3a00
hi MatchParen guisp=#ffeb3b gui=bold,underline
hi NonText guifg=#9a9a9a
hi Whitespace guifg=#9a9a9a
hi SpecialKey guifg=#9a9a9a
hi EndOfBuffer guifg=#9a9a9a
hi Conceal guifg=#e6e6e6
hi Directory guifg=#88c3ff gui=bold
hi Title guifg=#ffffff gui=bold
hi ErrorMsg guifg=#ffbeb5 gui=bold
hi WarningMsg guifg=#ffd8ab gui=bold
hi ModeMsg guifg=#ffeb3b gui=bold
hi MoreMsg guifg=#ffeb3b gui=bold
hi Question guifg=#ffeb3b gui=bold
hi StatusLine guifg=#ffeb3b guibg=#0d0d0d
hi StatusLineNC guifg=#e6e6e6 guibg=#000000
hi TabLine guifg=#e6e6e6 guibg=#000000
hi TabLineFill guibg=#000000
hi TabLineSel guifg=#ffeb3b guibg=#000000 guisp=#ffeb3b gui=bold,underline
hi WinSeparator guifg=#7a7a7a
hi VertSplit guifg=#7a7a7a
hi WinBar guifg=#ffeb3b guibg=#000000 gui=bold
hi WinBarNC guifg=#e6e6e6 guibg=#000000
hi Pmenu guifg=#ffeb3b guibg=#000000
hi PmenuSel guifg=#ffeb3b guibg=#0a2257 gui=bold
hi PmenuSbar guibg=#0d0d0d
hi PmenuThumb guibg=#8c8c8c
hi PmenuMatch guifg=#ffeb3b gui=bold
hi WildMenu guifg=#ffeb3b guibg=#0a2257
hi QuickFixLine guibg=#0a2257
hi SpellBad guisp=#ffbeb5 gui=undercurl
hi SpellCap guisp=#ffd8ab gui=undercurl
hi SpellLocal guisp=#a6d2ff gui=undercurl
hi SpellRare guisp=#a6d2ff gui=undercurl
hi DiffAdd guibg=#0d2a12
hi DiffDelete guifg=#ffa59d guibg=#3a0e0e
hi DiffChange guibg=#0a2257
hi DiffText guibg=#0a2257 guisp=#ddedff gui=bold,underline
hi GitSignsAdd guifg=#28f74f guibg=#000000
hi GitSignsChange guifg=#ddedff guibg=#000000
hi GitSignsDelete guifg=#ffa59d guibg=#000000
hi GitSignsChangedelete guifg=#ddedff guibg=#000000
hi GitSignsTopdelete guifg=#ffa59d guibg=#000000
hi GitSignsUntracked guifg=#28f74f guibg=#000000
hi MiniDiffSignAdd guifg=#28f74f guibg=#000000
hi MiniDiffSignChange guifg=#ddedff guibg=#000000
hi MiniDiffSignDelete guifg=#ffa59d guibg=#000000
hi SignifySignAdd guifg=#28f74f guibg=#000000
hi SignifySignChange guifg=#ddedff guibg=#000000
hi SignifySignDelete guifg=#ffa59d guibg=#000000
hi Added guifg=#28f74f
hi Removed guifg=#ffa59d
hi Changed guifg=#ddedff
hi diffAdded guifg=#28f74f
hi diffRemoved guifg=#ffa59d
hi diffChanged guifg=#ddedff
hi Comment guifg=#88c200 gui=italic
hi Constant guifg=#ffa77e
hi String guifg=#43f480
hi Character guifg=#43f480
hi Number guifg=#ffa77e
hi Boolean guifg=#ffa77e
hi Float guifg=#ffa77e
hi Identifier guifg=#ffeb3b
hi Function guifg=#88c3ff
hi Statement guifg=#ffffff gui=bold
hi Conditional guifg=#0cedf6 gui=bold
hi Repeat guifg=#0cedf6 gui=bold
hi Label guifg=#0cedf6 gui=bold
hi Operator guifg=#ffeb3b
hi Keyword guifg=#ffffff gui=bold
hi Exception guifg=#0cedf6 gui=bold
hi PreProc guifg=#ffffff gui=bold
hi Include guifg=#0cedf6 gui=bold
hi Define guifg=#ffffff gui=bold
hi Macro guifg=#88c3ff
hi PreCondit guifg=#ffffff gui=bold
hi Type guifg=#e5c7ff
hi StorageClass guifg=#ffffff gui=bold
hi Structure guifg=#ffffff gui=bold
hi Typedef guifg=#ffffff gui=bold
hi Special guifg=#ffa1ce
hi SpecialChar guifg=#ffa1ce
hi Tag guifg=#ffffff gui=bold
hi Delimiter guifg=#ffeb3b
hi SpecialComment guifg=#88c200 gui=italic
hi Debug guifg=#0cedf6 gui=bold
hi Underlined guifg=#1be4ed gui=underline
hi Error guifg=#ffa59d guisp=#ffa59d gui=underline
hi Todo guifg=#0cedf6 gui=bold,italic
hi DiagnosticError guifg=#ffbeb5
hi DiagnosticWarn guifg=#ffd8ab
hi DiagnosticInfo guifg=#a6d2ff
hi DiagnosticHint guifg=#e6e6e6
hi DiagnosticOk guifg=#28f74f
hi DiagnosticUnderlineError guisp=#ffbeb5 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#ffd8ab gui=undercurl
hi DiagnosticUnderlineInfo guisp=#a6d2ff gui=undercurl
hi DiagnosticUnderlineHint guisp=#e6e6e6 gui=undercurl
hi DiagnosticUnnecessary guifg=#e6e6e6 gui=italic
hi DiagnosticDeprecated guisp=#e6e6e6 gui=strikethrough
hi LspReferenceText guisp=#7a7a7a
hi LspReferenceRead guisp=#7a7a7a
hi LspReferenceWrite guisp=#ffeb3b
hi LspInlayHint guifg=#e6e6e6 guibg=#000000

" Vim terminal palette
let g:terminal_ansi_colors = ['#a3a3a3', '#ffa79b', '#01dc3f', '#edb618', '#90c1ff', '#fd9cf8', '#1fd3d3', '#d9d9d9', '#c8c8c8', '#ffd5ce', '#3cff5d', '#ffda8a', '#c9e0ff', '#ffd0fa', '#00f7f5', '#ffffff']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
