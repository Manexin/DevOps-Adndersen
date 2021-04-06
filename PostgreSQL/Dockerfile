FROM postgres
MAINTAINER Manexin

RUN apt-get update&&apt-get install -y nano

VOLUME ["/var/lib/postgresql/data", "/var/log/postgresql"]

CMD ["postgres"]
