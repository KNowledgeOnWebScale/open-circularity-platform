#!/bin/bash
#
# Assumptions:
#   - this script is run from the repository root
#   - this script is located in reporoot/scripts/stuff-pods
#
# See also https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/docker-demo

set -euo pipefail

# absolute dir of script
MY_DIR=$(pwd)/scripts/stuff-pods

DOCKER_IMAGE_NAME=demo
DOCKER_IMAGE_NAME_COMPRESSED=demo.tar.gz
DOCKER_IMAGE_DOWNLOAD_LINK=https://cloud.ilabt.imec.be/index.php/s/8ZRmNkknQH7oEc5/download/${DOCKER_IMAGE_NAME_COMPRESSED}

# Transpose mapping file and data file(s) from backup to effective file for actor osocX
# Parameters
#   $1: actor number
function transpose_data {
  local i=$1
  echo " ⏭️ Making a mapping.yml file for osoc$i."
  sed "s|${OD_CSS5_BASE_URL}|${OD_CSS12_BASE_URL}|g ; s|info@texon.com|osoc$i@example.com|g ; s|texon123|osoc$i|g ; s|texon|osoc$i|g" data/mapping.yml.orig > data/mapping.yml
  echo " ⏭️ Hacking a acl_manuf1.csv file for osoc$i."
  sed "s|${OD_CSS5_BASE_URL}|${OD_CSS12_BASE_URL}|g ; s|texon|osoc$i|g" data/data/acl_manuf1.csv.orig > data/data/acl_manuf1.csv
}

echo "👉 Adding extra pod contents for osoc."
pushd ${MY_DIR} > /dev/null
echo $(pwd)

if [[ -e "${DOCKER_IMAGE_NAME_COMPRESSED}" ]] ; then
  echo "➡️ Reusing existing ${DOCKER_IMAGE_NAME_COMPRESSED}"
else
  echo "➡️ Downloading ${DOCKER_IMAGE_NAME_COMPRESSED}"
  wget ${DOCKER_IMAGE_DOWNLOAD_LINK}
fi

echo "➡️ Loading ${DOCKER_IMAGE_NAME} image into Docker"
gunzip -c ${DOCKER_IMAGE_NAME_COMPRESSED} | docker load

echo "➡️ Making a backup of the original data/mapping.yml and data/data/acl_manuf1.csv."
cp data/mapping.yml data/mapping.yml.orig
cp data/data/acl_manuf1.csv data/data/acl_manuf1.csv.orig
echo "➡️ Using the RML mapper in the Docker container to upload pod contents"
if [[ "$OD_ENVVARS_FILE" == "env-localhost" ]] ; then
  # the only way to reach pods at http://localhost from the a Docker container is to use the Docker host network...
  # ... which is not available from Docker for all platforms. Check availability here: https://docs.docker.com/network/network-tutorial-host/
  for i in {0..9} ; do
    transpose_data $i
    echo " ⏭️ Uploading to osoc$i"
    docker run --rm --net=host -v $(pwd)/data:/runtime/data ${DOCKER_IMAGE_NAME} -m mapping.yml
  done  
else
  for i in {0..9} ; do
    transpose_data $i
    echo " ⏭️ Uploading to osoc$i"
    docker run --rm            -v $(pwd)/data:/runtime/data ${DOCKER_IMAGE_NAME} -m mapping.yml
  done
fi
echo "➡️ Restoring the original data/mapping.yml and data/data/acl_manuf1.csv."
mv data/mapping.yml.orig data/mapping.yml
mv data/data/acl_manuf1.csv.orig data/data/acl_manuf1.csv

popd > /dev/null
echo "👉 Done."

