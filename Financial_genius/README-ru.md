# Task 2
****
## Стань финансовым гуру
```sh
# Download the database
curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json
```
Now you have historical quotes for EUR/RUB pair since late November 2014. It's time to have some fun:
```sh
# let's get the mean value for the last 14 days and decide whether to buy Euros:
jq -r '.prices[][]' quotes.json | grep -oP '\d+\.\d+' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'
```
* try to understand the command above. Read something related to `jq` and `awk`.
* remove the `grep -oP '\d+\.\d+'` part, do the same thing without any pattern matching
* tell me which March the price was the least volatile since 2015? To do so you'll have to find the difference between MIN and MAX values for the period.

### Hints
* man date
* Yandex likes zeroes!
****
# Решение задачи!

По опыту из первого задания, сначала разберем однострочник и поймем что в нем происходит.

`curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json`

Загружаем котировки в файл `quotes.json` , но если мы хотим всегда актуальные данные, то это нодо делать в скрипте.

```sh
# let's get the mean value for the last 14 days and decide whether to buy Euros:
jq -r '.prices[][]' quotes.json | grep -oP '\d+\.\d+' | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'
```

Для работы с JSON есть утилита `jq`, ее надо предварительно установить `sudo apt install jq` предварительно обновив зависимости `sudo apt update`
Теперь по однострочнику:
1. С помощью `jq` парсим файл `quotes.json` по полю обьекта `.prices` данные выводим в stdout в raw формате.
2. Грепаем по регулярке, которая соответствует цене.
3. Показываем последние 14 результатов.
4. При помощи awk суммируем эти значения и делим на 14.

***
Т.е. находим среднее арифметическое значение курса за последние 14 дней.
Вместо `grep -oP '\d+\.\d+'` можно применить фильтры `jq`

`jq -r '.prices[][1]' quotes.json | tail -n 14 | awk -v mean=0 '{mean+=$1} END {print mean/14}'`

этот однострочник делает то же самое.
***

продолжение следует......
Проблемы:
1. Формат времени -- РЕШЕНО
Есть у jq встроенная функция форматирования времени `todate` она же `todateiso8601`, но есть также 
и `strftime` она мне понравилась больше, поэтому использую ее.
2. Выборка нужных месяцев -- В ПРОЦЕССЕ
3. Подсчет волатиьности в каждом выбраном месяце
4. Подведение итогов (подсчет лучшего месяца)
5. Вывод информации пользоватлю.
