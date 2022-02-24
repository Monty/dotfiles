# ~/.zshrc: executed by zsh(1) for non-login shells.
# echo "### .zshrc at `date`"

# Directory shortcuts
if [ -f ~/.directory_shortcuts ]; then
    . ~/.directory_shortcuts
fi

# Define the OS we're running on
PLATFORM="$(uname -sm | tr ' ' '-')"

# If not running interactively, skip most stuff
[[ $- != *i* ]] && return

# echo "### .zshrc after interactive check"
# start of "skip if not interactive"

# Setup history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=3000
SAVEHIST=$HISTSIZE
# Don't put duplicate lines or lines starting with spaces in the history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt appendhistory

# Ignore lines prefixed with '#'.
setopt interactivecomments

# So we can edit .gpg files directly in Vim
GPG_TTY=$(tty)
export GPG_TTY

# For IMDb_xref
export FULLCAST=50
# export NO_MENUS="yes"

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

# Functions to set iTerm2 window and tab titles
# $1 = type: 0 - both, 1 - tab, 2 - title
setTermTitle() {
    # echo works in bash & zsh
    local mode=$1
    shift
    echo -ne "\033]$mode;$@\007"
}
stt_both() { setTermTitle 0 $@; }
stt_tab() { setTermTitle 1 $@; }
stt_title() { setTermTitle 2 $@; }

# Set iTerm window and tab titles
precmd() {
    stt_title "$USER"@"${HOST%.Local}" "${PWD/#$HOME/'~'}"
    local TILDE_HOME=${PWD/#$HOME/'~'}
    stt_tab "$USER"@"${HOST%.Local}" "${TILDE_HOME##*/}"
}

# Setup prompt
setopt prompt_subst
#
# Pick prompt colors - normally blue, but yellow if SSH, red if root or privileged
if [[ -n $SSH_CLIENT || -n $SSH2_CLIENT ]]; then
    prompt_color='%F{%(#.red.yellow)}'
else
    prompt_color='%F{%(#.red.blue)}'
fi
#
# If in git repository, print git branch in red with trailing space
parse_git_branch() {
    branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    echo "%F{red}($branch_name)%f "
}
#
# Default prompt
PROMPT='%B${prompt_color}%* %n@%m:%1~%f $(parse_git_branch)${prompt_color}$%f %b'
#
# Other sometimes useful prompts
ps1-g() { # Reset to standard git prompt
    PS1='%B${prompt_color}%* %n@%m:%1~%f $(parse_git_branch)${prompt_color}$%f %b'
}
ps1-l() { # Long path
    PS1='%B${prompt_color}%n@%m:%~ $%f %b'
}
ps1-s() { # Short path
    PS1='%B${prompt_color}%n@%m:%1~ $%f %b'
}
ps1-n() { # No path
    PS1='%B${prompt_color}%n@%m: $%f %b'
}
ps1-0() { # No host
    PS1='%B${prompt_color}%n: $%f %b'
}
ps1-T() { # Time & history number
    PS1='%B${prompt_color}%* %n@%m:%h $%f %b'
}
ps1-t() { # Time without history number
    PS1='%B${prompt_color}%* %n@%m: $%f %b'
}

# Define aliases
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# end of .zshrc
