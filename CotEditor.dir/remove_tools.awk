#!/usr/bin/env awk -f
# Remove tool-use blocks from AI assistant chat exports.
#
# Removes any 4-line block matching:
#   line 1: blank
#   line 2: ````plaintext
#   line 3: anything EXCEPT a line starting with "Thought process"
#   line 4: ````
#
# Keeps "Thought process" blocks intact (with or without a subtitle).
# Also collapses runs of more than 2 consecutive blank lines to 2.
{
    # Shift the rolling 4-line buffer
    line[1] = line[2]
    line[2] = line[3]
    line[3] = line[4]
    line[4] = $0

    # Wait until buffer is full
    if (NR < 4) next

    # Check for a removable tool-use block:
    #   blank + ````plaintext + (not Thought process) + ````
    if (\
        line[1] == "" && line[2] == "````plaintext" &&
        line[3] !~ /^Thought process/ &&
        line[4] == "````"\
    ) {
        delete line
        next
    }

    # Collapse runs of blank lines > 2 to 2
    if (line[1] == "") {
        blank_count++

        if (blank_count > 2) next
    }
    else { blank_count = 0 }

    print line[1]
}

END {
    if (NR >= 4) {
        print line[2]
        print line[3]
        print line[4]
    }
    else {
        for (i = 1; i <= NR; i++) print line[i]
    }
}
