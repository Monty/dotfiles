# ~/.bash_aliases: sourced by ~/.bashrc
# echo "### .bash_aliases at `date`"

# Shortcut commands
alias catn='egrep -hv ^$\|^[[:space:]]*#\|^\;'
alias cls='clear'
alias cpr='cp -rp'
alias df='df -k'
alias du='du -k'
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
alias ps1-T='export PS1="${TBAR}${BE_COLOR}\t \u@\h:\! \$${NO_COLOR} "' # Time & history number
alias ps1-t='export PS1="${TBAR}${BE_COLOR}\t \u@\h: \$${NO_COLOR} "'   # Time without history number
alias ps1-l='export PS1="${TBAR}${BE_COLOR}\u@\h:\w \$${NO_COLOR} "'    # Long path
alias ps1-s='export PS1="${TBAR}${BE_COLOR}\u@\h:\W \$${NO_COLOR} "'    # Short path
alias ps1-n='export PS1="${TBAR}${BE_COLOR}\u@\h: \$${NO_COLOR} "'      # No path
alias ps1-0='export PS1="${TBAR}${BE_COLOR}\u: \$${NO_COLOR} "'         # No host
# git prompt
alias ps1-g='export PS1="${TBAR}${BE_COLOR}\t \u@\h:\W ${GPROMPT}${BE_COLOR}\$${NO_COLOR} "'

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
alias ll='ls -l $COLOR_AUTO'
alias lla='ls -lA $COLOR_AUTO'
alias llh='_llh'
alias llt='_llt'
alias llr='ls -lR $COLOR_AUTO'
alias lls='_lls'
# with special chars to indicate file type
alias l='ls -CF'
alias la='ls -AF'

# ssh shortcuts to various systems
# p m g
#
# Must use == not =~ to account for Bash 2.x
if [[ "$(uname -n)" == *[Ll]ocal ]]; then
    alias ssh-hoj='ssh junew@holmes.local $@'
    alias ssh-hom='ssh holmes.local $@'
    alias ssh-hu='ssh hudson.local $@'
    alias ssh-irj='ssh junew@irene.local $@'
    alias ssh-irm='ssh irene.local $@'
    alias ssh-moj='ssh junew@monarch.local $@'
    alias ssh-mom='ssh monty@monarch.local $@'
    alias ssh-my='ssh mycroft.local $@'
    alias ssh-sq='ssh olpc@Squeaky $@'
    alias ssh-st='ssh strider.local $@'
    alias ssh-ub='ssh ubuntu.local $@'
fi

# Functions
findf() {
    find . -name $*
}

finds() {
    find . -name $*\*
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
