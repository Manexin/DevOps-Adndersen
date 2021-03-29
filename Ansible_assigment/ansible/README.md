## How to use it

There are two playbooks in the repository, working playbook `plbk1.yml`,<br>
the second playbook would do the same but by roles.
For now, we going to work with the first playbook.<br>
There are two groups in the fale host **[STAGING]** and **[PROD]**.<br>
Add your servers to the appropriate group.<br> 
And also you can to specify the username and path to the public key.<br>
This can be done in the host or edit the corresponding file in the `group-vars` directory.<br>
The playbook uses external variables, so you need to start the playbook like this:<br>
`ansible-playbook plbk1.yml -e "MYHOSTS=PROD"`<br>
----
The playbook going to make the following:<br>
>1-Update Deb-cache<br>
>2-Install curl<br>
>3-Install rsync<br>
>4-Install UFW<br>
>5-Install Apache Web server<br>
>6-Install mod_wsgi<br>
>7-Install Python3<br>
>8-Install PIP, venv<br>
>9-Install virtualenv<br>
>9a-Create venv and installing packages Flask, emoji<br>
>10-Copy file wsgi<br>
>11-Copy file apache<br>
>12-Create folder for app<br>
>13-Synchronization of src on the control machine to dest on the remote hosts<br>
>14-Copy flask_app.service<br>
>15a-Copy file rule for flask<br>
>16-Start Apache Web Server Debian<br>
>17-Start wsgi<br>
>18-Started UFW<br>
>19-Start service flask_app<br>
