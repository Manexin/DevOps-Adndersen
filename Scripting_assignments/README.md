# Scripting assignments. Task 1

### Итак, преступим к решению первой задачи.

По заданию нам необходимо представить следующий однострочник в виде красивого скрипта.

```sh
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
## Разберем по порядку, что делает этот однострочник.

1. `netstat` - это утилита командной строки для работы с сетью, для вывода на экран различных сетевых параметров в зависимости от указанных опций.<br>
   `-t` или `--tcp` - показать tcp порты<br>
   `-u` или `--udp` показать udp порты<br>
   `-n` Показывать сетевые адреса как числа. Показывает порты числами а не буквами (443 - https и т.д.)<br>
   `-a` Показывать состояние всех сокетов; обычно сокеты, используемые серверными процессами, не показываются.<br>
   `-p` Отобразить идентификатор/название процесса, создавшего сокет.<br>
   `-l` или `--listening` - посмотреть только прослушиваемые порты.<br>
2. `awk '/firefox/ {print $5}'` в выводе команды netstat ищем строки содержащие `firefox` и выводим пятый столбец (ip+port)<br>
3. `cut -d: -f1` отрезаем порты, оставляем только IP<br>
4. `sort` сортируем (по первому символу в строке)<br>
5. `uniq -c` ищем повторы IP адресов и выводим колличество этих повторов<br>
6. `sort` опять сортируем<br>
7. `tail -n5` выводим последние пять IP адресов<br>
8. `grep -oP '(\d+\.){3}\d+'` выводим только IP (одно и более десятичное число с точкой три раза и последний октет IP)<br>
9. Отправляем результат в цикл `while` в котором прогоняем все IP через команду whois. С помощью `awk` ищем строки с `Organization:` и выводим то что после `:` (имя организации)

***
## А теперь разберем зачем этот однострочник это делает и можно ли его упростить

1. Команда `netstat` из устаревшего пакета `net-tools`, вместо нее логичнее было бы использовать `ss` из пакета `iproute2`, она быстрее и короче.<br>
   Параметры возьмем такие же, хотя `-n` можно не указывать, порты мы все равно отрезаем.<br>
2. Если использум `ss` то нужная нам информация будет в `$6` столбце.<br>
3. Тут все так оставляем.<br>
4. Смысл сортировать. Убираем.<br>
5. Проверка IP на уникальность нужна, зачем нам дублирующая информация. Только зачем нам количество повторов, мы с ними ничиго не делаем?<br>
   Используем `uniq -u`<br>
6. Опять ненужная сортировка, убираем.<br>
7. Тут оставляем как есть. (хотя можно больше строк вывести)<br>
8. Т.к. мы использовали `uniq -u` то в этой операции нет необходимости.<br>
9. Без цикла быдет сложно, оставляем.<br>

```sh
sudo ss -platu | awk '/firefox/ {print $6}' | cut -d: -f1 | uniq -u | tail -n5 | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
***
## Теперь самое интересное. Мой скрипт.

Зачем нам скрипт только для `firefox` давайте будем указывать соодинения каких приложений нас интересуют.<br>
1. При вызове скрипта передаем ему название которое нас интересует в качестве переменной.<br>
2. Проверяем передали переменную или нет.<br>
3. Если нет выводим сообщение с просьбой указать переменную.<br>
4. Если да, то выполняем наш скрипт постепенно.<br>
5. Промежуточные результаты сохраняем в временные файлы, которые потом удаляем. Пробовал использовать переменные, но с ними были сложности.<br>
6. Если указанное приложение не создает сетевых соеденений, то выводим об этом сообщение.<br>
7. Если соединения есть, прогоняем их через цикл и делаем выборку по `Organization` и `City` (можно и другие поля добавить).<br>
8. Показываем эту иформацию.<br>
9. Для тех IP где эти поля отсутствуют, показываем всю информацию об IP.<br>

### Трудности

Было несколько вариантов скрипта, но этот самый красивый (на мой взгляд).<br>
Были проблемы передать в awk переменную в качестве шаблона. Из многочисленных проб и ошибок этот вариант подошел лучше всего. Интуитивно я его понимаю, но обьснить смогу с трудом.
Не корректно отрабатывает IPv6, поэтому в `ss` указана опция -4. Причину знаю, как решить еще не думал.<br> 
Английский вариант README напишу позже.

## Устраняем замечание №1 

O создании/удалении временных файлов

`rm ~/connect ~/ipPort ~/ip ~/last5ip ~/ipInfo` Это очень плохая практика, так действительно не допустимо делать. Воспользуемся утилитой `mktemp` с параметром `-d`. <br>
Будем создавать временную директорию по указанному шаблону `${TMPDIR:-/tmp/}$(basename $0).XXXXX` , где Х это рандомные значения, и уже в эту директорию будем сохранять временные файлы  нашего скрипта.<br>
Если имеются более серьезные требования к безопастности, то можно возпользоваться каналом FIFO.

## Замечание №2

Изменеие вывода по просьбе заказчика

Задание - Добавить вывод: сколько коннектов приложение делает к каждой организации

Осортировали вывод `awk` и вывели уникальные строки с указанием количества повторов<br>

```sh
`echo -e "\nTOTAL:\n-------------------------------------------------\n`cat $mydir/count_org | sort | uniq -c`"`
```
