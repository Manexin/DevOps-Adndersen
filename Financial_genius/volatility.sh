#!/bin/bash

#download JSON
quotes=`curl -s https://yandex.ru/news/quotes/graph_2000.json`

#create quotes table
jr -r '.prices[][]' $quotes
echo $quotes
# jq -r '.prices[][0] | (./1000 | strftime("%m-%Y"))' $quote

