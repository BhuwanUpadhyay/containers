FROM postgres:9.6.17-alpine
COPY prebuildfs/setup.sh /docker-entrypoint-initdb.d/setup.sh
RUN chmod 0666 /docker-entrypoint-initdb.d/setup.sh