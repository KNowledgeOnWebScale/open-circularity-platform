#!/bin/bash
set -e
set -u

FPATH_CA_CERT=$1
FPATH_CA_PRIVATE_KEY=$2
FPATH_CSR=$3
FPATH_CERT=$4
FPATH_EXT=$5
FPATH_CA_PASSWORD=$6

echo "🏢🖌️ Creating CA-signed certificate."

openssl \
  x509 \
  -req \
  -CA $FPATH_CA_CERT \
  -CAkey $FPATH_CA_PRIVATE_KEY \
  -in $FPATH_CSR \
  -out $FPATH_CERT \
  -days 365 \
  -CAcreateserial \
  -extfile $FPATH_EXT \
  -passin file:$FPATH_CA_PASSWORD