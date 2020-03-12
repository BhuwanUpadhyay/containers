FROM postgres:9.6.17-alpine
RUN apk add --update curl iputils && rm -rf /var/cache/apk/*
COPY prebuildfs /
RUN /install-gosu.sh
COPY rootfs /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["gosu", "postgres", "postgres"]