#!/bin/bash

# Check whether the script is running with the argument or not.
if [[ -n "$1" ]]
then
    # Creating a directory for temporary files.
    mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXX")

    # Getting network data
    ss -4platu > $mydir/connect

    # We make a pattern matching in accordance with the accepted argument.
    awk -v pattern="$1" '$7 ~ pattern {print $6}' $mydir/connect > $mydir/ipPort

    # In the received data, we leave the last five unique IP addresses without ports.
    cut -d: -f1 $mydir/ipPort | uniq -u > $mydir/ip
    tail -n5 $mydir/ip > $mydir/last5ip

    # Check whether there are network connections for the specified process.
    if [[ -s $mydir/last5ip  ]]
       then
         touch $mydir/count_org

         # Getting information about IP addresses
         for IP in $(cat $mydir/last5ip)
           do
            whois $IP > $mydir/ipInfo
            awk -F':' '/^Organization/ {print $2}' $mydir/ipInfo  >> $mydir/count_org
            awk -F':' '$1 ~ /[nN]ame/ {print}' $mydir/ipInfo  > $mydir/name
         done

         # Showing the number of connections from the organization
         echo -e "\n`cat $mydir/count_org`"
         echo -e "\nTOTAL:\n-------------------------------------------------\n`cat $mydir/count_org | sort | uniq -c`"

         #If there is no data about the organization, we show another information. Example - Name.
         if [[ -s $mydir/count_org ]]
            then
                echo -e "\nThe connections created by the $1 process are shown.\n"
            else
                echo "Organization and City is not known for this procces! See all information about the connections of process $1 ."
                cat $mydir/name
         fi

         # Deleting the temporary directory. I'm not sure that you can do this, but it seems nothing criminal.
         rm -r $mydir
       else
         echo "Process not found, please try another process."
     fi
else
    echo "When calling the script, specify the process name as a variable."
fi
