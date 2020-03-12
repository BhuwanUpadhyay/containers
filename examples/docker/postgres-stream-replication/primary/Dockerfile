FROM postgres:9.6.17-alpine
COPY init-primary-setup.sh /docker-entrypoint-initdb.d/init-primary-setup.sh
RUN chmod 0666 /docker-entrypoint-initdb.d/init-primary-setup.sh