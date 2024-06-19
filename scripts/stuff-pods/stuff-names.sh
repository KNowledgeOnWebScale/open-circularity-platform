#!/bin/bash
# Execute this script to set foaf:names where needed
# Assumptions:
#   - an env-... file was sourced from the project root (we use ${OD_MIRRORED_ROOTS_PARENT_DIR})
#   - the CSSs are running and have their data directories mirrored to 

set -euo pipefail

# Construct a name from a card file's path
# Parameters
# - $1: the card filename with path
# Returns
# - a name, or nothing if not relevant
function construct_name {
    local FILENAME="$1"
    if [[ -n "$(echo $FILENAME | grep -Eo '/css11/')" ]] ; then
        # /css11/firstname_lastname<X>
        local PORTION=$(echo $FILENAME | grep -Eo '/css11/[a-z]+_[a-z]+[0-9]+')
        # firstname_lastname<X>
        PORTION=${PORTION#/css11/}
        # firstname_
        local FN=$(echo $PORTION | grep -Eo '[a-z]+_')
        # firstname
        FN=${FN%_}
        # Firstname
        FN=${FN^}
        # _lastname<X>
        local LN=$(echo $PORTION | grep -Eo '_[a-z]+[0-9]+')
        # lastname<X>
        LN=${LN#_}
        # Lastname<X>
        LN=${LN^}
        echo "$FN $LN"
    fi
}

# Change the foaf:name object to the desired value in the card file
# Parameters
# - $1: the card filename with path
function set_name {
    local FILENAME="$1"
    local NAME=$(construct_name $FILENAME)
    if [[ -n "$NAME" ]] ; then
        echo "Setting foaf:name \"$NAME\" in $FILENAME."
        sudo sed --in-place "s/foaf:name.*\".*\"/foaf:name \"$NAME\"/g" $FILENAME
    else
        echo "Skipping $FILENAME."
    fi
}

shopt -s nullglob
for d in ${OD_MIRRORED_ROOTS_PARENT_DIR}/*/*/profile/card\$.ttl ; do set_name $d ; done
