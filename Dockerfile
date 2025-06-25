FROM valkey/valkey:latest

#environment variables
ENV VALKEY_MAXMEMORY=64mb

#add certificates
RUN mkdir -p /certs
COPY certs/ /certs/

COPY start-valkey.sh /

CMD [ "bash","/start-valkey.sh" ]
