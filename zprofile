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

# "Double Tap" to restore elevated path order
for each in \
    $HOME/.cargo/bin \
    $HOME/.volta/bin \
    $HOME/.swiftly/bin \
    $HOME/.local/bin \
    $HOME/bin; do
    # shellcheck disable=SC2206
    if [[ -d $each ]]; then
        path=("$each" $path)
    fi
done

# Others from .zshenv can remain at the end of $PATH
