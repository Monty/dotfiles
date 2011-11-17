# ~/.bash_aliases: sourced by ~/.bashrc
# echo "### .bash_aliases at `date`"

# Shortcut commands
alias catn='egrep -hv ^$\|^[[:space:]]*#\|^\;'
alias cls='clear'
alias cpr='cp -rp'
alias df='df -k'
alias du='du -k'
alias hgr='history | egrep'
alias ht='history | tail'
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

# Directory listings
# normal
alias ls='ls'
alias lsa='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias llh='_llh'
alias llr='ls -lR'
alias lls='_lls'
# with special chars to indicate file type
alias l='ls -CF'
alias la='ls -AF'

# Setup Rubies for MagLev comparison tests
if [[ ! -z "$RU" ]]; then
    alias ruby187="`ls -1d $RU/ruby-1.8.7* | tail -1`/bin/ruby"
    alias ruby192="`ls -1d $RU/ruby-1.9.2* | tail -1`/bin/ruby"
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
alias rakespecs='rake spec:ci | egrep -v "^/|^WARNING|^$|^\.$|^\(eval"'
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
alias ssh-bze='ssh -Y buildgss@zeke.gemstone.com'       # 10.118.32.5
alias ssh-co='ssh -Y congo.gemstone.com'                # 10.118.32.29
alias ssh-or='ssh -Y orpheus.gemstone.com'              # 10.118.32.36
alias ssh-gr='ssh -Y grace.gemstone.com'                # 10.118.32.105
alias ssh-he='ssh -Y hercules.gemstone.com'             # 10.118.32.204
#
alias ssh-st1='ssh w2-stdev-ub10-01.gemstone.com'       # 10.138.45.119
alias ssh-st2='ssh w2-stdev-rh6-01.gemstone.com'        # 10.138.45.120
alias ssh-st3='ssh w2-stdev-sl11-01.gemstone.com'       # 10.138.45.121
#
alias ssh-rb='ssh w2s2-gst-magtrac.eng.vmware.com'      # 10.255.18.41
alias ssh-ss='ssh w2s2-gst-seaside.eng.vmware.com'      # 10.255.18.42
alias ssh-ss3='ssh w2s2-gst-ss.eng.vmware.com'          # 10.255.18.50
alias ssh-esug='ssh w2s2-gst-esug.eng.vmware.com'       # 10.255.18.51
alias ssh-wdc1='ssh w2s2-gst-cf1.eng.vmware.com'        # 10.255.18.52
alias ssh-wdc2='ssh w2s2-gst-cf2.eng.vmware.com'        # 10.255.18.53
alias ssh-wdc3='ssh w2s2-gst-cf3.eng.vmware.com'        # 10.255.18.54
alias ssh-wdc4='ssh w2s2-gst-cf4.eng.vmware.com'        # 10.255.18.55
#
# Must use == not =~ to account for Bash 2.x
if [[ "`uname -n`" == *local* ]]; then
    alias ssh-mmj='ssh junew@macmini.local'
    alias ssh-mmm='ssh monty@macmini.local'
    alias ssh-moj='ssh junew@monarch.local'
    alias ssh-mom='ssh monty@monarch.local'
    alias ssh-mw='ssh montyandjune.homeip.net -p 3541'
    alias ssh-my='ssh mycroft.local'
    alias ssh-sh='ssh -Y shadow.local -p 3541'
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
    ls -lt $@ | head -20
}

function _lls () {
    ls -l $@ | grep -v ^d | sort -nr --key=5
}

# end of .bash_aliases
