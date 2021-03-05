#!/bin/bash

#download JSON
#quotes=`curl -s https://yandex.ru/news/quotes/graph_2000.json`

echo -n "Enter number of 'month':"
read month
if [[(($month -ge 1))&&(($month  -le 12))]]
   then
     echo "The lowest volatility in the month $month was in the year:"
   else
     echo "You enter wrong number month"
     exit
fi

#mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXX")


#create quotes table
#jq -r '.prices[][0] | (.)' quotes.json
#jq -jr '.prices[][0] |= (. / 1000 | strftime("%m-%Y"))' quotes.json  | jq -r '.prices[] | join("")' # | sort

#jq -jr '.prices[][0] |= (. / 1000 | strftime("%Y%m"))' $quotes | jq -r '.prices[]|join(" ")' # | grep 202103 | sort

# created new object JSON
# jq '{date: (.prices[][0] | (./1000 | strftime("%F"))), cost: .prices[][1]}' quotes.json > $mydir/new_quotes.json

# jq '.date' $mydir/new_quotes.json
# echo $quotes
# jq '.prices[][0], .prices[][1]' quotes.json 
# qu_pri=`jq '.prices[][]' quotes.json`
#dates=`jq -j '.prices[][0] | (./1000 | strftime("%F"))' quotes.json
dates=`jq -r '.prices[][0] | (./1000)' quotes.json`
#new_dates=`date -d @"$dates" "+%D"`
# echo -e "$new_dates"
# echo ${qu_pri} | awk '{print $0, NF}'

quot=$(jq -r '.prices[][]' quotes.json)
 
for new_dates in $dates;
do
tr_dates+=$(date --date=@$new_dates "+%m:%y-%t")
done
# echo  "$tr_dates"
jq 'keys' quotes.json
