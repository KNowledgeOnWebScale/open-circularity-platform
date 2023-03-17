#!/bin/bash
# (Re)load data owned by the Lindner Group
# Options:
#   -f: first time (includes creation + setting permissions on data container)

# Exit immediately if a command exits with a non-zero status.
set -e
# Fail when there are undefined variables
set -u
# Read all commons
source commons

# Enable bashlib aliases in this script
source bashlib-alias
shopt -s expand_aliases

# first time?
FIRST_TIME=false
while getopts ":f" o; do
    case "${o}" in
        f)
            FIRST_TIME=true
            ;;
        *)
            echo "Usage: $0 [-f]" 1>&2; exit 1
            ;;
    esac
done
shift $((OPTIND-1))

I=${INDEX_PER_CSS_LINDNER_GROUP}

# create authentication token (it will be identified by ${WEBID}) and activate it
WEBID=${PER_CSS_POD_OWNER_WEBID[$I]}
sld auth create-token -v -b ${PER_CSS_URL[$I]}/ -n "${PER_CSS_POD_OWNER_TOKEN_NAME[$I]}" -e ${PER_CSS_POD_OWNER_EMAIL[$I]} -p ${PER_CSS_POD_OWNER_PWD[$I]}
sld auth set "${WEBID}"

# load
CONTAINER="root:/data/"
CONTAINER_PROMPT="container ${CONTAINER} of ${WEBID} on ${PER_CSS_URL[$I]}"
if ${FIRST_TIME}; then
  echo "Creating ${CONTAINER_PROMPT}"
  sld mkdir ${CONTAINER}
  echo "Setting permissions on ${CONTAINER_PROMPT}"
  sld perms edit ${CONTAINER} p=rd
  echo "Adding contents in ${CONTAINER_PROMPT}"
else
  echo "Updating contents in ${CONTAINER_PROMPT}"
fi
echo "- products.ttl"
sld cp /data/products.ttl root:/data/
echo "- boms.ttl"
sld cp /data/boms.ttl root:/data/
echo "- materials.ttl"
sld cp /data/materials.ttl root:/data/

# stop using authentication token and delete it
sld auth clear
sld auth remove "${WEBID}"
