#!/bin/bash
#
# Assumptions:
#   - this script is called from ../stuff-pods.sh

set -euo pipefail

echo "➡️ Using the RML mapper in the Docker container to upload pod contents for the cross-domain use cases."
for d in buildingowner123 ceonadmin circularise concular constructioncompany123 dismantler123 lacesmanufacturer123 lindner outsolemanufacturer123 ragnsells recycler123 shoebrand123 soundsystemmanufacturer supplier123 texon user1 ; do
  cd $d
  echo " ⏭️ Working in $d"
  docker run --rm $EXTRA_DOCKER_ARGS -v $(pwd):/runtime/data $DOCKER_IMAGE_NAME -m mapping.yml
  cd ..
done
