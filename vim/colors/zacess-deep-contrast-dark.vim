" zacess-deep-contrast-dark — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-deep-contrast-dark.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "zacess-deep-contrast-dark"

hi Normal guifg=#ffffff guibg=#000000
hi NormalNC guifg=#ffffff guibg=#000000
hi NormalFloat guifg=#ffffff guibg=#000000
hi FloatBorder guifg=#00ffff guibg=#000000
hi FloatTitle guifg=#ffffff guibg=#000000 gui=bold
hi Cursor guifg=#000000 guibg=#ffff00
hi lCursor guifg=#000000 guibg=#ffff00
hi CursorIM guifg=#000000 guibg=#ffff00
hi TermCursor guifg=#000000 guibg=#ffff00
hi CursorLine guibg=#262626
hi CursorColumn guibg=#262626
hi ColorColumn guibg=#262626
hi CursorLineNr guifg=#ffff00 guibg=#262626 gui=bold
hi LineNr guifg=#ffffff guibg=#000000
hi SignColumn guifg=#ffffff guibg=#000000
hi FoldColumn guifg=#ffffff guibg=#000000
hi Folded guifg=#b3b3b3 guibg=#000000 gui=italic
hi Visual guifg=#000000 guibg=#ff70ff
hi VisualNOS guifg=#000000 guibg=#ff70ff
hi Search guisp=#ffff00 gui=underline
hi CurSearch guifg=#ffffff guibg=#453800 gui=bold
hi IncSearch guifg=#ffffff guibg=#453800 gui=bold
hi Substitute guifg=#ffffff guibg=#453800
hi MatchParen guisp=#00ffff gui=bold,underline
hi NonText guifg=#8c8c8c
hi Whitespace guifg=#8c8c8c
hi SpecialKey guifg=#8c8c8c
hi EndOfBuffer guifg=#8c8c8c
hi Conceal guifg=#b3b3b3
hi Directory guifg=#ffdf5a gui=bold
hi Title guifg=#67aeff gui=bold
hi ErrorMsg guifg=#fe8167 gui=bold
hi WarningMsg guifg=#ffd370 gui=bold
hi ModeMsg guifg=#ffffff gui=bold
hi MoreMsg guifg=#00ffff gui=bold
hi Question guifg=#00ffff gui=bold
hi StatusLine guifg=#ffffff guibg=#0a0a0a
hi StatusLineNC guifg=#b3b3b3 guibg=#000000
hi TabLine guifg=#b3b3b3 guibg=#000000
hi TabLineFill guibg=#000000
hi TabLineSel guifg=#ffffff guibg=#000000 guisp=#00ffff gui=bold,underline
hi WinSeparator guifg=#00ffff
hi VertSplit guifg=#00ffff
hi WinBar guifg=#ffffff guibg=#000000 gui=bold
hi WinBarNC guifg=#b3b3b3 guibg=#000000
hi Pmenu guifg=#ffffff guibg=#000000
hi PmenuSel guifg=#ffffff guibg=#1c1c38 gui=bold
hi PmenuSbar guibg=#0a0a0a
hi PmenuThumb guibg=#8c8c8c
hi PmenuMatch guifg=#00ffff gui=bold
hi WildMenu guifg=#ffffff guibg=#1c1c38
hi QuickFixLine guibg=#1c1c38
hi SpellBad guisp=#fe8167 gui=undercurl
hi SpellCap guisp=#ffd370 gui=undercurl
hi SpellLocal guisp=#59a4f9 gui=undercurl
hi SpellRare guisp=#59a4f9 gui=undercurl
hi DiffAdd guibg=#002200
hi DiffDelete guifg=#ffaa7c guibg=#330000
hi DiffChange guibg=#1c1c38
hi DiffText guibg=#1c1c38 guisp=#67aeff gui=bold,underline
hi GitSignsAdd guifg=#00f000 guibg=#000000
hi GitSignsChange guifg=#67aeff guibg=#000000
hi GitSignsDelete guifg=#ffaa7c guibg=#000000
hi GitSignsChangedelete guifg=#67aeff guibg=#000000
hi GitSignsTopdelete guifg=#ffaa7c guibg=#000000
hi GitSignsUntracked guifg=#00f000 guibg=#000000
hi MiniDiffSignAdd guifg=#00f000 guibg=#000000
hi MiniDiffSignChange guifg=#67aeff guibg=#000000
hi MiniDiffSignDelete guifg=#ffaa7c guibg=#000000
hi SignifySignAdd guifg=#00f000 guibg=#000000
hi SignifySignChange guifg=#67aeff guibg=#000000
hi SignifySignDelete guifg=#ffaa7c guibg=#000000
hi Added guifg=#00f000
hi Removed guifg=#ffaa7c
hi Changed guifg=#67aeff
hi diffAdded guifg=#00f000
hi diffRemoved guifg=#ffaa7c
hi diffChanged guifg=#67aeff
hi Comment guifg=#00c600 gui=italic
hi Constant guifg=#e19e00
hi String guifg=#ffaa7c
hi Character guifg=#ffaa7c
hi Number guifg=#e19e00
hi Boolean guifg=#e19e00
hi Float guifg=#e19e00
hi Identifier guifg=#ffffff
hi Function guifg=#ffdf5a
hi Statement guifg=#67aeff gui=bold
hi Conditional guifg=#ffabfd gui=bold
hi Repeat guifg=#ffabfd gui=bold
hi Label guifg=#ffabfd gui=bold
hi Operator guifg=#ffffff
hi Keyword guifg=#67aeff gui=bold
hi Exception guifg=#ffabfd gui=bold
hi PreProc guifg=#67aeff gui=bold
hi Include guifg=#ffabfd gui=bold
hi Define guifg=#67aeff gui=bold
hi Macro guifg=#ffdf5a
hi PreCondit guifg=#67aeff gui=bold
hi Type guifg=#00ebb1
hi StorageClass guifg=#67aeff gui=bold
hi Structure guifg=#67aeff gui=bold
hi Typedef guifg=#67aeff gui=bold
hi Special guifg=#ff80c5
hi SpecialChar guifg=#ff80c5
hi Tag guifg=#67aeff gui=bold
hi Delimiter guifg=#ffffff
hi SpecialComment guifg=#00c600 gui=italic
hi Debug guifg=#ffabfd gui=bold
hi Underlined guifg=#1db4ff gui=underline
hi Error guifg=#fd8b78 guisp=#fd8b78 gui=underline
hi Todo guifg=#ffabfd gui=bold,italic
hi DiagnosticError guifg=#fe8167
hi DiagnosticWarn guifg=#ffd370
hi DiagnosticInfo guifg=#59a4f9
hi DiagnosticHint guifg=#b3b3b3
hi DiagnosticOk guifg=#00f000
hi DiagnosticUnderlineError guisp=#fe8167 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#ffd370 gui=undercurl
hi DiagnosticUnderlineInfo guisp=#59a4f9 gui=undercurl
hi DiagnosticUnderlineHint guisp=#b3b3b3 gui=undercurl
hi DiagnosticUnnecessary guifg=#b3b3b3 gui=italic
hi DiagnosticDeprecated guisp=#b3b3b3 gui=strikethrough
hi LspReferenceText guisp=#00ffff gui=underline
hi LspReferenceRead guisp=#00ffff gui=underline
hi LspReferenceWrite guisp=#00ffff gui=underline
hi LspInlayHint guifg=#b3b3b3 guibg=#000000

" Vim terminal palette
let g:terminal_ansi_colors = ['#000000', '#ff5f5f', '#00cd00', '#cdcd00', '#8888ff', '#ff2aff', '#00cdcd', '#e5e5e5', '#b8b8b8', '#ff9e9e', '#00ff00', '#ffff00', '#b0b0ff', '#ff8fff', '#00ffff', '#ffffff']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
