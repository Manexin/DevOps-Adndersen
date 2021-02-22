#!/bin/bash

if [[ -n "$1" ]]
then
    ss -4platu > ~/connect
    awk -v pattern="$1" '$0 ~ pattern {print $6}' ~/connect > ~/ipPort
    cut -d: -f1 ~/ipPort | uniq -u > ~/ip
    tail -n5 ~/ip > ~/last5ip
    if [[ -s ~/last5ip  ]]
    then
        for IP in $(cat ~/last5ip)
        do
           whois $IP > ~/ipInfo
           OrgCi=$(awk -F':' '/^Organization/ {print $2}/^City/ {print $2}' ~/ipInfo)
           echo "$OrgCi"
        done
        if [[ -z $OrgCi ]]
           then
               echo "Organization and City is not known for this procces! See all information about the connections of process $1 ."
               cat ~/ipInfo
           else
               echo "If you want other information, edit the script!"
         fi
        rm ~/connect ~/ipPort ~/ip ~/last5ip ~/ipInfo
    else
        echo "Process not found, please try again"
    fi
else
    echo "When calling the script, specify the process name as a variable."
fi
