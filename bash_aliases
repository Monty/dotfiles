# ~/.bash_aliases: sourced by ~/.bashrc
# echo "### .bash_aliases at `date`"

# Shortcut commands
alias catn='egrep -hv ^$\|^[[:space:]]*#\|^\;'
alias cls='clear'
alias cpr='cp -rp'
alias df='df -k'
alias du='du -k'
alias hgr='history | egrep'
alias ht='history | cut -c 8- | tail'
alias more='less'
alias psx='ps -ef | head -1; ps -ef | grep'
alias sttysane='stty sane; stty iexten erase "^?" kill ^U intr ^C susp ^Z'

# Prompts
alias ps1-T='export PS1="${TITLEBAR}$BLUE\t \u@\h:\! \$$BLACK "'  # Time & history number
alias ps1-t='export PS1="${TITLEBAR}$BLUE\t \u@\h: \$$BLACK "'    # Time without history number
alias ps1-l='export PS1="${TITLEBAR}$BLUE\u@\h:\w \$$BLACK "'     # Long path
alias ps1-s='export PS1="${TITLEBAR}$BLUE\u@\h:\W \$$BLACK "'     # Short path
alias ps1-n='export PS1="${TITLEBAR}$BLUE\u@\h: \$$BLACK "'       # No path
alias ps1-0='export PS1="${TITLEBAR}$BLUE\u: \$$BLACK "'          # No host
# RVM prompt
alias ps1-r='export PS1="${TITLEBAR}$BLUE\t \u@\h:\W ${RVM_PROMPT}$BLUE\$$BLACK "'
# git prompt
alias ps1-g='export PS1="${TITLEBAR}$BLUE\t \u@\h:\W ${GIT_PROMPT}$BLUE\$$BLACK "'
# RVM and git prompt
alias ps1-x='export PS1="${TITLEBAR}$BLUE\t \u@\h:\W ${RVM_PROMPT}${GIT_PROMPT}$BLUE\$$BLACK "'

# TERM number of color settings
alias xt-16='export TERM=xterm'
alias xt-88='export TERM=xterm-88color'
alias xt-256='export TERM=xterm-256color'

# We can only do --color=auto on Linux
if [ `uname -s` == "Linux" ]; then
    COLOR_AUTO="--color=auto"
    COLOR_ALWAYS="--color=always"
fi

# Directory listings
# normal
alias ls='ls $COLOR_AUTO'
alias lsa='ls -A $COLOR_AUTO'
alias ll='ls -l $COLOR_AUTO'
alias lla='ls -lA $COLOR_AUTO'
alias llh='_llh'
alias llr='ls -lR $COLOR_AUTO'
alias lls='_lls'
# with special chars to indicate file type
alias l='ls -CF'
alias la='ls -AF'

# Setup Rubies for MagLev comparison tests
if [[ ! -z "$RU" ]]; then
    alias ruby187="`ls -1d $RU/ruby-1.8.7* | tail -1`/bin/ruby"
    alias ruby193="`ls -1d $RU/ruby-1.9.3* | tail -1`/bin/ruby"
fi

# MagLev
alias bs='less -p^== $ML/BuildSteps.txt'
alias mlr='maglev-ruby'
alias mli='maglev-irb'
alias mlg='maglev-gem'
alias noparser='unset MagRpDEBUG_level'
alias oldparser='export MagRpDEBUG_level=-1'
alias newparser='export MagRpDEBUG_level=0'
alias newparser1='export MagRpDEBUG_level=1'
alias newparser2='export MagRpDEBUG_level=2'
#
# Commands to help execute specs
alias spec_summary='rake spec:ci | egrep -v "^/|^WARNING|^$|^\.$|^\(eval|^native"'
alias spec_errors='rake spec:ci | egrep "E$|F$|FAILED|ERROR"'
alias ms_ml='_ms_ml'
function _ms_ml () {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t maglev-ruby $@ | grep -v ^/
}
alias ms_mlg='_ms_mlg'
function _ms_mlg () {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t maglev-ruby -G fails -G breaks -G hangs -G crashes \
        $@ | grep -v ^/
}
alias ms_rb='_ms_rb'
function _ms_rb () {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t ruby $@ | grep -v ^/
}
alias ms_rbg='_ms_rbg'
function _ms_rbg () {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t ruby \
    -G fails -G breaks -G hangs -G crashes $@ | grep -v ^/
}

# ssh shortcuts to various systems
# p m g
#
# Must use == not =~ to account for Bash 2.x
if [[ "`uname -n`" == *[Ll]ocal ]]; then
    alias ssh-hoj='ssh junew@holmes.local'
    alias ssh-hom='ssh holmes.local'
    alias ssh-hu='ssh hudson.local'
    alias ssh-irj='ssh junew@irene.local'
    alias ssh-irm='ssh irene.local'
    alias ssh-moj='ssh junew@monarch.local'
    alias ssh-mom='ssh monty@monarch.local'
    alias ssh-my='ssh mycroft.local'
    alias ssh-sq='ssh olpc@Squeaky'
    alias ssh-st='ssh strider.local'
fi

# Functions 
function findf () {
    find . -name $* ;
}

function finds () {
    find . -name $*\* ;
}

function _catn () {
    grep -v ^$ $* | grep -v ^#
}

function _llh () {
    ls -lt $COLOR_ALWAYS $@ | head -20
}

function _lls () {
    ls -l $COLOR_ALWAYS $@ | grep -v ^d | sort -nr --key=5
}

# end of .bash_aliases
