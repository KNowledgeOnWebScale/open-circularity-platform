#!/bin/bash
# (1) Clone and select the appropriate tag of https://github.com/SolidLabResearch/generic-data-viewer-react-admin
#     in subdirectory generic-data-viewer-react-admin of the parent directory of this clone.
#
# Note: this script assumes:
#   - to run it the directory where it is located

set -euo pipefail

# absolute dirs
OUR_ROOT_DIR=$(pwd)/../..
PARENT_DIR=${OUR_ROOT_DIR}/..
GENERIC_ROOT_DIR=${PARENT_DIR}/generic-data-viewer-react-admin

pushd ${PARENT_DIR}

echo Cloning, selecting tag, installing...
rm -rf generic-data-viewer-react-admin
git clone git@github.com:SolidLabResearch/generic-data-viewer-react-admin.git
cd ${GENERIC_ROOT_DIR}
git checkout v1.1.1
npm install

echo Preparing input...
rm -f ./src/config.json
cp ${OUR_ROOT_DIR}/actors/viewer/setup/src/config.json ./src/
rm -f ./public/images/*
cp ${OUR_ROOT_DIR}/actors/viewer/setup/public/images/* ./public/images/
rm -f ./public/queries/*
cp ${OUR_ROOT_DIR}/scripts/comunica/outputs/queries/* ./public/queries/

echo Rebuilding static content...
rm -rf dist
npm run build

echo Harvesting the static content into our file structure...
rm -rf ${OUR_ROOT_DIR}/actors/viewer/html
cp -r dist ${OUR_ROOT_DIR}/actors/viewer/html

popd
