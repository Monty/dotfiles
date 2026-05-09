#!/usr/bin/env bash
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# echo "### .bashrc at `date`"

# Directory shortcuts
if [[ -f ~/.directory_shortcuts ]]; then
    # shellcheck source=/dev/null
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

# append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# So we can edit .gpg files directly in Vim
GPG_TTY=$(tty)
export GPG_TTY

# So we can retrieve version info from any public repo
if [[ -f ~/.tokens ]]; then
    # shellcheck source=/dev/null
    source ~/.tokens
fi

# Make a sensible PATH and save it
# set PATH so it includes private bin if it exists
if [[ -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
fi
# set PATH so it includes ~/.local/bin if it exists
if [[ -d "$HOME/.local/bin" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
# set PATH so it includes ~/.volta/bin if it exists
if [[ -d "$HOME/.volta" ]]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
fi
# Set PATH so it appends other useful directories if they exist
for each in \
    /usr/local/bin \
    /usr/local/go/bin \
    $HOME/go/bin \
    $HOME/.cargo/bin \
    /Applications/kitty.app/Contents/MacOS \
    /Applications/CotEditor.app/Contents/SharedSupport/bin \
    /Applications/CMake.app/Contents/bin \
    $HOME/.lmstudio/bin \
    $HOME/Library/Python/3.9/bin \
    $HOME/.gem/ruby/2.7.0/bin \
    $HOME/Projects/dart-sass \
    /usr/local/git/bin \
    /usr/X11/bin; do
    if [[ -d $each ]]; then
        # echo "### Found $each"
        if ! echo ":$PATH:" | grep -s ":$each:" >/dev/null; then
            PATH=${PATH}:$each
        fi
    fi
done

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

# Kludge for lychee or other commands needing openssl-3 dylibs
# uses dylibs from /Applications/kitty.app/Contents/Frameworks/
if [[ -z $DYLD_LIBRARY_PATH ]]; then
    export DYLD_LIBRARY_PATH="/Applications/kitty.app/Contents/Frameworks"
else
    export DYLD_LIBRARY_PATH="/Applications/kitty.app/Contents/Frameworks:$DYLD_LIBRARY_PATH"
fi

# Some useful environment variables
if type -p moor >/dev/null; then
    export PAGER=moor
else
    export PAGER=less
fi
export LESS=seMi
export EDITOR=/usr/bin/vim
export CLICOLOR=1
# Make eza colors match ls colors as much as possible
LS_COLORS="or=38;5;196:di=34:ln=35:so=32:pi=38;5;216:ex=31:bd=34;46:cd=34;43:su=30;41"
LS_COLORS+=":sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS
EZA_COLORS="su=30;41:sf=30;41:xa=33:uu=39:un=31:gu=39:gn=31:ur=39:uw=39:ux=39:ue=39"
EZA_COLORS+=":gr=39:gw=39:gx=39:tr=39:tw=31:tx=39:sn=34:sb=36:da=34"
export EZA_COLORS

# golang setup
export GOPATH=$HOME/Projects/go

# broot setup
if type -p broot >/dev/null; then
    # shellcheck source=/dev/null
    source "$HOME"/.config/broot/launcher/bash/br
fi

# Include directory name in iTerm tab titles by default
if [[ -n $ITERM_SESSION_ID ]]; then
    export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '
fi

# Prompts
# Colors
RED="\[\e[0;31m\]"
YELLOW="\[\e[0;33m\]"
BLUE="\[\e[0;34;1m\]"
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
if [[ -n $SSH_TTY || -n $SSH_CONNECTION ]]; then
    BE_COLOR="${YELLOW}"
fi
export PS1="${TBAR}${BE_COLOR}\t \u@\h:\W ${GPROMPT}${BE_COLOR}\$${NO_COLOR} "

# Define aliases
if [[ -f ~/.bash_aliases ]]; then
    # shellcheck source=/dev/null
    . ~/.bash_aliases
fi

# end of .bashrc
