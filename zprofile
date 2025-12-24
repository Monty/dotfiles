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

[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
[[ -d "$HOME/.volta/bin" ]] && export PATH="$HOME/.volta/bin:$PATH"
[[ -d "$HOME/.swiftly/bin" ]] && export PATH="$HOME/.swiftly/bin:$PATH"
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"

# Others from .zshenv can remain at the end of $PATH
