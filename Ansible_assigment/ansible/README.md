## Installation app to servers.

There are two playbooks in the repository, working playbook `plbk1.yml`, the second playbook would do the same but by roles. For now, we going to work with the first playbook.<br>
There are two groups in the file host **[STAGING]** and **[PROD]**. Add your servers to the appropriate group. And also you can to specify the username and path to the public key. This can be done in the host file or edit the corresponding file in the `group-vars` directory.<br>
The playbook uses external variables, so you need to start the playbook like this:<br>
`ansible-playbook plbk1.yml -e "MYHOSTS=PROD"`<br>
****
The playbook going to make the following:<br>
>1-Update Deb-cache
>2-Install curl
>3-Install rsync
>4-Install UFW
>5-Install Apache Web server
>6-Install mod_wsgi
>7-Install Python3
>8-Install PIP, venv
>9-Install virtualenv
>9a-Create venv and installing packages Flask, emoji
>10-Copy file wsgi
>11-Copy file apache
>12-Create folder for app
>13-Synchronization of src on the control machine to dest on the remote hosts
>14-Copy flask_app.service
>15a-Copy file rule for flask
>16-Start Apache Web Server Debian
>17-Start wsgi
>18-Started UFW
>19-Start service flask_app<br>

## How to use it app

To access the application, you need to use the following command:
`curl -XPOST -d'{"word":"flower", "count": 10}' http://your_server:8080/`
```
alex@debian-host:~$ curl -XPOST -d'{"word":"flower", "count": 10}' http://192.168.0.97:8080
🐝flower🐝flower🐝flower🐝flower🐝flower🐝flower🐝flower🐝flower🐝flower🐝flower
```
or enter in your browser `http://your_server:8080/` (but it doesn't fully work yet).
I'm going to write a playbook by roles and remove unnecessary tasks. And also I'm going to configure Apache and add SSL.
