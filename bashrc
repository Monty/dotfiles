# ~/.bashrc: executed by bash(1) for non-login shells.
# echo "### .bashrc at `date`"

# Define the OS we're running on
PLATFORM="$(uname -sm | tr ' ' '-')"
# Treat older and newer Intel based Macs the same
[ $PLATFORM = "Darwin-x86_64" ] && PLATFORM="Darwin-i386"

# If not running interactively, skip most stuff
if [[ -n $PS1 ]]; then
    # echo "### .bashrc after interactive check"
    # start of "skip if not interactive"

    # Don't put duplicate lines or lines starting with spaces in the history
    export HISTCONTROL=ignoreboth
    export HISTSIZE=3000

    # Include directory name in iTerm tab titles by default
    if [ $ITERM_SESSION_ID ]; then
        export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; '
    fi

    # Check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # Make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

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
        /usr/local/git/bin \
        /usr/X11/bin; do
        if [ -d $each ]; then
            # echo "### Found $each"
            if ! echo $PATH | egrep -s "(^|:)$each($|:)" >/dev/null; then
                PATH=${PATH}:$each
            fi
        fi
    done

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

    # Prompts
    # Colors
    BLUE="\[\e[34;1m\]"
    RED="\[\e[0;31m\]"
    GREEN="\[\e[0;32m\]"
    BLACK="\[\e[0m\]"
    TITLEBAR='\[\e]2;\u@\H \w\a\]'
    # Functions to compute prompt strings
    #
    function parse_git_branch() {
        git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
    }
    # Git
    if [ -e "$(which git 2>/dev/null)" ]; then
        # git branch in RED
        GIT_PROMPT="$RED\$(parse_git_branch)"
    else
        unset GIT_PROMPT
    fi
    # Default prompt
    export PS1="${TITLEBAR}$BLUE\t \u@\h:\W ${RVM_PROMPT}${GIT_PROMPT}$BLUE\$$BLACK "

    # Define aliases
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # end of "skip if not interactive"
fi

# end of .bashrc
