#!/bin/bash

if [[ "${VALKEY_PASSWORD}" == "" ]]; then
  echo "VALKEY_PASSWORD environment variable not set."
  exit 1 
fi

function checkFile
{
    local file=$1
    if ! [ -f ${file} ]; then
        echo "${file} does not exist."
        exit 1
    fi
}

checkFile /certs/cert.crt
checkFile /certs/cert.key
checkFile /certs/ca.crt


VALKEY_CONF_FILE=/tmp/valkey.conf
cat << EOF > ${VALKEY_CONF_FILE}
#disable non-tls port
port 0
tls-port 6379

loglevel warning

maxmemory ${VALKEY_MAXMEMORY}

requirepass "${VALKEY_PASSWORD}"

#TLS
tls-auth-clients no 
tls-cert-file /certs/cert.crt
tls-key-file /certs/cert.key
tls-ca-cert-file /certs/ca.crt
EOF

exec valkey-server ${VALKEY_CONF_FILE}
