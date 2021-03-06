#!/bin/bash

#download JSON
#quotes=`curl -s https://yandex.ru/news/quotes/graph_2000.json`


#FUNCTIONS

get_true_dates (){
	        NORMAL_DATE=$(jq -c '.prices[][0] |= (./1000 | strftime ("%m-%Y")) | .prices[] | .[]' quotes.json)
		}
get_currency_rate (){
		CUR_RATE=$(jq -j '.prices[][1]' quotes.json)
		}
get_join_as (){
		local IFS="$1"; shift; echo "$*";
		}
true_quote (){
		NEW_QUOTE=
		}
# WORKED IF
#--------------------------------------
#echo -n "Enter number of 'month':"
#read month
#if [ $month -ge 1 ]&&[ $month -le 12 ]
#   then
#     echo "The lowest volatility in the month $month was in the year:"
#     if  [[ $month == [0-9] ]]
#        then
#          pattern=0$month
#        else
#          pattern=$month
#	fi
#   else
#     echo "You enter wrong number month"
#     exit
#fi
#--------------------------------------------------

#jq --arg date "03-15" '.prices[][0] |= (. / 1000 | strftime("%m-%Y")) | map(select(.prices[][0] == $date))' quotes.json

#jq -c '.prices[][0] |= (. / 1000 | strftime("%m-%Y")) | .prices[] | .[]' quotes.json

#mydir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXX")

#create quotes table

#jq -jr '.prices[][0] |= (. / 1000 | strftime("%m-%Y"))' quotes.json  # | jq -r '.prices[] | join("")' # | sort

#jq -jr '.prices[][0] |= (. / 1000 | strftime("%Y%m"))' $quotes | jq -r '.prices[]|join(" ")' # | grep 202103 | sort

# created new object JSON
# jq '{date: (.prices[][0] | (./1000 | strftime("%F"))), cost: .prices[][1]}' quotes.json > $mydir/new_quotes.json

# jq '.date' $mydir/new_quotes.json
# echo $quotes




#get_true_dates
# get_currency_rate
#echo "$NORMAL_DATE"
#echo "$CUR_RATE"
#WORKED
#QUOTE=$(paste <(echo "$NORMAL_DATE") <(echo "$CUR_RATE"))
#echo "$QUOTE"

#NOT WORKED
#test=$(xargs -L 1 get_join_as - "$NORMAL_DATE" "$CUR_RATE")
#echo -e "$test"
#get_join_as - t e   -- ''s"" t i n g 

#WORKED FOR
#for new_dates in $dates;
#do
#tr_dates+=$(date --date=@$new_dates "+%m:%y-%t")
#done
# echo  "$tr_dates"
