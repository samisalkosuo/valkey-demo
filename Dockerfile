FROM docker.io/valkey/valkey:latest

#environment variables
ENV VALKEY_MAXMEMORY=64mb

#add certificates
RUN mkdir -p /certs
COPY certs/ /certs/

COPY start-valkey.sh /

EXPOSE 6379

CMD [ "bash","/start-valkey.sh" ]
