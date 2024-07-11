#!/bin/bash
#
# Note: this script assumes:
#   - to run it the directory where it is located

set -euo pipefail

VIEWER_REPO=generic-data-viewer-react-admin
VIEWER_CLONE=applied-in-architecture-generic-data-viewer-react-admin

# absolute dir
OUR_ROOT_DIR=$(pwd)/../..

pushd ${OUR_ROOT_DIR}/.. > /dev/null

echo Cloning, selecting tag, installing...
rm -rf ${VIEWER_CLONE}
git clone https://github.com/SolidLabResearch/${VIEWER_REPO}.git -b v1.2.3 ${VIEWER_CLONE}
cd ${VIEWER_CLONE}
npm install

echo Preparing input...
rm -f ./src/config.json
cp ${OUR_ROOT_DIR}/actors/viewer/setup/src/config.json ./src/
rm -rf ./public
cp -r ${OUR_ROOT_DIR}/actors/viewer/setup/public .

echo Rebuilding static content...
rm -rf dist
npm run build

echo Harvesting the static content into our file structure...
rm -rf ${OUR_ROOT_DIR}/actors/viewer/html
cp -r dist ${OUR_ROOT_DIR}/actors/viewer/html

popd > /dev/null
