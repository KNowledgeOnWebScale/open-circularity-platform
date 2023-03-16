#!/bin/bash
set -e
set -u

FPATH_PRIVATE_KEY=$1

echo " 🔑 Creating private key."

openssl \
  genrsa \
  -out $FPATH_PRIVATE_KEY \
  2048