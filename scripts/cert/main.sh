#!/bin/bash
# ref: https://www.baeldung.com/openssl-self-signed-cert
set -e
set -u
shopt -s nullglob
DIR_OUTPUT=$(pwd)/outputs

# Reset output dir
if [ -d $DIR_OUTPUT ];
then
  rm -rf $DIR_OUTPUT
fi;
mkdir -p $DIR_OUTPUT

# 0. CREATE ROOT CA
FPATH_CA_PRIVATE_KEY=$DIR_OUTPUT/"ca-private.key"
FPATH_CA_CERT=$DIR_OUTPUT/"ca.crt" # X.509 certificate that's ASCII PEM-encoded
FPATH_CA_PASSWORD=$DIR_OUTPUT/"ca.pass"
CA_PASSWORD="Azerty123"
echo $CA_PASSWORD > $FPATH_CA_PASSWORD
CA_SUBJ="/C=BE/ST=Oost-Vlaanderen/L=Gent/O=imec/OU=KNoWS/CN=ca"
./create-root-CA.sh \
  $FPATH_CA_PRIVATE_KEY \
  $FPATH_CA_CERT \
  $FPATH_CA_PASSWORD \
  $CA_SUBJ

DOMAINS=(
  css0
  css1
  webclient
)

for DOMAIN in ${DOMAINS[@]}; do

  # 1. CREATE PRIVATE KEY
  FPATH_PRIVATE_KEY=$DIR_OUTPUT/"$DOMAIN-private.key"
  FPATH_EXT=$DIR_OUTPUT/"$DOMAIN.ext"
  ./create-private-key.sh $FPATH_PRIVATE_KEY
  # 1b. CREATE CERTIFICATE EXTENSION FILE FOR DOMAIN
  ./create-certificate-extensions-file.sh $DOMAIN $FPATH_EXT
  # 1c. EXTRACT PUBLIC KEY
  FPATH_PUBLIC_KEY=${FPATH_PRIVATE_KEY/private/public}
  ./extract-public-key.sh $FPATH_PRIVATE_KEY $FPATH_PUBLIC_KEY

  # 2. CREATE CSR
  FPATH_CSR=$DIR_OUTPUT/"$DOMAIN.csr"
  SUBJ="/C=BE/ST=Oost-Vlaanderen/L=Gent/O=imec/OU=KNoWS/CN=$DOMAIN"
  ./create-certificate-signing-request.sh \
    $FPATH_PRIVATE_KEY \
    $FPATH_CSR \
    $SUBJ

  # 3. CREATE SELF-SIGNED CERTIFICATE
  FPATH_CERT=$DIR_OUTPUT/"$DOMAIN.crt"
  ./create-self-signed-certificate.sh \
    $FPATH_PRIVATE_KEY \
    $FPATH_CSR \
    $FPATH_CERT

  # 4. CREATE CA-SIGNED CERTIFICATE
  ./create-CA-signed-certificate.sh \
    $FPATH_CA_CERT \
    $FPATH_CA_PRIVATE_KEY \
    $FPATH_CSR \
    $FPATH_CERT \
    $FPATH_EXT \
    $FPATH_CA_PASSWORD


  # 5. RESTRUCTURE INTO ACTOR SUBFOLDERS
  ## 5.a Move domain files to separate directory
  mkdir -p $DIR_OUTPUT/$DOMAIN
  mv $DIR_OUTPUT/$DOMAIN*.* $DIR_OUTPUT/$DOMAIN
  ## 5.b Rename to general "actor*" files
  for x in $(ls $DIR_OUTPUT/$DOMAIN/);
  do
    src=$DIR_OUTPUT/$DOMAIN/$x
    dest=$DIR_OUTPUT/$DOMAIN/${x/$DOMAIN/actor}
    mv $src $dest
  done;
done;

# 6. RESTRUCTURE CERTIFICATE AUTHORITY FILES
mkdir -p $DIR_OUTPUT/certificate-authority
mv $DIR_OUTPUT/ca* $DIR_OUTPUT/certificate-authority


