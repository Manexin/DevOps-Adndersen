# Installing Ansible on Debian

Debian users may leverage the same source as the Ubuntu PPA.

Add the following line to /etc/apt/sources.list:

`deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main`

Then run these commands:

`$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367`
`$ sudo apt update`
`$ sudo apt install ansible`
