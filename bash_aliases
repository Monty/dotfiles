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
alias lsa='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias llh='_llh'
alias llr='ls -lR'
alias lls='_lls'
# with special chars to indicate file type
alias l='ls -CF'
alias la='ls -AF'
# with special colors to indicate file type
if [ $TERM != "dumb" ]; then
    alias lc='ls -G'
    alias lca='ls -AG'
    alias llc='ls -lG'
    alias llca='ls -lAG'
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
