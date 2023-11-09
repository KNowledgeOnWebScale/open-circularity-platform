#!/bin/bash
# Build static content for our viewer service in the clone of https://github.com/SolidLabResearch/generic-data-viewer-react-admin
# and harvest the result.
#
# Note: this script assumes:
#   - to run it the directory where it is located
#   - that the generic-data-viewer-react-admin project is cloned in its default directory (generic-data-viewer-react-admin),
#     located at the same directory level as our clone

set -euo pipefail

# absolute dirs; see assumptions above
GENERIC_ROOT_DIR=$(pwd)/../../../generic-data-viewer-react-admin
OUR_ROOT_DIR=$(pwd)/../..

cd ${GENERIC_ROOT_DIR}

echo Clearing build
rm -rf dist

echo Building
npm run build

echo Harvesting the result
rm -rf ${OUR_ROOT_DIR}/actors/viewer/html
cp -r dist ${OUR_ROOT_DIR}/actors/viewer/html

cd - >/dev/null
