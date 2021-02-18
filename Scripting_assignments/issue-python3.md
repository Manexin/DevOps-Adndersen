По умолчанию в Debian 10 установлен Python 2.7.16 и Python 3.7.3
Я установил Python 3.9.1 (если есть версия свежее почему бы ее не использовать)

# Обновляем зависимости

$ sudo apt update

$ sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

# Загружаем исходный код последней версии
$ wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz

# и распаковываем его
$ tar -xf Python-3.9.1.tgz

# Переходим в каталог Python3.9.1 и оптимизируем двоичный файл Python
 
~/Python-3.9.1$ ./configure --enable-optimizations

# Запускаем процесс сборки

$ make -j 4

# Когда сборка завершена, устанавливаем двоичные файлы Python. Используем altinstall вместо install, потому что позже будет перезаписан системный двоичный файл python3 по умолчанию

$ sudo make altinstall

# Меняем версию python3 по умолчанию

$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/local/python3.9 2
$ sudo update-alternatives --config python3
$ sudo update-alternatives  --set python3 /usr/bin/local/python3.9
$ python3 --version
 Python 3.9.1

# Вроде бы все хорошо, но при установки PIP возникли проблемы.
 
$ python -V
 Python 2.7.16

$ python3 -V 
 Python 3.9.1

 #Устанавливаем PIP для Python3
$ sudo apt update
$ sudo apt install python3-venv python3-pip

# и получаем вот такое предупреждение 
 
$ pip3 --version
WARNING: pip is being invoked by an old script wrapper. This will fail in a future version of pip.
Please see https://github.com/pypa/pip/issues/5599 for advice on fixing the underlying issue.
To avoid this problem you can invoke Python with '-m pip' instead of running pip directly.
pip 20.2.3 from /usr/local/lib/python3.9/site-packages/pip (python 3.9)

# Если меняем версию python3 по умолчанию на python3.7.3 то все нормально (только другая версия pip).

$ sudo update-alternatives --config python3
There are 2 choices for the alternative python3 (providing /usr/bin/python3).

  Selection    Path                      Priority   Status
------------------------------------------------------------
* 0            /usr/local/bin/python3.9   2         auto mode
  1            /usr/bin/python3.7         1         manual mode
  2            /usr/local/bin/python3.9   2         manual mode

Press <enter> to keep the current choice[*], or type selection number: 1
update-alternatives: using /usr/bin/python3.7 to provide /usr/bin/python3 (python3) in manual mode
$ pip3 --version
pip 18.1 from /usr/lib/python3/dist-packages/pip (python 3.7)


# Предупреждение прочитал, по ссылке тоже сходил, $PATH не много подправил, но не смог решить эту проблему.
# И при установке Ansible при помощи pip, Ansible ассоциируется с python 3.7, не зависимо от того какая версия стоит по умолчанию.

$ pip3 install ansible
$ ansible --version | grep "python version
  python version = 3.7.3 (default, Jul 25 2020, 13:03:44) [GCC 8.3.0]
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
