#!/bin/bash
#
# This is a special purpose script made for Open Summer Of Code 2024.
# It transforms the data of the extended textile use case meant actor texon in css5 to 9 dedicated actors in css12.
#
# Assumptions:
#   - this script is called from ../stuff-pods.sh

set -euo pipefail

function backup {
  echo "➡️ Making a backup of the original mapping.yml and data/acl_manuf1.csv."
  cp mapping.yml mapping.yml.orig
  cp data/acl_manuf1.csv data/acl_manuf1.csv.orig
}

# Transpose mapping file and data file(s) from backup to effective file for actor osocX
# Parameters
#   $1: actor number
function transpose_data {
  local i=$1
  echo " ⏭️ Making a mapping.yml file for osoc$i."
  sed "s|${OD_CSS5_BASE_URL}|${OD_CSS12_BASE_URL}|g ; s|info@texon.com|osoc$i@example.com|g ; s|texon123|osoc$i|g ; s|texon|osoc$i|g" mapping.yml.orig > mapping.yml
  echo " ⏭️ Hacking a acl_manuf1.csv file for osoc$i."
  sed "s|${OD_CSS5_BASE_URL}|${OD_CSS12_BASE_URL}|g ; s|texon|osoc$i|g" data/acl_manuf1.csv.orig > data/acl_manuf1.csv
}

function restore {
  echo "➡️ Restoring the original mapping.yml and data/acl_manuf1.csv."
  mv mapping.yml.orig mapping.yml
  mv data/acl_manuf1.csv.orig data/acl_manuf1.csv
}

backup

echo "➡️ Using the RML mapper in the Docker container to upload pod contents for the extended textile use case (OSOC duplicates)."
for i in {0..9} ; do
  transpose_data $i
  echo " ⏭️ Uploading to osoc$i"
  docker run --rm $EXTRA_DOCKER_ARGS -v $(pwd):/runtime/data $DOCKER_IMAGE_NAME -m mapping.yml
done

restore