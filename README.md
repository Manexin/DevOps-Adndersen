# DevOps course
### This repository is created for doing homework as part of the company's DevOps course [Andersen](https://andersenlab.com/)
***
As you complete the tasks, I will add README.md a description of the work done, the problems encountered and how to solve them, as well as useful links where I drew inspiration. :smirk:
***
# Let's start!
## Preparing the working environment.
To perform the work, I have at my disposal:<br>
 `Processor	AMD Ryzen 5 3600 6-Core Processor, 3593 Mhz, 6 Core(s), 12 Logical Processor(s)`<br>
 `Installed Physical Memory (RAM)	16.0 GB`<br>
 `OS Name	Microsoft Windows 10 Enterprise LTSC`<br>
 `Version	10.0.17763 Build 17763`<br>
***
According to the task, we will need a host and target with Debian 10.<br>
To do this, install `VirtualBox Graphical User Interface Version 6.1.16 r140961 (Qt5.6.2)`<br>
Creating a new VM:
* Specify the name * VM*
* Select the type * Linux*
* Select the version * Debian (64-bit)*
* Select the size of RAM (I did 4096MB for each VM)
* Select create a virtual disk (if the disk is already there, then specify it)
* Specify the virtual disk type (*VDI*)
* Set the dynamic disk size
* And specify the maximum disk size
 ****
Next, we need to download the Debian 10 distribution, take it [here](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.8.0-amd64-netinst.iso).
Insert it into the virtual disk drive of the created VM and run it. When installing, follow the instructions and recommendations (read the docks). There were no special criteria for installing Debian 10, so I install the version with GUI, SSH server, and standart system utilities.
After installing Debian, we configure the network. In VirtualBox on our machine, we change the type of network adapter from NAT to Bridge. If you do not plan to connect remotely, you can not change it. And for remote work, NAT interferes.
We install the sudo, net-tools packages (they say that this is for old believers, but I use it).<br>
`$ su root` \\it is logical that if there is no sudo, then install it as root<br>
`Password:` \\password<br>
`$ apt update` \\ updating links<br>
`$ apt install sudo` \\ installing sudo<br>
`$ apt install net-tools` \\ installing net-tools<br>
We have installed the sudo package, all that remains is to add our user to the necessary groups.<br>
This is done like this<br>
`$ usermod -aG sudo user`<br>
or so, open it<br>
`$sudo nano /etc/group` and add the user to the necessary groups.<br>
After that, you need to reboot `$ sudo reboot`<br>
Installing it `Guest Additions:`
  * CD to the virtual disk drive.
  * We forget about autorun, it doesn't work here (at least it didn't work for me).
  * Go to the disk `$ cd /media/cdrom`
  * And run the script `$ sudo sh ./VBoxLinuxAdditions.run`
  * Enjoy it.

### It seems to be possible to work.
### I almost forgot, setting up * ssh*!
Checking whether the service is running *ssh*<br>
`$ sudo service ssh status`<br>
if the service is disabled, then<br>
`$sudo service ssh start`<br>
Generate a pair of ssh keys, we will need them in the future.<br>
`$ ssh-keygen`<br>
and we inform the system (ssh-agent) about our keys<br>
`$ ssh-add`<br>
`~/.ssh/id_rsa` this is a private key, we do not show it to anyone!<br>
`~/.ssh/id_rsa_pub` this is a public key<br>

## Well, that's it, now we seem to be ready. For remote access, I use MobaXterm, but if you like everything old, then you can putty)))
****
 
To perform the first homework, directories corresponding to the task names are created. In each of them in the file README.md it will describe the progress of the tasks, as well as the problems and difficulties that you will have to face in the process of completing them.
