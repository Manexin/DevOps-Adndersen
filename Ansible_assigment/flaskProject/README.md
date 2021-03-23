## Flask project. Installed flask and configuring it.

----------
1. Create a project directory and virtual environment `venv` :<br>
`$ mkdir flaskProject`<br>
`$ cd flaskProject`<br>
`$ python3 -m venv venv`<br>
from now on we work from the catalog `flaskProject`
2. Before we start working on our project, we activate the appropriate environment:<br>
`$ . venv/bin/activate`
3. Install Flask in the activated environment:<br>
`$ pip3 install Flask`
4. Create a project layout.<br>
`flaskProject` - Here we put our app itself.<br>
`mkdir flaskProject/static` - for storing statics such as images, JS files and CSS.<br>
`mkdir flaskProject/templates` - for storing templates.
5. Add the following data to .gitignor:<br>

     >venv/<br>
     *.pyc<br>
     \_\_pycache__/<br>
     instance/<br>
     .pytest_cache/<br>
     .coverage<br>
     htmlcov/<br>
     dist/<br>
     build/<br>
     *.egg-info/<br>

6. In the folder with our application, we create `__init__.py`
7. Now we can launch the application.<br>/
`$ export FLASK_APP=flaskProject`<br>
`$ export FLASK_ENV=development`<br>
`$ flask run`<br>
Visit http://127.0.0.1:5000 in a browser
----------
