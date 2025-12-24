#!/usr/bin/env zsh
#
# ~/.zprofile
#
# New Terminal tab/window: Loaded 2nd
# SSH session: Loaded 2nd
# Console login: Loaded 2nd
# Running a shell script: Skipped
# Remote SSH command (ssh host 'ls'): Skipped
#
# echo "### .zprofile at `date`"

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

# Others from .zshenv can remain at the end of $PATH
