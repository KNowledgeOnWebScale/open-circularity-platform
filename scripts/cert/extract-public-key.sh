#!/bin/bash
set -e
set -u
FPATH_PRIVATE_KEY=$1
FPATH_PUBLIC_KEY=$2

openssl \
  rsa \
  -in $FPATH_PRIVATE_KEY \
  -pubout \
  -out $FPATH_PUBLIC_KEY
