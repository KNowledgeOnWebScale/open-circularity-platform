#!/bin/bash
#
# Assumptions:
#   - this script is run from the repository root
#   - this script is located in reporoot/scripts/stuff-pods
#   - the Solid servers in scope are up and running

set -euo pipefail

# absolute dir of script
MY_DIR=$(pwd)/scripts/stuff-pods

DOCKER_IMAGE_NAME=rmlio/solid-ocp-transformer:v0.2.1

echo "👉 Adding extra pod contents."
pushd ${MY_DIR} > /dev/null
echo $(pwd)

if [[ "$OD_ENVVARS_FILE" == "env-localhost" ]] ; then
  # the only way to reach pods at http://localhost from the a Docker container is to use the Docker host network...
  # ... which is not available from Docker for all platforms. Check availability here: https://docs.docker.com/network/network-tutorial-host/
  EXTRA_DOCKER_ARGS=--net=host
else
  EXTRA_DOCKER_ARGS=
fi

export DOCKER_IMAGE_NAME
export EXTRA_DOCKER_ARGS

# Below, stuff pods for one use case at time...

cd extended-textile
./stuff-pods.sh
cd ..

cd eval-2024-06-construction
./stuff-pods.sh
cd ..

cd eval-2024-06-electronics
./stuff-pods.sh
cd ..

cd eval-2024-06-textile
./stuff-pods.sh
cd ..

popd > /dev/null
echo "👉 Done."

