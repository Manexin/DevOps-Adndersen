#!/bin/bash

#download actual JSON
#quotes=$(curl -s https://yandex.ru/news/quotes/graph_2000.json)
curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json

#FUNCTIONS

get_true_dates (){
	        DATE_VALUE=$( jq -j '.prices[][0] |= (./1000 | strftime (" %m:%Y-")) | .prices[] | .[]' quotes.json)
		ARR_DATE_VALUE=(`echo "$DATE_VALUE"`)
		HUM_DATE_VALUE=$(echo "${ARR_DATE_VALUE[*]}" | sed 's/\s/\n/g' | awk -F'-' '{print $0}')
		}
get_choosing_month (){
		CHOOSE_MONTH=$(echo "$HUM_DATE_VALUE" | grep "$pattern:..")
		}

# Entering Month that are interested us.
echo -n "Enter the 'month' you are interested in: "
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

get_true_dates

get_choosing_month

min_y=2015
max_y=$(date +"%Y")

# We compare the volatility and show the year with the minimum volatility

for (( i="$min_y"; i<"$max_y"; i++ ))
  do
	min_y=$(( $min_y + 1 ))
	# Get array value in choose month of every year
	value_year=(`echo "$CHOOSE_MONTH" |cut -d':' -f2 | awk  -F'-' -v year="$i" '$1 ~ year {print $2}' | sort -n`)

	# Get volatility in choose month of every year
	volatility_year=$(echo "${value_year[*]}" | echo "scale=4; (${value_year[${#a[@]}-1]}-${value_year[0]})/2" | bc -l)
	echo "$i:$volatility_year"
# choose the year with the lowest volatility and print
done | sort -t':' -nk2 | head -n1 | cut -d':' -f1
