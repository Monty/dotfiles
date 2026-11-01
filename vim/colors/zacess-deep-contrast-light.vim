" zacess-deep-contrast-light — Vim colorscheme converted from Zacess Neovim source
" Original source: zacess-deep-contrast-light.lua
" Requires Vim with +termguicolors for accurate RGB colors
hi clear
if exists("syntax_on")
  syntax reset
endif
set background=light
let g:colors_name = "zacess-deep-contrast-light"

hi Normal guifg=#000000 guibg=#ffffff
hi NormalNC guifg=#000000 guibg=#ffffff
hi NormalFloat guifg=#000000 guibg=#ffffff
hi FloatBorder guifg=#0f4a85 guibg=#ffffff
hi FloatTitle guifg=#000000 guibg=#ffffff gui=bold
hi Cursor guifg=#ffffff guibg=#000000
hi lCursor guifg=#ffffff guibg=#000000
hi CursorIM guifg=#ffffff guibg=#000000
hi TermCursor guifg=#ffffff guibg=#000000
hi CursorLine guibg=#c8debd
hi CursorColumn guibg=#c8debd
hi ColorColumn guibg=#c8debd
hi CursorLineNr guifg=#000000 guibg=#c8debd gui=bold
hi LineNr guifg=#000000 guibg=#ffffff
hi SignColumn guifg=#000000 guibg=#ffffff
hi FoldColumn guifg=#000000 guibg=#ffffff
hi Folded guifg=#4d4d4d guibg=#ffffff gui=italic
hi Visual guifg=#ffffff guibg=#990098
hi VisualNOS guifg=#ffffff guibg=#990098
hi Search guisp=#b5200d gui=underline
hi CurSearch guifg=#000000 guibg=#fff1a0 gui=bold
hi IncSearch guifg=#000000 guibg=#fff1a0 gui=bold
hi Substitute guifg=#000000 guibg=#fff1a0
hi MatchParen guisp=#0f4a85 gui=bold,underline
hi NonText guifg=#6e6e6e
hi Whitespace guifg=#6e6e6e
hi SpecialKey guifg=#6e6e6e
hi EndOfBuffer guifg=#6e6e6e
hi Conceal guifg=#4d4d4d
hi Directory guifg=#824100 gui=bold
hi Title guifg=#002ec2 gui=bold
hi ErrorMsg guifg=#aa0000 gui=bold
hi WarningMsg guifg=#674100 gui=bold
hi ModeMsg guifg=#000000 gui=bold
hi MoreMsg guifg=#0f4a85 gui=bold
hi Question guifg=#0f4a85 gui=bold
hi StatusLine guifg=#000000 guibg=#ffffff
hi StatusLineNC guifg=#4d4d4d guibg=#ffffff
hi TabLine guifg=#4d4d4d guibg=#ffffff
hi TabLineFill guibg=#ffffff
hi TabLineSel guifg=#000000 guibg=#ffffff guisp=#0f4a85 gui=bold,underline
hi WinSeparator guifg=#0f4a85
hi VertSplit guifg=#0f4a85
hi WinBar guifg=#000000 guibg=#ffffff gui=bold
hi WinBarNC guifg=#4d4d4d guibg=#ffffff
hi Pmenu guifg=#000000 guibg=#ffffff
hi PmenuSel guifg=#000000 guibg=#f0f5ff gui=bold
hi PmenuSbar guibg=#ffffff
hi PmenuThumb guibg=#6e6e6e
hi PmenuMatch guifg=#0f4a85 gui=bold
hi WildMenu guifg=#000000 guibg=#f0f5ff
hi QuickFixLine guibg=#f0f5ff
hi SpellBad guisp=#aa0000 gui=undercurl
hi SpellCap guisp=#674100 gui=undercurl
hi SpellLocal guisp=#002ec2 gui=undercurl
hi SpellRare guisp=#002ec2 gui=undercurl
hi DiffAdd guibg=#eefaee
hi DiffDelete guifg=#730000 guibg=#fff3f3
hi DiffChange guibg=#f0f5ff
hi DiffText guibg=#f0f5ff guisp=#002ec2 gui=bold,underline
hi GitSignsAdd guifg=#006108 guibg=#ffffff
hi GitSignsChange guifg=#002ec2 guibg=#ffffff
hi GitSignsDelete guifg=#730000 guibg=#ffffff
hi GitSignsChangedelete guifg=#002ec2 guibg=#ffffff
hi GitSignsTopdelete guifg=#730000 guibg=#ffffff
hi GitSignsUntracked guifg=#006108 guibg=#ffffff
hi MiniDiffSignAdd guifg=#006108 guibg=#ffffff
hi MiniDiffSignChange guifg=#002ec2 guibg=#ffffff
hi MiniDiffSignDelete guifg=#730000 guibg=#ffffff
hi SignifySignAdd guifg=#006108 guibg=#ffffff
hi SignifySignChange guifg=#002ec2 guibg=#ffffff
hi SignifySignDelete guifg=#730000 guibg=#ffffff
hi Added guifg=#006108
hi Removed guifg=#730000
hi Changed guifg=#002ec2
hi diffAdded guifg=#006108
hi diffRemoved guifg=#730000
hi diffChanged guifg=#002ec2
hi Comment guifg=#006108 gui=italic
hi Constant guifg=#a3005f
hi String guifg=#870000
hi Character guifg=#870000
hi Number guifg=#a3005f
hi Boolean guifg=#a3005f
hi Float guifg=#a3005f
hi Identifier guifg=#000000
hi Function guifg=#824100
hi Statement guifg=#002ec2 gui=bold
hi Conditional guifg=#950094 gui=bold
hi Repeat guifg=#950094 gui=bold
hi Label guifg=#950094 gui=bold
hi Operator guifg=#000000
hi Keyword guifg=#002ec2 gui=bold
hi Exception guifg=#950094 gui=bold
hi PreProc guifg=#002ec2 gui=bold
hi Include guifg=#950094 gui=bold
hi Define guifg=#002ec2 gui=bold
hi Macro guifg=#824100
hi PreCondit guifg=#002ec2 gui=bold
hi Type guifg=#003a39
hi StorageClass guifg=#002ec2 gui=bold
hi Structure guifg=#002ec2 gui=bold
hi Typedef guifg=#002ec2 gui=bold
hi Special guifg=#a60049
hi SpecialChar guifg=#a60049
hi Tag guifg=#002ec2 gui=bold
hi Delimiter guifg=#000000
hi SpecialComment guifg=#006108 gui=italic
hi Debug guifg=#950094 gui=bold
hi Underlined guifg=#003df6 gui=underline
hi Error guifg=#aa0000 guisp=#aa0000 gui=underline
hi Todo guifg=#950094 gui=bold,italic
hi DiagnosticError guifg=#aa0000
hi DiagnosticWarn guifg=#674100
hi DiagnosticInfo guifg=#002ec2
hi DiagnosticHint guifg=#4d4d4d
hi DiagnosticOk guifg=#006108
hi DiagnosticUnderlineError guisp=#aa0000 gui=undercurl
hi DiagnosticUnderlineWarn guisp=#674100 gui=undercurl
hi DiagnosticUnderlineInfo guisp=#002ec2 gui=undercurl
hi DiagnosticUnderlineHint guisp=#4d4d4d gui=undercurl
hi DiagnosticUnnecessary guifg=#4d4d4d gui=italic
hi DiagnosticDeprecated guisp=#4d4d4d gui=strikethrough
hi LspReferenceText guisp=#0f4a85 gui=underline
hi LspReferenceRead guisp=#0f4a85 gui=underline
hi LspReferenceWrite guisp=#0f4a85 gui=underline
hi LspInlayHint guifg=#4d4d4d guibg=#ffffff

" Vim terminal palette
let g:terminal_ansi_colors = ['#000000', '#ca0000', '#00892e', '#ad6500', '#0040ff', '#cd01cd', '#016e78', '#595959', '#404040', '#d14100', '#00884f', '#907300', '#0d00ff', '#db009a', '#0178c1', '#000000']

" Neovim Tree-sitter (@...) captures are omitted; Vim uses standard syntax groups.
