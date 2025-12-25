#!/usr/bin/env zsh
#
# ~/.zshrc
#
# New Terminal tab/window: Loaded 3rd
# SSH session: Loaded 3rd
# Console login: Loaded 3rd
# Running a shell script: Skipped
# Remote SSH command (ssh host 'ls'): Skipped (due to guard)
#
# echo "### .zshrc at `date`"
#
# Handle zsh arrays and known variables
# shellcheck disable=SC1087,SC2154

# If not running interactively, skip everything as all the
# non-interactive code has been moved to .zshenv/.zprofile
[[ $- != *i* ]] && return

# --- Input & Keyboard ---
# Force Emacs mode to ensure Ctrl-R (incremental search) works
bindkey -e
# Allow # comments on command line
setopt interactivecomments

# --- Advanced History Setup ---
# Don't put duplicate lines or lines starting with spaces in the history
# share_history: Share history between all sessions immediately
setopt hist_ignore_dups hist_ignore_space share_history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
# shellcheck disable=SC2034
SAVEHIST=10000

# Some other useful environment variables
# shellcheck disable=SC2155
export PAGER=$(command -v moor || echo "less")
export LESS=seMi
export EDITOR=/usr/bin/vim
export CLICOLOR=1

# broot setup
if type -p broot >/dev/null; then
    # shellcheck source=/dev/null
    source "$HOME"/.config/broot/launcher/bash/br
fi

# Generate colors using vivid (if installed)
# shellcheck disable=SC2155
if command -v vivid &>/dev/null; then
    export LS_COLORS="$(vivid generate zenburn)"
else
    # Fallback standard LS_COLORS
    export LS_COLORS="or=38;5;196:di=34:ln=35:so=32:pi=38;5;216:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi
# Apply EZA UI overrides (Applies regardless of vivid presence)
export EZA_COLORS="su=30;41:sf=30;41:xa=33:uu=39:un=31:gu=39:gn=31:ur=39:uw=39:ux=39:ue=39:gr=39:gw=39:gx=39:tr=39:tw=31:tx=39:sn=34:sb=36:da=34"

# The remainder is mostly about customizing my prompt and window titles
setopt prompt_subst

# Pick prompt colors - normally blue, but yellow if SSH,
# red if root or privileged
# shellcheck disable=SC2034
if [[ -n $SSH_TTY || -n $SSH_CONNECTION ]]; then
    prompt_color='%F{%(#.red.yellow)}'
else
    prompt_color='%F{%(#.red.blue)}'
fi

# Load the version control system module
autoload -Uz vcs_info
# Enable only git
zstyle ':vcs_info:*' enable git
# Format: red color, (branch name), reset color, trailing space
# %b is the branch name, %u/%c are for unstaged/staged changes
zstyle ':vcs_info:git:*' formats '%F{red}(%b)%f '

# Load the specific Zsh modules for searching
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
#
# Bind the Up and Down arrows to the search function
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Functions to set iTerm2 window and tab titles
# $1 = type: 0 - both, 1 - tab, 2 - title
setTermTitle() {
    # echo works in bash & zsh
    local mode=$1
    shift
    echo -ne "\033]$mode;$*\007"
}
stt_both() { setTermTitle 0 "$@"; }
stt_tab() { setTermTitle 1 "$@"; }
stt_title() { setTermTitle 2 "$@"; }

# This runs before every prompt to refresh the git status
precmd() {
    vcs_info
    stt_title "$USER"@"${HOST%.Local}" "${PWD/#$HOME/~}"
    local TILDE_HOME=${PWD/#$HOME/~}
    stt_tab "$USER"@"${HOST%.Local}" "${TILDE_HOME##*/}"
}

# Default prompt
# Allow not expanding this expression in single quotes
# shellcheck disable=SC2016,SC2034
PROMPT='%B${prompt_color}%* %n@%m:%1~%f ${vcs_info_msg_0_}${prompt_color}$%f %b'

# Define aliases
if [[ -f ~/.zsh_aliases ]]; then
    # shellcheck source=/dev/null
    . ~/.zsh_aliases
fi

# end of .zshrc
