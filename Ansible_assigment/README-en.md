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
