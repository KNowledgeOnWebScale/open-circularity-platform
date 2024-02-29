#!/bin/bash
# Execute this script to start LOCALLY the CSS's in this project (no Docker!)
# Assumptions:
#   - this script is run from the repository root

set -euo pipefail

# Source the environment variables for local development
source envvars3

# this directory should be git-ignored
LOCAL_RUN_DIR=./local-run
rm -rf $LOCAL_RUN_DIR
mkdir -p $LOCAL_RUN_DIR

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
            actor=admin
            port=$OD_CSS0_HOST_PORT
            ;;
        "css1")
            actor=lindner-group
            port=$OD_CSS1_HOST_PORT
            ;;
        "css2")
            actor=building-owner
            port=$OD_CSS2_HOST_PORT
            ;;
        "css3")
            actor=building-owner2
            port=$OD_CSS3_HOST_PORT
            ;;
        "css4")
            actor=ragn-sells
            port=$OD_CSS4_HOST_PORT
            ;;
        "css5")
            actor=texon
            port=$OD_CSS5_HOST_PORT
            ;;
        "css6")
            actor=manufacturer
            port=$OD_CSS6_HOST_PORT
            ;;
        "css7")
            actor=brand
            port=$OD_CSS7_HOST_PORT
            ;;
        "css8")
            actor=recycler
            port=$OD_CSS8_HOST_PORT
            ;;
        "css9")
            actor=retailer
            port=$OD_CSS9_HOST_PORT
            ;;
        "css10")
            actor=sorter
            port=$OD_CSS10_HOST_PORT
            ;;
        *)
            echo "Unknown CSSX: $CSSX"
            exit 2
            ;;
    esac

    # Make a specific config file
    sed "s|/config/pod-template|./actors/$actor/pod-template|g" ./common/css-01.json > $CONFIG_FILE
    # And... go as a background process
    nohup npx community-solid-server --port $port --config $CONFIG_FILE --seedConfig ./actors/$actor/config/css-users.json --rootFilePath $ROOT_DIR > $LOG_FILE 2>&1 &
    PID=$!
    echo "$PID" > $PID_FILE
    echo "Started $CSSX with PID $PID"
}

start_css css0
start_css css1
start_css css2
start_css css3
start_css css4
start_css css5
start_css css6
start_css css7
start_css css8
start_css css9
start_css css10
