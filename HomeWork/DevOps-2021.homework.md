# Scripting assignments
## Turn this one-liner into a nice script:
```sh
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
* 1 point for parametrization: you might want to enter PID or name of another process as an argument
* 1 point for parametrization: you might want to see more results
* 1 point for parametrization: you might want to see other connection states
* 1 point for securing script execution and nice error messages
* 2 points for writing a README.md for what your script does
* 2 points for adding count of connections per organization to the final output
* 2 points for rewriting the functionality differently, say using `ss`, `sed`, built-ins like `"${VAR%%:*}"` (might be a separate script)

### Hints
* you probably should start with `sudo netstat -tunapl | less` # mnemonic is 'tuna, please'
* progress through pipes until it becomes clear what the thing is doing


## Become financial guru
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


## Unleash your creativity with GitHub
* write a script that checks if there are open pull requests for a repository. An url like `https://github.com/$user/$repo` will be passed to the script
* print the list of the most productive contributors (authors of more than 1 open PR)
* print the number of PRs each contributor has created with the labels
* implement your own feature that you find the most attractive: anything from sorting to comment count or even fancy output format
* ask your chat mate to review your code and create a meaningful pull request
* do the same for her xD
* merge your fellow PR! We will see the repo history

### Hints
* [Have a look here](https://github.com/trending) and `curl`
* Hey, why are you not telling us about the scoring?


# Ansible assignment
## Create and deploy your own service
### The development stage:
For the true enterprise grade system we will need Python3, Flask and emoji support. Why on Earth would we create stuff that does not support emoji?!

* the service listens at least on port 80
* the service accepts GET and POST methods
* the service should receive `JSON` object and return a string decorated with your favorite emoji in the following manner:
```sh
curl -XPOST -d'{"word":"evilmartian", "count": 3}' http://myvm.localhost/
💀evilmartian💀evilmartian💀evilmartian💀

curl -XPOST -d'{"word":"mice", "count": 5}' http://myvm.localhost/
🐘mice🐘mice🐘mice🐘mice🐘mice🐘
```
* bonus points for being creative when serving `/`

### Hints
* [installing flask](https://flask.palletsprojects.com/en/1.1.x/installation/#installation)
* [become a developer](https://flask.palletsprojects.com/en/1.1.x/quickstart/)
* [or whatch some videos](https://www.youtube.com/watch?v=Tv6qXtc4Whs)
* [dealing with payloads](https://www.digitalocean.com/community/tutorials/processing-incoming-request-data-in-flask)
* [Flask documentation](https://flask.palletsprojects.com/en/1.1.x/api/#flask.Request.get_json)
* what would you expect to see when visiting a random unknown website?

### The operating stage:
* create an ansible playbook that deploys the service to the VM
* make sure all the components you need are installed and all the directories for the app are present
* configure systemd so that the application starts after reboot
* secure the VM so that our product is not stolen: allow connections only to the ports 22,80,443. Disable root login. Disable all authentication methods except 'public keys'.
* bonus points for SSL/HTTPS support with self-signed certificates
* bonus points for using ansible vault

### Hints
* task:verify
* iptables, sshd_config
* good luck! ¯\_(ツ)_/¯
