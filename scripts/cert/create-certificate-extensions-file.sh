#!/bin/bash
set -e
set -u

DOMAIN=$1
FPATH_EXT=$2

echo " 📃 Creating certificate extension file."

echo "
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $DOMAIN
" > $FPATH_EXT