# Scripting assignments -- task 1

### So let's move on to solving the first task.

According to the task, we need to present the following one-line in the form of a nice script.

```sh
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
## Let's analyze in order what this one-line does.

1. `netstat` - is a command-line utility for working with the network, for displaying various network parameters depending on the specified options.<br>
   `-t` or `--tcp` - show tcp ports<br>
   `-u` or `--udp` - show udp ports<br>
   `-n` Show network addresses as numbers. Show ports as number, not letters. (443 - https, etc.)<br>
   `-a` Shows the status of all sockets; normally, sockets used by server processes are not shown.<br>
   `-p` Display the PID/Name of the process that created the socket.<br>
   `-l` or `--listening` - view only the listening ports.<br>
2. `awk '/firefox/ {print $5}'`in the output of the netstat command, we look for lines containing `firefox` and output the fifth column (ip+port)<br>
3. `cut -d: -f1` we cut the ports, leaving only IP<br>
4. `sort` sort (by the first character in the string)<br>
5. `uniq -c` looking for repeats of IP addresses and output the number of these repeats<br>
6. `sort` sort again<br>
7. `tail -n5` show last five IP addresses<br>
8. `grep -oP '(\d+\.){3}\d+'` output only IP (one or more decimal numbers with a dot three times and the last octet of IP)<br>
9. We send the result to the `while ' loop in which we run all the IP addresses through the whois command. Using` awk',
   we search for lines with `Organization:` and deduce the fact that after the `:` (name of the organization)

***
## And now let's look at why this one-liner does this and whether it can be simplified.

1. The `netstat` command from the deprecated `net-tools`, it would be more logical to use `ss` from the `iproute2` package instead,it is faster and shorter. We will take the same parameters, although `-n` can not be specified, we still cut off the ports.<br>
2. If we use `ss` then information we need will be in the `$6` collum.<br>
3. Here we leave everything so.<br>
4. The meaning of sorting. We remove it.<br>
5. Checking the IP for uniqueness is necessary, why do we need duplicate information. But why do we need the number of repetitions, we don't do anything with them?<br>
   Using `uniq -u`<br>
6. Again unnecessary sorting, remove.<br>
7. Here we leave it as it is (although you can print more lines)<br>
8. Since we used ' unique`, this operation is not necessary.<br>
9. Without a cycle, it will be difficult, we leave it.<br>

```sh
sudo ss -platu | awk '/firefox/ {print $6}' | cut -d: -f1 | uniq -u | tail -n5 | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
***
## Now for the fun part. My script.
Why do we need a script only for ' firefox` let's specify the connections of which applications we are interested in.<br>
1. When calling the script, we pass it the name that we are interested in as a variable.<br>
2. Check whether the variable was passed or not.<br>
3. If not, we display a message asking you to specify a variable.<br>
4. If yes, then we execute our script gradually.<br>
5. We save the intermediate results in temporary files, which we then delete. I tried using variables, but there were difficulties with them.<br>
6. If the specified application does not create network connections, then we display a message about this.<br>
7. If there are connections, run them through the loop and make a selection by `Organization` and 'City' (you can also add other fields).<br>
8. Show this information.<br>
9. For those IP addresses where these fields are missing, we show all the information about the IP.<br>

### Difficulties

There were several variants of the script, but this one is the most beautiful (in my opinion).<br>
There were problems passing a variable to awk as a template. Of the many trials and errors, this option worked best.<br>
I understand it intuitively, but I can hardly explain it.
It does not handle IPv6 correctly, so the -4 option is specified in `ss`. I don't know how to solve it, I haven't thought about it yet.<br>

## We eliminate the remark #1.

About creating/deleting temporary files

`rm ~/<file>` This is a very bad practice, so it is really not acceptable to do so.<br>
Let's use the `mktemp` utility with the `-d` parameter. <br>
We will create a temporary directory using the specified template `${TMPDIR:-/tmp/}$(basename $0).XXXXX`,<br>
where X is a random value, and in this directory we will save the temporary files of our script.<br>
If there are more serious security requirements, you can use the FIFO channel.<br>

In the process of writing the script and eliminating comments, we learned a lot about bash scripts, especially about awk.:)

## Remark #2

Changing the output at the request of the customer

Task-Add output: how many connections the app makes to each organization

Sorted the output of ' awk` and output unique lines indicating the number of repetitions

```sh
`echo -e "\nTOTAL:\n-------------------------------------------------\n`cat $mydir/count_org | sort | uniq -c`"`
```
