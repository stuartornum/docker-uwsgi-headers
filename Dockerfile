FROM phusion/baseimage:0.9.16

ENV HOME /srv/app

RUN apt-get update && apt-get install -y python-pip python-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser --disabled-password --gecos "" app

ADD ./requirements.txt /requirements.txt
RUN /usr/bin/pip install -r /requirements.txt

RUN mkdir -p /srv/app
ADD . /srv/app
RUN chown -R app: /srv/app

EXPOSE 8000
USER app
WORKDIR /srv/app

ENTRYPOINT /usr/local/bin/uwsgi --ini /srv/app/uwsgi.ini