FROM python:2.7-jessie
RUN apt-get update && apt-get install git && apt-get install -y vim && apt-get install -y python-mysqldb && pip install MySQL-python && pip install uwsgi
RUN git clone https://github.com/isislab/CTFd.git
WORKDIR CTFd
COPY ./server/uwsgi.ini ./uwsgi.ini
COPY ./docker-entrypoint.sh ./docker-entrypoint.sh
RUN ./prepare.sh
ENV DATABASE_URL="mysql://CTFd_user:mysql@mysql/CTFd?charset=utf8mb4"
EXPOSE 4000
ENTRYPOINT [ "./docker-entrypoint.sh" ]