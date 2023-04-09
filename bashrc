#!/usr/bin/env bash
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# echo "### .bashrc at `date`"

# Directory shortcuts
if [ -f ~/.directory_shortcuts ]; then
    . ~/.directory_shortcuts
fi

# Define the OS we're running on
PLATFORM="$(uname -sm | tr ' ' '-')"

# If not running interactively, skip most stuff
[[ $- != *i* ]] && return

# echo "### .bashrc after interactive check"
# start of "skip if not interactive"

# Don't put duplicate lines or lines starting with spaces in the history
export HISTCONTROL=ignoreboth
export HISTSIZE=3000
export HISTFILESIZE=6000

# Include directory name in iTerm tab titles by default
if [ "$ITERM_SESSION_ID" ]; then
    export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '
fi

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# So we can edit .gpg files directly in Vim
GPG_TTY=$(tty)
export GPG_TTY

# Some useful environment variables
export EDITOR=/usr/bin/vim
export PAGER=less # strongly advised for backwards scrolling
export LESS=seMi
export CLICOLOR=1
export TERM=xterm-256color
# Make exa colors match ls colors as much as possible
LS_COLORS="or=38;5;196:di=34:ln=35:so=32:pi=38;5;216:ex=31:bd=34;46:cd=34;43:su=30;41"
LS_COLORS+=":sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS="$LS_COLORS"
EXA_COLORS="su=30;41:sf=30;41:xa=33:uu=39:un=31:gu=39:gn=31:ur=39:uw=39:ux=39:ue=39"
EXA_COLORS+=":gr=39:gw=39:gx=39:tr=39:tw=31:tx=39:sn=34:sb=36:da=34"
export EXA_COLORS="$EXA_COLORS"

# Make a sensible PATH and save it
# set PATH so it includes private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
# Set PATH so it appends other useful directories if they exist
for each in \
    /usr/local/bin \
    /usr/local/go/bin \
    $HOME/go/bin \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $HOME/Library/Python/3.8/bin \
    $HOME/.gem/ruby/2.7.0/bin \
    $HOME/Projects/nvim-stable-macos/bin \
    $HOME/Projects/dart-sass \
    /usr/local/git/bin \
    /usr/X11/bin; do
    if [ -d "$each" ]; then
        # echo "### Found $each"
        if ! echo "$PATH" | grep -E -s "(^|:)$each($|:)" >/dev/null; then
            PATH=${PATH}:$each
        fi
    fi
done

# golang setup
export GOPATH=$HOME/Projects/go

# broot setup
if type -p broot >/dev/null; then
    source "$HOME"/.config/broot/launcher/bash/br
fi

# frum setup
if type -p frum >/dev/null; then
    eval "$(frum init)"
fi

# It is sometimes useful to be able to "reset" your path to a clean state.
export SAVED_PATH=${PATH}

# Setup other HOMES
case "$PLATFORM" in
Darwin-arm64 | Darwin-x86_64 | Darwin-i386)
    if /usr/libexec/java_home >/dev/null 2>/dev/null; then
        JAVA_HOME=$(/usr/libexec/java_home)
        export JAVA_HOME
    fi
    ;;
Linux-x86_64)
    JAVA_HOME=/usr/lib/jvm/default-java
    export JAVA_HOME
    ;;
*)
    echo "Don't know where JAVA_HOME should be"
    ;;
esac

# Prompts
# Colors
BLACK="\[\e[0;30m\]"
RED="\[\e[0;31m\]"
GREEN="\[\e[0;32m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34;1m\]"
PURPLE="\[\e[0;35m\]"
CYAN="\[\e[0;36m\]"
GRAY="\[\e[0;37m\]"
TBAR='\[\e]2;\u@\H \w\a\]'
BE_COLOR="${BLUE}"
NO_COLOR="\[\e[0m\]"
# Functions to compute prompt strings
#
function parse_git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
# Git
if type -p git >/dev/null; then
    # git branch in RED
    GPROMPT="$RED\$(parse_git_branch)"
else
    unset GPROMPT
fi
# Default prompt
# If SSH session, change prompt color to yellow
if [[ $(who am i) =~ \([0-9\.]+\)$ ]]; then
    BE_COLOR="${YELLOW}"
fi
export PS1="${TBAR}${BE_COLOR}\t \u@\h:\W ${RPROMPT}${GPROMPT}${BE_COLOR}\$${NO_COLOR} "

# Define aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# end of .bashrc
