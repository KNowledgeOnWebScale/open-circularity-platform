#!/bin/bash
set -e
set -u

FPATH_PRIVATE_KEY=$1
FPATH_CSR=$2
SUBJ=$3

echo "🔖 Creating CSR."

openssl \
  req \
  -key $FPATH_PRIVATE_KEY \
  -new \
  -subj $SUBJ \
  -out $FPATH_CSR
  
