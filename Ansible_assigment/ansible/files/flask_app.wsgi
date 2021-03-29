#!/usr/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/var/www/flask_app/flask_app/")

from app import app as application
application.secret_key = '123'
