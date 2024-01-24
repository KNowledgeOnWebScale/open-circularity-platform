#!/bin/bash
# Prepare the clone of https://github.com/SolidLabResearch/generic-data-viewer-react-admin to build the static content for our viewer service.
#
# Note: this script assumes:
#   - to run it the directory where it is located
#   - that the generic-data-viewer-react-admin project is cloned in its default directory (generic-data-viewer-react-admin),
#     located at the same directory level as our clone

set -euo pipefail

# absolute dirs; see assumptions above
GENERIC_ROOT_DIR=$(pwd)/../../../generic-data-viewer-react-admin
OUR_ROOT_DIR=$(pwd)/../..

echo Preparing src/config.json
rm -f ${GENERIC_ROOT_DIR}/src/config.json
cp ${OUR_ROOT_DIR}/actors/viewer/setup/src/config.json ${GENERIC_ROOT_DIR}/src/

echo Preparing public/images
rm -f ${GENERIC_ROOT_DIR}/public/images/*
cp ${OUR_ROOT_DIR}/actors/viewer/setup/public/images/* ${GENERIC_ROOT_DIR}/public/images/

echo Preparing public/queries
rm -f ${GENERIC_ROOT_DIR}/public/queries/*
cp ${OUR_ROOT_DIR}/scripts/comunica/outputs/queries/* ${GENERIC_ROOT_DIR}/public/queries/
