# DevOps course
Этот репозиторий создан для выполнения домашних заданий в рамках курса DevOps от компании [Andersen](https://andersenlab.com/)
***
По мере выполнения заданий я буду дополнять REDME.md описанием выполнения работы, возникшими проблемами и способами их решения, а также полезными ссылками, где я черпал вдохновение.)
***
# Поехали!
## Подготовка рабочего окружения.
Для выполнения работ в моем распоряжении имется:
 `Processor	AMD Ryzen 5 3600 6-Core Processor, 3593 Mhz, 6 Core(s), 12 Logical Processor(s)`<br>
 `Installed Physical Memory (RAM)	16.0 GB`\n
 `OS Name	Microsoft Windows 10 Enterprise LTSC`
 `Version	10.0.17763 Build 17763`
***
По заданию нам понадобиться host и target с Debian 10.
Для этого устанавливаем `VirtualBox Graphical User Interface Version 6.1.16 r140961 (Qt5.6.2)`
Создаем новую виртуальную машину:
  * Указываем имя VM
  * Выбираем тип -- Linux
  * Выбираем версию   Debian(64-bit)
  * Выбираем размер оперативной памяти (я делал 4096MB для каждой VM)
  * Выбираем создать виртуальный диск (если диск уже есть, то указываем его)
  * Указываем тип виртуального диска (VDI)
  * Задаем динамический размер диска
  * И указываем максимальный размер
 ****
Далее нам надо скачать дистрибутив Debian 10, берем его [здесь](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.8.0-amd64-netinst.iso).
Вставляем его в виртуальный дисковод созданной VM и запускаем ее. При установке следуем инструкциям и рекомендациям (читаем доки). Критериев по установке Debian 10 особых не было, по этому я устанавливаю версию с GUI, SSH server, standart system utilities.
После установки Debian настраиваем сеть. В VirtualBox на нашей машине меняем тип сетевого адаптера с NAT на Brige. Если удаленно не подключаться, то можно не менять. А для удаленной работы мешает NAT.
Устанавливаем пакеты sudo, net-tools (говорят что это для староверов, но я пользуюсь)
`$ su root` \\логично что если sudo нет, то устанавливаем от имени root
`Password:` \\пароль
`$ apt update` \\ обновляем ссылки
`$ apt install sudo` \\ устанавливаем sudo
`$ apt install net-tools` \\ устанавливаем net-tools
Пакет sudo мы установили, осталось добавить нашего пользователя в нужные группы.
Это делается так
`$ usermod -aG sudo user`
или так, открываем `$sudo nano /etc/group` и дописываем пользователя в нужные группы. После этого необходимо перезагрузится `$ sudo reboot`
Устанавливаем `Guest Addision:`
  * CD в виртуальный дисковод.
  * Про autorun забываем, он тут не работает.
  * Заходим на диск `$ cd /media/cdrom`
  * И запускаем скрипт `$ sudo sh ./VBoxLinuxAdditions.run`
  * Наслаждаемся.

### Вроде бы можно работать.
### Чуть не забыл, настраиваем ssh!
Проверяем запущена ли служба ssh
`$ sudo service ssh status`
если служба отключена, то
`$sudo service ssh start`
Генерим пару ssh ключей, они нам понадобятся в дальнейшем.
`$ ssh-keygen`
и сообщаем системе (ssh-agent) о наших ключах
`$ ssh-add`
~/.ssh/id_rsa это закрытый ключ, никому его не показываем
~/.ssh/id_rsa_pub это публичный ключ

## Ну все, теперь вроде готовы. Для удаленного доступа я пользуюсь MobaXterm, но если любите все старое, то можно putty)))
****
 
Для выполнения первой домашней работы созданы дириктории соответствующие назвыниям заданий. В каждой из них в файле README.md будет описан ход выполнения заданий, а также проблемы и сложности с которыми придется столкнуться в процессе их выполнения.
