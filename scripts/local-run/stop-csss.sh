#!/bin/bash
# Execute this script to stop any running CSS's in this project (no Docker)
# Assumptions:
#   - this script is run from the repository root

set -euo pipefail

LOCAL_RUN_DIR=./local-run

# Stop one CSS
# Parameters
# - $1: the name of the file containing the port the CSS is listening to
function stop_css {
    local PID_FILE="$1"
    local PORT=$(< $PID_FILE)
    echo "Stopping the CSS listening on port $PORT."
    kill $(lsof -t -i:$PORT) || true
    rm $PID_FILE
}

shopt -s nullglob
for f in ./local-run/*.pid ; do stop_css $f ; done
