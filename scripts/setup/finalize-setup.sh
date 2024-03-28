#!/bin/bash
#
# Assumptions:
#   - this script is run after yarn install and after sourcing one of the environment variable files
#   - this script is run from the repository root

set -euo pipefail

if [[ -z $OD_ENVVARS_FILE ]] ; then
  echo "⚠️ source one of the environment variable files and come back!"
  exit 2
fi
case "$OD_ENVVARS_FILE" in
  "envvars")
    ;;
  "envvars2")
    ;;
  "envvars3")
    ;;
  *)
    echo "⚠️ Unknown environment variables file $OD_ENVVARS_FILE"
    exit 2
    ;;
esac

echo "👉 Finalizing setup with environment variables file $OD_ENVVARS_FILE..."

echo "➡️ Getting rid of previous derived files..."
set +o pipefail # avoid exit in case of no previous derived files
git ls-files --others --ignored --exclude-standard | grep -v -e '^node_modules/' -e '^\.idea' -e '^rmlmapper.jar' | xargs -r -I % rm %
set -o pipefail

echo "➡️ Creating derived files from their templates..."
./scripts/templates/apply-templates.sh

echo "➡️ Downloading the RML Mapper JAR and creating the directory structure..."
yarn run setup

if [[ "$OD_ENVVARS_FILE" == "envvars" ]] ; then
  echo "➡️ Generating self-signed certificates..."
  cd ./scripts/cert && ./main.sh && cd ../../
fi

echo "➡️ Parsing YARRRML Mappings to RML and executing RML Mappings..."
yarn run dt:mapping:pipeline

echo "➡️ Building the webclient contents..."
yarn run comunica:queries:setup

echo "➡️ Building the data viewer contents..."
cd ./scripts/viewer && ./build-webclient-contents.sh && cd ../../

echo "👉 Setup finalized..."
