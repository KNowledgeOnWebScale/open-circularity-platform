#!/bin/bash
set -e
set -u

FPATH_PRIVATE_KEY=$1
FPATH_CSR=$2
FPATH_CERT=$3

echo " ✍️ Creating self-signed certificate."

openssl \
  x509 \
  -signkey $FPATH_PRIVATE_KEY \
  -in $FPATH_CSR \
  -req \
  -days 365 \
  -out $FPATH_CERT