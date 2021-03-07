#!/bin/bash

#download JSON
#quotes=`curl -s https://yandex.ru/news/quotes/graph_2000.json`


#FUNCTIONS

get_true_dates (){
	        DATE_VALUE=$(jq -j '.prices[][0] |= (./1000 | strftime (" %m:%y-")) | .prices[] | .[]' quotes.json)
		ARR_DATE_VALUE=(`echo "$DATE_VALUE"`)
		HUM_DATE_VALUE=$(echo "${ARR_DATE_VALUE[*]}" | sed 's/\s/\n/g' | awk -F'-' '{print $0}')
		}
get_choosing_month (){
		CHOOSE_MONTH=$(echo "$HUM_DATE_VALUE" | grep "$pattern:..")
		}

get_volatility_month (){
		VOL_MONTH=
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
     echo -e "There is no such month.\nWe could input month number from 1 to 12, example 3 or 03"
     exit
fi
#--------------------------------------------------


get_true_dates
get_choosing_month

min_y=15
max_y=$(date +"%y")


for (( i="$min_y"; i<"$max_y"; i++ ))
do

min_y=$(( $min_y + 1 ))
value_year=(`echo "$CHOOSE_MONTH" |cut -d':' -f2 | awk  -F'-' -v year="$i" '$1 ~ year {print $2}' | sort -n`)
volatility_year=$(echo "scale=4; (${value_year[-1]}-${value_year[0]})/2" | bc -l)
echo "$volatility_year"

done


#echo "$CHOOSE_MONTH" |cut -d':' -f2 | awk  -F'-' -v year="$min_y" '$1 ~ year {print $2}' | sort -n
#value_year=(`echo "$CHOOSE_MONTH" |cut -d':' -f2 | awk  -F'-' -v year="$min_y" '$1 ~ year {print $2}' | sort -n`)
#volatility_year=$(echo "scale=4; (${value_year[-1]}-${value_year[0]})/2" | bc -l)
#echo "$volatility_year"

#while [ $min_y -le $max_y ]
#do
#min_y=$(( $min_y + 1 ))
#value_year=(`echo "$CHOOSE_MONTH" |cut -d':' -f2 | awk  -F'-' -v year="$min_y" '$1 ~ year {print $2}' | sort -n`)
#volatility_year=$(echo "scale=4; (${value_year[-1]}-${value_year[0]})/2" | bc -l)
#echo "$volatility_year"

#done


#get_choosing_date
#echo "${CHOOSE_DATE[*]}"

#date=$(jq -j '.prices[][0] |= (./1000 | strftime (" %m:%y-")) | .prices[] | .[]' quotes.json)
#arr_date=(`echo "$date"`)
#DATE_VALUE=$(echo "${arr_date[*]}" | sed 's/\s/\n/g' | awk -F'-' '{print $0}')
#echo "$DATE_VALUE"

