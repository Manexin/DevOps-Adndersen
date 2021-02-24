#!/bin/bash

if [[ -n "$1" ]]
then
    mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXX")
    ss -4platu > $mydir/connect
    awk -v pattern="$1" '$0 ~ pattern {print $6}' $mydir/connect > $mydir/ipPort
    cut -d: -f1 $mydir/ipPort | uniq -u > $mydir/ip
    tail -n5 $mydir/ip > $mydir/last5ip
    if [[ -s $mydir/last5ip  ]]
    then
        for IP in $(cat $mydir/last5ip)
        do
           whois $IP > $mydir/ipInfo
           OrgCi=$(awk -F':' '/^Organization/ {print $2} /^City/ {print $2}' $mydir/ipInfo)
           echo "$OrgCi"
        done
        if [[ -z $OrgCi ]]
           then
               echo "Organization and City is not known for this procces! See all information about the connections of process $1 ."
               cat $mydir/ipInfo
           else
               echo "If you want other information, edit the script!"
         fi
         rm -r $mydir
    else
        echo "Process not found, please try again"
    fi
else
    echo "When calling the script, specify the process name as a variable."
fi
