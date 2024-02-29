#!/bin/bash
# Execute this script to stop any LOCALLY running CSS's in this project (no Docker!)
# Assumptions:
#   - this script is run from the repository root

set -euo pipefail

LOCAL_RUN_DIR=./local-run

# Stop one CSS
# Parameters
# - $1: the name of the file containing the process ID of the CSS
function stop_css {
    local PID_FILE="$1"
    local PID=$(< $PID_FILE)
    echo "Slowly killing PID $PID found in $PID_FILE"
    kill $PID || true
    rm $PID_FILE
}

for f in ./local-run/*.pid ; do stop_css $f ; done
