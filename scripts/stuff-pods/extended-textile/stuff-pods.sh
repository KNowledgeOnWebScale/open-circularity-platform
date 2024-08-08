#!/bin/bash
#
# Assumptions:
#   - this script is called from ../stuff-pods.sh

set -euo pipefail

echo "➡️ Using the RML mapper in the Docker container to upload pod contents for the extended textile use case."
docker run --rm $EXTRA_DOCKER_ARGS -v $(pwd):/runtime/data $DOCKER_IMAGE_NAME -m mapping.yml
