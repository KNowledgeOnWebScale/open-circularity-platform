#!/bin/bash
#
# Note: this script assumes:
#   - to run it the directory where it is located
#   - our repo is cloned in a directory $OUR_CLONE

set -euo pipefail

OUR_CLONE=architecture
VIEWER_REPO=miravi-a-linked-data-viewer
VIEWER_CLONE=applied-in-architecture-miravi-a-linked-data-viewer

# absolute dir
OUR_ROOT_DIR=$(pwd)/../..

pushd ${OUR_ROOT_DIR}/.. > /dev/null

echo Cloning, selecting tag, installing...
rm -rf ${VIEWER_CLONE}
git clone https://github.com/SolidLabResearch/${VIEWER_REPO}.git -b v2.0.0 ${VIEWER_CLONE}
cd ${VIEWER_CLONE}/main
npm install

echo Selecting our configuration...
node scripts/select-config.cjs ../../../${OUR_CLONE}/actors/viewer/setup

echo Rebuilding static content...
rm -rf dist
npm run build

echo Harvesting the static content into our file structure...
rm -rf ${OUR_ROOT_DIR}/actors/viewer/html
cp -r dist ${OUR_ROOT_DIR}/actors/viewer/html

popd > /dev/null
