FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y python python-pip  && rm -rf /var/lib/apt/lists/*

COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt


ENTRYPOINT FLASK_APP=/app/application.py flask run --host=0.0.0.0 --port=8080
