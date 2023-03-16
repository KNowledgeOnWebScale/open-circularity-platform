#!/bin/bash
set -e
set -u

FPATH_CA_PRIVATE_KEY=$1
FPATH_CA_CERT=$2
FPATH_CA_PASSWORD=$3
SUBJ=$4
echo "🏢 Creating root CA."
openssl \
  req \
  -x509 \
  -sha256 \
  -days 1825 \
  -newkey rsa:2048 \
  -keyout $FPATH_CA_PRIVATE_KEY \
  -out $FPATH_CA_CERT \
  -passout file:$FPATH_CA_PASSWORD \
  -subj $SUBJ
  