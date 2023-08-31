#!/bin/bash
# Set permissions for the construction use case

# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -o pipefail: The return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status
set -euo pipefail

source .aliases
source .functions
source .actors

echo "$0 started."

################################################################################
# Lindner Group
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_LINDNER_GROUP)
authenticate $idp $EMAIL_LINDNER_GROUP $PASSWORD_LINDNER_GROUP $TOKEN_NAME_LINDNER_GROUP $WEBID_LINDNER_GROUP
# Public access to products
edit_permissions ${pod}data/dt/out/products.ttl p r
# Ragn-Sells can view BOMs and materials
edit_permissions ${pod}data/dt/out/boms.ttl      $WEBID_RAGN_SELLS r
edit_permissions ${pod}data/dt/out/materials.ttl $WEBID_RAGN_SELLS r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# Building Owner
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_BUILDING_OWNER)
authenticate $idp $EMAIL_BUILDING_OWNER $PASSWORD_BUILDING_OWNER $TOKEN_NAME_BUILDING_OWNER $WEBID_BUILDING_OWNER
# Lindner Group can view buildings data
edit_permissions ${pod}data/dt/out/buildings.ttl $WEBID_LINDNER_GROUP r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# Building Owner 2
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_BUILDING_OWNER2)
authenticate $idp $EMAIL_BUILDING_OWNER2 $PASSWORD_BUILDING_OWNER2 $TOKEN_NAME_BUILDING_OWNER2 $WEBID_BUILDING_OWNER2
# Lindner Group can view buildings data
edit_permissions ${pod}data/dt/out/buildings.ttl $WEBID_LINDNER_GROUP r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# Ragn-Sells
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_RAGN_SELLS)
authenticate $idp $EMAIL_RAGN_SELLS $PASSWORD_RAGN_SELLS $TOKEN_NAME_RAGN_SELLS $WEBID_RAGN_SELLS
# Public access to services
edit_permissions ${pod}data/dt/out/services.ttl p r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

echo "$0 done."
