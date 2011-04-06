# ~/.bashrc: executed by bash(1) for non-login shells.
# echo "### .bashrc at `date`"

# Don't put RVM in limited space home directory - it gets big over time
export RVM_HOME=$HOME/MagLev/rvm
# Whether or not to use RVM
export USE_RVM="true"
# MagLev version number. Called BUILDNUM for historical compatibility
if [ -e "$HOME/.maglev_version" ]; then
  export BUILDNUM="`grep ^[0-9] $HOME/.maglev_version | tail -1 | awk '{ print $1; }'`"
fi

# If not running interactively, skip most stuff
if [[ -n "$PS1" ]] ; then
  # echo "### .bashrc after interactive check"
  # start of "skip if not interactive"

  # Don't put duplicate lines or lines starting with spaces in the history
  export HISTCONTROL=ignoreboth
  export HISTSIZE=3000

  # Check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # Make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

  # Some useful environment variables
  export EDITOR=/usr/bin/vim
  export PAGER=less        # strongly advised for backwards scrolling
  export LESS=seMi

  # Make a sensible PATH and save it
  # Set PATH so it appends other useful directories if they exist
  for each in $HOME/bin \
    /usr/local/bin \
    /usr/local/git/bin \
    /usr/X11/bin
  do
    if [ -d $each ]; then
      # echo "### Found $each"
      if ! echo $PATH | egrep -s "(^|:)$each($|:)" > /dev/null; then
        PATH=${PATH}:$each
      fi
    fi
  done
  # It is often useful to be able to "reset" your path to a clean state.
  export SAVED_PATH=${PATH}

  # MagLev directory setup
  PLATFORM="`uname -sm | tr ' ' '-'`"
  export ML=$HOME/MagLev
  export MAGLEV_HOME=$ML/MagLev-$BUILDNUM.$PLATFORM
  export MH=$MAGLEV_HOME
  export PATH=$MH/bin:$PATH
  #
  export SRC=$MH/src
  export RBS=$MH/benchmark
  export SEASIDE_HOME=$MH/gemstone/seaside
  export EX=$MH/examples
  export WT=$EX/misc/WebTools
  # Setting GEMSTONE can override extent location during upgrade
  # export GEMSTONE=$MH/gemstone
  export MG=$ML/MagLev-RBS
  export GH=$ML/github
  export MP=$ML/maglev-github
  export MSPEC_HOME=$ML/github/mspec
  export RUBYSPEC_HOME=$ML/github/rubyspec

  # Setup other HOMES
  export RU=$RVM_HOME/rubies
  export JAVA_HOME=/Library/Java/Home
  export JRUBY_HOME=`ls -d $RU/jruby* | tail -1`
  export PATH=$PATH:$JRUBY_HOME/bin
  export RBX_HOME=`ls -d $RU/rbx* | tail -1`
  export PATH=$PATH:$RBX_HOME/bin

  # Prompts
  # Colors
  BLUE="\[\e[34;1m\]"
  RED="\[\e[0;31m\]"
  GREEN="\[\e[0;32m\]"
  BLACK="\[\e[0m\]"
  TITLEBAR='\[\e]2;\u@\H \w\a\]'
  # Functions to compute prompt strings
  function parse_rvm_impl {
  [ -x  "$RVM_HOME/bin/rvm-prompt" ] && [ ! -z  "`$RVM_HOME/bin/rvm-prompt`" ] && \
    echo "[`$RVM_HOME/bin/rvm-prompt`] "
  }
  #
  function parse_git_branch {
      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
  }
  # RVM
  if [ -x "$RVM_HOME/bin/rvm-prompt" ]; then
    # Ruby implementation RVM is using in GREEN
    RVM_PROMPT="$GREEN\$(parse_rvm_impl)"
  else
    unset RVM_PROMPT
  fi
  # Git
  if [ -e "`which git 2>/dev/null`" ]; then
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

# Load RVM
if [[ ! -z "$USE_RVM" ]]; then
  [[ -s "$RVM_HOME/scripts/rvm" ]] && source "$RVM_HOME/scripts/rvm"
fi

# end of .bashrc
