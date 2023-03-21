FROM postgres:15.2
LABEL Name=sqlworkshop Version=0.0.1
COPY workshop.sql /docker-entrypoint-initdb.d/