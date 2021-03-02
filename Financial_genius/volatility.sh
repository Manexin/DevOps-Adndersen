#!/bin/bash

#download JSON
#quotes=`curl -s https://yandex.ru/news/quotes/graph_2000.json`

mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXX")
#create quotes table
#jq -c '.prices' quotes.json

#created new object JSON
jq '{date: (.prices[][0] | (./1000 | strftime("%F"))), cost: .prices[][1]}' quotes.json > $mydir/new_quotes.json

jq '.date' $mydir/new_quotes.json
#echo $quotes
#jq '.prices[][0], .prices[][1]' quotes.json 
#qu_pri=`jq '.prices[][]' quotes.json`
#dates=`jq -r '.prices[][0] | (./1000 | strftime(%F))' quotes.json`
#echo $dates
#echo ${qu_pri} | awk '{print $0, NF}'
