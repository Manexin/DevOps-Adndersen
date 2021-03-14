1. Создаем каталог проекта и виртуальную среду `venv` :
`$ mkdir flaskProject`<br>
`$ cd flaskProject`<br>
`$ python3 -m venv venv`<br>
с этого момента мы работаем из каталога `flaskProject`
2. Прежде чем приступить к работе над своим проектом, активируем соответствующую среду:
`$ . venv/bin/activate`
3. В активированной среде устанавливаем Flask:
`$ pip3 install Flask`
4. Создаем макет проекта.
`flaskProject` - Сюда поместим само наше приложение.
`mkdir flaskProject/static` - для хранения статики, такой как картинки, js файлы и CSS.
`mkdir flaskProject/templates` - для хранения шаблонов.

5. Добавляем в .gitignor следующие данные:
`venv/

*.pyc
__pycache__/

instance/

.pytest_cache/
.coverage
htmlcov/

dist/
build/
*.egg-info/`<br>

6. В каталоге с нашим приложением создаем `__init__.py`
7. Теперь можем запустить приложение.
`$ export FLASK_APP=flaskProject`
`$ export FLASK_ENV=development`
`$ flask run`
Посетите http://127.0.0.1:5000 в браузере
----------
