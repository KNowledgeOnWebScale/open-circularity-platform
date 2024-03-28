#!/bin/bash
#
# Assumptions:
#   - this script is run from the repository root
#   - this script is located in reporoot/scripts/stuff-pods

set -euo pipefail

# absolute dir of script
MY_DIR=$(pwd)/scripts/stuff-pods

HELPER_REPO=solid-target-helper-and-testpods
HELPER_CLONE=applied-in-architecture-solid-target-helper-and-testpods
HELPER_LOG_FILE=$MY_DIR/helper.log
HELPER_PID_FILE=$MY_DIR/helper.pid

pushd .. > /dev/null

echo Cloning, selecting tag, installing helper...
rm -rf ${HELPER_CLONE}
git clone https://gitlab.ilabt.imec.be/rml/util/${HELPER_REPO}.git -b v0.0.1 ${HELPER_CLONE}
cd ${HELPER_CLONE}
npm install

echo Finding a free port to run helper...
HELPER_PORT=3000
while (ss -nl | grep -sq ":$HELPER_PORT\s") ; do
    HELPER_PORT=$((HELPER_PORT+1))
done 

echo "Running helper on port $HELPER_PORT (see $HELPER_LOG_FILE for logs)."
nohup node index.js $HELPER_PORT > $HELPER_LOG_FILE 2>&1 &
PID=$!
echo "$PID" > $HELPER_PID_FILE
echo "Started helper with PID $PID"

popd > /dev/null
pushd $MY_DIR > /dev/null

echo "Updating remote resources (ignore the errors saying searchString \"null\" is not found...')"
java -jar rmlmapper.jar -shu http://localhost:$HELPER_PORT/ -m mapping_turtle-rml.ttl

echo Stopping helper with PID $PID
kill $PID || true
rm $HELPER_PID_FILE

popd > /dev/null
echo Done.
