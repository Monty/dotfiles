# ~/.bash_aliases: sourced by ~/.bashrc
# echo "### .bash_aliases at `date`"

# Shortcut commands
alias catc='egrep -h ^[[:space:]]*#\|^\;'
alias catn='egrep -hv ^$\|^[[:space:]]*#\|^\;'
alias cls='clear'
alias cpr='cp -Rp'
alias df='df -Hl'
alias du='du -sh'
alias hgr='history | egrep'
alias hgrt='_hgrt'
alias ht='history | cut -c 8- | tail'
alias more='less'
alias psx='ps -ef | head -1; ps -ef | grep'
alias sttysane='stty sane; stty iexten erase "^?" kill ^U intr ^C susp ^Z'
if type -p shfmt >/dev/null; then
    alias shf='shfmt -i 4 -s'
    alias shfd='shfmt -d -i 4 -s'
    alias shff='shfmt -f'
    alias shfl='shfmt -i 4 -s -l'
fi

# Prompts
alias ps1-T='export PS1="${TBAR}${BE_COLOR}\t \u@\h:\! \$${NO_COLOR} "'    # Time & history number
alias ps1-t='export PS1="${TBAR}${BE_COLOR}\t \u@\h: \$${NO_COLOR} "'      # Time without history number
alias ps1-l='export PS1="${TBAR}${BE_COLOR}\u@\h.local:\w \$${NO_COLOR} "' # Long path
alias ps1-s='export PS1="${TBAR}${BE_COLOR}\u@\h:\W \$${NO_COLOR} "'       # Short path
alias ps1-n='export PS1="${TBAR}${BE_COLOR}\u@\h: \$${NO_COLOR} "'         # No path
alias ps1-0='export PS1="${TBAR}${BE_COLOR}\u: \$${NO_COLOR} "'            # No host
# RVM prompt
alias ps1-r='export PS1="${TBAR}${BE_COLOR}\t \u@\h:\W ${RPROMPT}${BE_COLOR}\$${NO_COLOR} "'
# git prompt
alias ps1-g='export PS1="${TBAR}${BE_COLOR}\t \u@\h:\W ${GPROMPT}${BE_COLOR}\$${NO_COLOR} "'
# RVM and git prompt
alias ps1-x='export PS1="${TBAR}${BE_COLOR}\t \u@\h:\W ${RPROMPT}${GPROMPT}${BE_COLOR}\$${NO_COLOR} "'

# iTerm tab titles
alias psi-0='export PROMPT_COMMAND='\''echo -ne "\033]0;\007"'\'''
alias psi-d='export PROMPT_COMMAND='\''echo -ne "\033]0;${PWD##*/}\007"'\'''

# TERM number of color settings
alias xt-16='export TERM=xterm'
alias xt-88='export TERM=xterm-88color'
alias xt-256='export TERM=xterm-256color'

# We can only do --color=auto on Linux
if [ $(uname -s) == "Linux" ]; then
    COLOR_AUTO="--color=auto"
    COLOR_ALWAYS="--color=always"
    # These aliases only make sense if on Linux
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Directory listings
# normal
alias ls='ls $COLOR_AUTO'
alias lsa='ls -A $COLOR_AUTO'
# with special chars to indicate file type
alias l='ls -CF'
alias la='ls -AF'
# If exa is installed
if type -p exa >/dev/null; then
    alias ll='exa --git -s Name --colour=always -lg'
    alias lla='exa --git -s Name --colour=always -lga'
    alias llh='_lwh'                                     # Most recent 20
    alias llt='_lwt'                                     # Today only
    alias llr='exa --git -s Name --colour=always -lgR'   # Recurse
    alias lls='exa --git -s size -r --colour=always -lg' # size
    # Dirs first, then by extension - both without & with gitignored files
    alias lw='exa --git --git-ignore --group-directories-first -s ext --colour=always -lg'
    alias lwg='exa --git --group-directories-first -s ext --colour=always -lg'
else
    alias ll='ls -l $COLOR_AUTO'
    alias lla='ls -lA $COLOR_AUTO'
    alias llh='_llh' # Most recent 20
    alias llt='_llt' # Today only
    alias llr='ls -lR $COLOR_AUTO'
    alias lls='_lls' # size
fi

# Setup Rubies for MagLev comparison tests
if [[ -n $RU ]]; then
    alias ruby187="$(ls -1d $RU/ruby-1.8.7* | tail -1)/bin/ruby"
    alias ruby193="$(ls -1d $RU/ruby-1.9.3* | tail -1)/bin/ruby"
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
function _ms_ml() {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t maglev-ruby $@ | grep -v ^/
}
alias ms_mlg='_ms_mlg'
function _ms_mlg() {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t maglev-ruby -G fails -G breaks -G hangs -G crashes \
        $@ | grep -v ^/
}
alias ms_rb='_ms_rb'
function _ms_rb() {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t ruby $@ | grep -v ^/
}
alias ms_rbg='_ms_rbg'
function _ms_rbg() {
    $MAGLEV_HOME/spec/mspec/bin/mspec -t ruby \
        -G fails -G breaks -G hangs -G crashes $@ | grep -v ^/
}

# ssh shortcuts to various systems
# p m g
#
# Must use == not =~ to account for Bash 2.x
if [[ "$(uname -n)" == *[Ll]ocal ]]; then
    ssh-ho='ssh monty@holmes.local $@'
    ssh-ir='ssh monty@irene.local $@'
    ssh-kvm='ssh monty@Kubuntu-VM.local $@'
    ssh-ma='ssh junew@marleau.local $@'
    ssh-moj='ssh junew@monarch.local $@'
    ssh-mom='ssh monty@monarch.local $@'
    ssh-mvm='ssh monty@MojaveVM.local $@'
fi

# Functions
findf() {
    find . -name $*
}

finds() {
    find . -name $*\*
}

findw() {
    grep -h -o -E '\w+' $2 | sort -u | grep -i $1
}

_hgrt() {
    history | egrep $@ | tail -20
}

_llh() {
    ls -lt $COLOR_ALWAYS $@ | head -20
}

_llt() {
    today=$(date "+%b %e")
    ls -lt $COLOR_ALWAYS $@ | grep " $today "
}

_lls() {
    ls -l $COLOR_ALWAYS $@ | grep -v ^d | sort -nr --key=5
}

_lwh() {
    exa --git -s date -r --colour=always -lg $@ | head -20
}

_lwt() {
    today=$(date "+%e %b")
    exa --git -s date -r --colour=always -lg $@ | grep "$today "
}

# From various distros
colors() {
    local fgc bgc vals seq0

    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        echo
        echo
    done
}

# end of .bash_aliases
