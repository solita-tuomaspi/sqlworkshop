FROM postgres:14.0
LABEL Name=sqlworkshop Version=0.0.1
COPY workshop.sql /docker-entrypoint-initdb.d/