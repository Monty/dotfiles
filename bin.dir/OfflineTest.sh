#!/bin/bash
# Keep a record in /tmp/internetlog of any times a system is unable to ping www.google.com
LOG=/tmp/internetlog
rm -f $LOG
echo "Started logging any offline minutes in $LOG $(date)"
echo "Started monitoring $(date)" >>$LOG
while (true); do
    ping -c1 -t 5 www.google.com >/dev/null 2>&1
    # shellcheck disable=2181
    if [ "$?" -gt "0" ]; then
        echo "$(uname -n) offline at:  $(date)" >>$LOG
    fi

    sleep 60
done
