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

echo "👉 Adding extra pod contents."
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

echo "➡️ Using the RML mapper in the Docker container to upload pod contents"
if [[ "$OD_ENVVARS_FILE" == "env-localhost" ]] ; then
  # the only way to reach pods at http://localhost from the a Docker container is to use the Docker host network...
  # ... which is not available from Docker for all platforms. Check availability here: https://docs.docker.com/network/network-tutorial-host/
  docker run --rm --net=host -v $(pwd)/data:/runtime/data ${DOCKER_IMAGE_NAME} -m mapping.yml
else
  docker run --rm            -v $(pwd)/data:/runtime/data ${DOCKER_IMAGE_NAME} -m mapping.yml
fi

popd > /dev/null
echo "👉 Done."

