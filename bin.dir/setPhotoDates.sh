#!/usr/bin/env bash
#
# Set jpg files starting with 6,7,8 to their respective dates

IFS=$'\n'
for file in [678]*-*.jpg; do
    yyyymmdd="$(echo "$file" | sed -e s/^/19/ -e s/-.*//)"
    # Doesn't work with leading zero or if -x- is included
    hh="$(echo "$file" | sed -e s/^....// -e s/^0// -e s/-.*//)"
    # need to add 12 to hh to account for 24 hour clock
    hh=$((hh + 12))
    mm="$(echo "$file" | sed -e s/^.......// -e s/^00/0/ -e s/-x-// -e s/\ .*//)"
    echo touch -t "$yyyymmdd$hh$mm" "$file"
done
