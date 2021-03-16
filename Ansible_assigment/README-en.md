# Connecting Ansible via ssh
***
If you chose to install an SSH server during the Debian installation,<br>
it will already be installed and running on the finished system. To check its status, run:<br>
`$ sudo systemctl status sshd`<br>
If the label active, running is displayed, then everything is fine.<br>
Otherwise, you need to install an SSH server. To do this, use the following command:<br>
`$ sudo apt install openssh-server ssh`<br>
`$ sudo systemctl start sshd` to start the service<br>
### Configuring the SSH server
***
Configuring the sshd service on the remote machine.

All SSH server settings are located in the `/etc/ssh/sshd_config file`.<br>
Before you edit it, it is better to make a backup copy just in case:<br>
`sudo cp /etc/ssh/sshd_config{,_back}`<br>

After changing sshd_config, you must restart the service:<br>
`$ sudo systemctl restart sshd`<br>

Change the following settings:

`Port 22` this default port ssh, if you changed this port,
then you will need to explicitly specify the port using the option
`-p` example - `ssh root@localhost -p 2222`<br>
`PermitRootLogin no` disable root access

### Authorization by key

How to generate SSH keys I told [here](https://github.com/Manexin/DevOps-Adndersen/blob/master/README.md).
 Now I'll tell you how to upload them to a remote server.
The easiest way to copy the key to a remote server, but for this method to work, you need to have a password to access the server via SSH.<br>
`$ ssh-copy-id username@remote_host`

When connecting for the first time, you will need to confirm adding the server key to the `~/.ssh/known_hosts file`.
Then enter your user password on the remote server.
 The utility will connect to the remote server, and then use the contents of the 
 id.rsa.pub key to upload it to the server in the `~/.ssh/authorized_keys file`.<br>
If that doesn't work, try this:<br>
```
`$ cat ~/.ssh/id_rsa.pub | ssh username@remote_host "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"`<br>
```
After then we can disable authorization password.<br>
Open the configuration file `/etc/ssh/sshd_config` and set the value `PasswordAuthenticatin No`<br>
Restart service sshd again.
### Installing Ansible.
***
`$ sudo apt-get update`<br>
`$ sudo apt-get install ansible`<br>
You can install Ansible via ' pip`, but there are some features that are partially described [here](https://github.com/Manexin/DevOps-Adndersen/blob/master/Ansible_assigment/issue-python3.md)<br>
***
#### Checking the installation
```
$ ansible --version
ansible 2.10.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/alex/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.7/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.7.3 (default, Jul 25 2020, 13:03:44) [GCC 8.3.0]
```

By default, Ansible searches for the configuration and inventory file in the folder from which it was launched, if there are no such files, then in `/etc/ansible/ansible.cfg`<br>
You can create these files for each project separately in the `./myProject/ansible` folder.
***
### Let's start writing our first ansible.cfg

```
[defaults]
host_key_checking  = false # disables confirmation for adding a new host to the known ones (if there are hundreds of servers, it will be very tedious)
inventory          = ./hosts # list of our servers, authorization methods, groups
interpreter_python = /usr/bin/python3.7 # exactly specify the path where to look for Python3
```
