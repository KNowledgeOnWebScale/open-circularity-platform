#!/bin/bash
# Set permissions on all demo contents

# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -o pipefail: The return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status
set -euo pipefail

source .aliases

# Define all involved WebIDs here upfront for easy referencing.
WEBID_ADMIN=https://css0/admin/profile/card#me
WEBID_LINDNER_GROUP=https://css1/lindner-group/profile/card#me
WEBID_BUILDING_OWNER=https://css2/building-owner/profile/card#me
WEBID_BUILDING_OWNER2=https://css3/building-owner2/profile/card#me
WEBID_RAGN_SELLS=https://css4/ragn-sells/profile/card#me

# For a given WebID, get the idp and the pod
# Parameters:
#   $1: webid
# Returns
#   idp pod (both with trailing /; "unknown" if not found)
function get_idp_pod_from_webid() {
  local webid=$1
  sld query $webid 'SELECT ?idp ?pod WHERE {
    ?s	<http://www.w3.org/ns/solid/terms#oidcIssuer> ?idp ;
        <http://www.w3.org/ns/pim/space#storage> ?pod .
  }' | awk 'BEGIN { idp = "unknown"; pod = "unknown" } $1 == "idp:" { idp = $2 } $1 == "pod:" { pod = $2 } END { print idp, pod }'
}

# Create an authentication token for a WebID and use it to authenticate
# Parameters:
#   $1: identity provider
#   $2: email address
#   $3: password
#   $4: token name
#   $5: webid
function authenticate() {
  local idp=$1
  local email=$2
  local pw=$3
  local token_name=$4
  local webid=$5
  echo "🧹 Clearing currently authenticated WebID if any"
  sld auth clear
  echo "🔑 Creating token $token_name"
  sld auth create-token -v -b $idp -e $email -p $pw -n $token_name
  echo "🔐 Authenticating as $webid"
  sld auth set $webid
}

# Edit the permissions of a resource for a WebID
# Parameters:
#   $1: resource (url)
#   $2: webid (or p for public, u for currently authenticated user)
#   $3: permissions ([d][g][a][c][r][w], see bashlib's perms edit command)
function edit_permissions() {
  local resource=$1
  local webid=$2
  local perms=$3
  echo "Editing permissions of 💾 $resource => 👨‍💻 $webid has permission(s): $perms"
  sld perms edit $resource $webid=$perms
}

echo "$0 started."

################################################################################
# Lindner Group
################################################################################
email=info@lindner-group.com
pw=lindner123
token_name=lg-token
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_LINDNER_GROUP)
authenticate $idp $email $pw $token_name $WEBID_LINDNER_GROUP
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
email=info@building-owner.com
pw=building123
token_name=bo-token
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_BUILDING_OWNER)
authenticate $idp $email $pw $token_name $WEBID_BUILDING_OWNER
# Lindner Group can view buildings data
edit_permissions ${pod}data/dt/out/buildings.ttl $WEBID_LINDNER_GROUP r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# Building Owner 2
################################################################################
email=bob@realestate.com
pw=bob123
token_name=bo2-token
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_BUILDING_OWNER2)
authenticate $idp $email $pw $token_name $WEBID_BUILDING_OWNER2
# Lindner Group can view buildings data
edit_permissions ${pod}data/dt/out/buildings.ttl $WEBID_LINDNER_GROUP r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# Ragn-Sells
################################################################################
email=mikael@ragn-sells.se
pw=mikael123
token_name=rs-token
################################################################################
read -r idp pod <<< $(get_idp_pod_from_webid $WEBID_RAGN_SELLS)
authenticate $idp $email $pw $token_name $WEBID_RAGN_SELLS
# Public access to services
edit_permissions ${pod}data/dt/out/services.ttl p r
# Admin: read access to all files in dt/out directory
for resource in $(sld ls ${pod}data/dt/out/ --full); do
  edit_permissions $resource $WEBID_ADMIN r
done

################################################################################
# satisfy the health check and stay alive
################################################################################
echo "$0 done."
touch /healthy.flag
sleep infinity
