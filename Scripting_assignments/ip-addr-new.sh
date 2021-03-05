#!/bin/bash
#This script determines the OrgName that the IP address belongs to and the amount of connections.

get_process_netstat () {
                        IP_ADDR=$(ss -4platu | awk -v pattern="$1" '$7 ~ pattern {print $6}' | cut -d: -f1)
                       }
# Check whether the script is running with the argument or not.
if [[ -n "$1" ]]
 then

    # We make a pattern matching in accordance with the accepted argument.
    get_process_netstat $1

    # Select the 5 IP-addresses with the highest number of connections
    last5_ip=`echo -e "$IP_ADDR" | sort | uniq -c | sort | tail -n 5`

    # Fetching and Outputting data
    echo "Number of TCP connections established to these IP-addresses:"
    echo -e "$last5_ip\n\nName and quantity of organizations:\n----------------------------------------------------------"
    echo -e "$last5_ip" | awk '{print $2}' | xargs -L 1 whois | awk -F':' '/^OrgName/ {print $2}' | sort | uniq -c | sort

    # Check whether there are network connections for the specified process.
    if [[ -z $IP_ADDR ]]
       then
        echo "Process not found, please try another process."
       else
         echo "END"
    fi
else
   echo "When calling the script, specify the process name as a variable. Example: bash ip-addr-new.sh nextcloud"
fi
