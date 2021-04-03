FROM python:3.7-slim
COPY ./f_app /f_app
WORKDIR /f_app
RUN pip install -r ./requirements.txt
CMD ["python","./app.py"]
