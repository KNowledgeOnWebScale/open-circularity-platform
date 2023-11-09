#!/bin/bash
# Set permissions for the textile use case

# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -o pipefail: The return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status
set -euo pipefail

source .aliases
source .functions
source .actors

echo "$0 started."

################################################################################
# Texon
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_TEXON)
authenticate $idp $EMAIL_TEXON $PASSWORD_TEXON $TOKEN_NAME_TEXON $WEBID_TEXON
# Manufacturer and Brand can view components
edit_permissions ${pod}data/dt/out/components.ttl $WEBID_MANUFACTURER r
edit_permissions ${pod}data/dt/out/components.ttl $WEBID_BRAND r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# Manufacturer
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_MANUFACTURER)
authenticate $idp $EMAIL_MANUFACTURER $PASSWORD_MANUFACTURER $TOKEN_NAME_MANUFACTURER $WEBID_MANUFACTURER
# Brand can view products and BOMs
edit_permissions ${pod}data/dt/out/products.ttl $WEBID_BRAND r
edit_permissions ${pod}data/dt/out/boms.ttl $WEBID_BRAND r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

echo "$0 done."

