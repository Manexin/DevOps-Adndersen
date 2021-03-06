#!/bin/bash

#download JSON
#quotes=`curl -s https://yandex.ru/news/quotes/graph_2000.json`


#FUNCTIONS

get_true_dates (){
	        DATE_VALUE=$(jq -j '.prices[][0] |= (./1000 | strftime (" %m:%y-")) | .prices[] | .[]' quotes.json)
		ARR_DATE_VALUE=(`echo "$DATE_VALUE"`)
		HUM_DATE_VALUE=$(echo "${ARR_DATE_VALUE[*]}" | sed 's/\s/\n/g' | awk -F'-' '{print $0}')
		}
get_choosing_date (){
		CHOOSE_DATE=$(echo "$NORMAL_DATE" | grep "0221:\n[0-9]+.[0-9]+") # ^"$pattern"20[0-9]{2})
		}


# jq -r --arg date "$1" '.prices[][0] |= (./1000 | strftime ("%m")) | .prices[] | .[] | map(select( . == $date))' quotes.json)

# WORKED IF
#--------------------------------------
echo -n "Enter number of 'month':"
read month
if [ $month -ge 1 ]&&[ $month -le 12 ]
   then
     echo "The lowest volatility in the month $month was in the year:"
     if  [[ $month == [0-9] ]]
        then
          pattern=0$month
        else
          pattern=$month
	fi
   else
     echo "You enter wrong number month"
     exit
fi
#--------------------------------------------------
echo "$pattern"
#jq --arg date "03-15" '.prices[][0] |= (. / 1000 | strftime("%m-%y")) | .prices[] | .[] | map(select( .prices[][0] == $date))' quotes.json

#jq --arg date "$pattern" -r '.prices[][0] |= ( . / 1000 | strftime("%m")) | .prices[] | .[] | map(select( .[] == $date)) | .[1]' quotes.json

get_true_dates
echo "$HUM_DATE_VALUE" | awk '/03:/ {print}'

#get_choosing_date "$pattern"
#echo "$CHOOSE_DATE"

#get_choosing_date
#echo "$CHOOSE_DATE"

#date=$(jq -j '.prices[][0] |= (./1000 | strftime (" %m:%y-")) | .prices[] | .[]' quotes.json)
#arr_date=(`echo "$date"`)
#DATE_VALUE=$(echo "${arr_date[*]}" | sed 's/\s/\n/g' | awk -F'-' '{print $0}')
#echo "$DATE_VALUE"

