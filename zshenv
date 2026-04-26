#!/usr/bin/env zsh
#
# ~/.zshenv
#
# New Terminal tab/window: Loaded 1st
# SSH session: Loaded 1st
# Console login: Loaded 1st
# Running a shell script: Loaded 1st (and only)
# Remote SSH command (ssh host 'ls'): Loaded 1st (and only)
#
# echo "### .zshenv at `date`"

# Path and uniqueness logic
typeset -U path PATH

# Source directory shortcuts so scripts can use $WS, $CE, etc.
if [[ -f ~/.directory_shortcuts ]]; then
    # shellcheck source=/dev/null
    source ~/.directory_shortcuts
fi

# Global Preferences
# shellcheck disable=SC2155
export PAGER=$(command -v moor || echo "less")
export EDITOR=/usr/bin/vim
export CLICOLOR=1

# Override defaults provided in IMDb_xref
export FULLCAST=50
# export NO_MENUS="yes"

# Setup other HOMES
if /usr/libexec/java_home >/dev/null 2>/dev/null; then
    JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME
fi

# pip and system local setup
# shellcheck disable=SC2206
[[ -d "/usr/local/bin" ]] && path=("/usr/local/bin" $path)

# golang setup
export GOPATH="$HOME/Projects/go"
# shellcheck disable=SC2206,SC2128
if [[ -d "/usr/local/go/bin" ]]; then
    path=("/usr/local/go/bin" $path)
fi

# Make sure rust utilities are in $PATH
if [[ -r "$HOME/.cargo/env" ]]; then
    # shellcheck source=/dev/null
    . "$HOME/.cargo/env"
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Make sure ~/.volta/bin is in $PATH
if [[ -d "$HOME/.volta" ]]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
fi

# Make sure swift utilities are in $PATH
if [[ -r "$HOME/.swiftly/env.sh" ]]; then
    # shellcheck source=/dev/null
    . "$HOME/.swiftly/env.sh"
    export PATH="$HOME/.swiftly/bin:$PATH"
fi

# Make sure private bin is in $PATH
if [[ -d "$HOME/bin" ]]; then
    export PATH="$HOME/bin:$PATH"
fi

# These are unique so shouldn't need to be elevated
for each in \
    $HOME/go/bin \
    /Applications/kitty.app/Contents/MacOS \
    /Applications/CMake.app/Contents/bin \
    /Applications/CotEditor.app/Contents/SharedSupport/bin \
    $HOME/.local/bin \
    $HOME/.lmstudio/bin \
    $HOME/Library/Python/3.9/bin \
    $HOME/Projects/dart-sass; do
    if [[ -d $each ]]; then
        [[ -d $each ]] && path+=("$each")
    fi
done
