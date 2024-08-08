#!/bin/bash
#
# Assumptions:
#   - this script is called from ../stuff-pods.sh

set -euo pipefail

echo "➡️ Using the RML mapper in the Docker container to upload pod contents for the evaluation use case June 2024: construction."
for f in data/*.yml
do
  MAPPING=${f#data/}
  echo " ⏭️ Handling ${MAPPING}"
  docker run --rm $EXTRA_DOCKER_ARGS -v $(pwd)/data:/runtime/data $DOCKER_IMAGE_NAME -m ${MAPPING}
done
