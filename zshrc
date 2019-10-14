# ~/.zshrc: executed by zsh(1) for non-login shells.
# echo "### .zshrc at `date`"

# Shortcuts
export WS=$HOME/Projects/WhatsStreamingToday
export TS=$WS/notgit/test

# Define the OS we're running on
PLATFORM="$(uname -sm | tr ' ' '-')"
# Treat older and newer Intel based Macs the same
[ $PLATFORM = "Darwin-x86_64" ] && PLATFORM="Darwin-i386"

# If not running interactively, skip most stuff
[[ $- != *i* ]] && return

# echo "### .zshrc after interactive check"
# start of "skip if not interactive"

# Don't put duplicate lines or lines starting with spaces in the history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=3000
SAVEHIST=$HISTSIZE
setopt hist_ignore_dups
setopt hist_ignore_space

# So we can edit .gpg files directly in Vim
export GPG_TTY=$(tty)

# Some useful environment variables
export EDITOR=/usr/bin/vim
export PAGER=less # strongly advised for backwards scrolling
export LESS=seMi
export CLICOLOR=1
export TERM=xterm-256color

# Make a sensible PATH and save it
# set PATH so it includes private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
# Set PATH so it appends other useful directories if they exist
for each in \
    /usr/local/bin \
    $HOME/go/bin \
    $HOME/.local/bin \
    /usr/local/git/bin \
    /usr/X11/bin; do
    if [ -d $each ]; then
        # echo "### Found $each"
        if ! echo $PATH | egrep -s "(^|:)$each($|:)" >/dev/null; then
            PATH=${PATH}:$each
        fi
    fi
done

# golang setup
export GOPATH=$HOME/Projects/go

# It is sometimes useful to be able to "reset" your path to a clean state.
export SAVED_PATH=${PATH}

# Setup other HOMES
case "$PLATFORM" in
Darwin-i386)
    export JAVA_HOME=$(/usr/libexec/java_home)
    ;;
Linux-x86_64)
    export JAVA_HOME=/usr/lib/jvm/default-java
    ;;
*)
    echo "Don't know where JAVA_HOME should be"
    ;;
esac

# Functions to set iTerm2 window and tab titles
# $1 = type: 0 - both, 1 - tab, 2 - title
setTermTitle () {
    # echo works in bash & zsh
    local mode=$1 ; shift
    echo -ne "\033]$mode;$@\007"
}
stt_both  () { setTermTitle 0 $@; }
stt_tab   () { setTermTitle 1 $@; }
stt_title () { setTermTitle 2 $@; }

# Set iTerm window and tab titles
precmd () {
    stt_title $USER@${HOST%.Local} ${PWD/#$HOME/'~'}
    local TILDE_HOME=${PWD/#$HOME/'~'}
    stt_tab $USER@${HOST%.Local} ${TILDE_HOME##*/}
}

# Default prompt
PROMPT='%B%F{%(#.red.blue)}%* %n@%m:%1~ $%f %b'

# Define aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# end of .zshrc