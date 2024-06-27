#!/bin/bash
# Execute this script to start the CSS's in this project (no Docker)
# Assumptions:
#   - this script is run from the repository root

set -euo pipefail

# Source the environment variables for localhost
source env-localhost

# this directory should be git-ignored
LOCAL_RUN_DIR=./local-run
rm -rf $LOCAL_RUN_DIR
mkdir -p $LOCAL_RUN_DIR

WAITING_COUNT=1

# Start one CSS in the background as a separate process
# Parameters
# - $1: the name of the CSS (e.g. css0)
function start_css {
    local CSSX="$1"

    local ROOT_DIR=$LOCAL_RUN_DIR/data/$CSSX
    rm -rf $ROOT_DIR
    mkdir -p $ROOT_DIR
    local CONFIG_DIR=$LOCAL_RUN_DIR/config/$CSSX
    rm -rf $CONFIG_DIR
    mkdir -p $CONFIG_DIR

    # Name of specific files
    local CONFIG_FILE=$CONFIG_DIR/$CSSX.json
    local LOG_FILE=$LOCAL_RUN_DIR/$CSSX.log
    local PID_FILE=$LOCAL_RUN_DIR/$CSSX.pid

    # Start CSSX with its specific configuration
    case "$CSSX" in
        "css0")
            local ACTOR=admin
            local PORT=$OD_CSS0_HOST_PORT
            ;;
        "css1")
            local ACTOR=lindner-group
            local PORT=$OD_CSS1_HOST_PORT
            ;;
        "css2")
            local ACTOR=building-owner
            local PORT=$OD_CSS2_HOST_PORT
            ;;
        "css3")
            local ACTOR=building-owner2
            local PORT=$OD_CSS3_HOST_PORT
            ;;
        "css4")
            local ACTOR=ragn-sells
            local PORT=$OD_CSS4_HOST_PORT
            ;;
        "css5")
            local ACTOR=texon
            local PORT=$OD_CSS5_HOST_PORT
            ;;
        "css6")
            local ACTOR=manufacturer
            local PORT=$OD_CSS6_HOST_PORT
            ;;
        "css7")
            local ACTOR=brand
            local PORT=$OD_CSS7_HOST_PORT
            ;;
        "css8")
            local ACTOR=recycler
            local PORT=$OD_CSS8_HOST_PORT
            ;;
        "css9")
            local ACTOR=retailer
            local PORT=$OD_CSS9_HOST_PORT
            ;;
        "css10")
            local ACTOR=sorter
            local PORT=$OD_CSS10_HOST_PORT
            ;;
        "css11")
            local ACTOR=any-evaluation-scenario-actor
            local PORT=$OD_CSS11_HOST_PORT
            ;;
        "css12")
            local ACTOR=any-osoc-actor
            local PORT=$OD_CSS12_HOST_PORT
            ;;
        *)
            echo "Unknown CSSX: $CSSX"
            exit 2
            ;;
    esac

    # Make a specific config file
    sed "s|/config/pod-template|./actors/$ACTOR/pod-template|g" ./common/css-01.json > $CONFIG_FILE
    # And... go as a background process
    nohup npx community-solid-server --port $PORT --config $CONFIG_FILE --seedConfig ./actors/$ACTOR/config/css-users.json --rootFilePath $ROOT_DIR > $LOG_FILE 2>&1 &
    # Remember the port and not the process id, because killing based on the process id does not work for node child processes
    echo "$PORT" > $PID_FILE
    echo "Started $CSSX on port $PORT."
}

# Check whether one CSS is listening
# Parameters
# - $1: the name of the file containing the port the CSS is listening to
function check_css {
    local PID_FILE="$1"
    local PORT=$(< $PID_FILE)
    if ! curl http://localhost:$PORT > /dev/null 2>&1 ; then
        echo "Waiting for $PORT to start listening..."
        WAITING_COUNT=$((WAITING_COUNT+1))
    fi
}

for css in css0 css1 css2 css3 css4 css5 css6 css7 css8 css9 css10 css11 css12; do
    start_css $css
done

while [[ $WAITING_COUNT > 0 ]] ; do
    WAITING_COUNT=0
    for f in ./local-run/*.pid ; do
        check_css $f
    done
    if [[ $WAITING_COUNT > 0 ]] ; then
        sleep 5
    fi
done
echo "All CSS's listening."
