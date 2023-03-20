#!/bin/bash
source .aliases
################################################################################
# Lindner Group
################################################################################
idp=https://css1
pod=$idp/lindner-group
webid=$pod/profile/card#me
email=info@lindner-group.com
pw=lindner123
token_name=lg-token
################################################################################
echo "🧹 Clear currently authenticated WebID"
sld auth clear

echo "🔑 Creating token"
sld auth create-token\
  -v \
  -b $idp \
  -e $email \
  -p $pw \
  -n $token_name

echo "🔐 Authenticating as $webid"
sld auth set $webid

# Public access to products
obj=data/dt/out/products.ttl
echo "Enable public read access for $obj"
sld perms edit root:$obj p=r

# Ragn-Sells can view BOMs and materials
obj=data/dt/out/boms.ttl
agent=https://css4/ragn-sells/profile/card#me
perms=r
echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
sld perms edit root:$obj $agent=r

# Admin: read access to all files in dt/out directory
agent=https://css0/admin/profile/card#me
perms=r
for uri in $(sld ls root:data/dt/out/ --full);
do
  echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
  sld perms edit $uri $agent=r
done;
 
################################################################################
# Building Owner
################################################################################
idp=https://css2
pod=$idp/building-owner
webid=$pod/profile/card#me
email=info@building-owner.com
pw=building123
token_name=bo-token
################################################################################
echo "🧹 Clear currently authenticated WebID"
sld auth clear

echo "🔑 Creating token"
sld auth create-token\
  -v \
  -b $idp \
  -e $email \
  -p $pw \
  -n $token_name

echo "🔐 Authenticating as $webid"
sld auth set $webid

# Lindner Group can view buildings data
obj=data/dt/out/buildings.ttl
agent=https://css1/lindner-group/profile/card#me
perms=r
echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
sld perms edit root:$obj $agent=r

# Admin: read access to all files in dt/out directory
agent=https://css0/admin/profile/card#me
perms=r
for uri in $(sld ls root:data/dt/out/ --full);
do
  echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
  sld perms edit $uri $agent=r
done;

################################################################################
# Building Owner 2
################################################################################
idp=https://css3
pod=$idp/building-owner2
webid=$pod/profile/card#me
email=bob@realestate.com
pw=bob123
token_name=bo2-token
################################################################################
echo "🧹 Clear currently authenticated WebID"
sld auth clear

echo "🔑 Creating token"
sld auth create-token\
  -v \
  -b $idp \
  -e $email \
  -p $pw \
  -n $token_name

echo "🔐 Authenticating as $webid"
sld auth set $webid

# Lindner Group can view buildings data
obj=data/dt/out/buildings.ttl
agent=https://css1/lindner-group/profile/card#me
perms=r
echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
sld perms edit root:$obj $agent=r

# Admin: read access to all files in dt/out directory
agent=https://css0/admin/profile/card#me
perms=r
for uri in $(sld ls root:data/dt/out/ --full);
do
  echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
  sld perms edit $uri $agent=r
done;

################################################################################
# Ragn-Sells
################################################################################
idp=https://css4
pod=$idp/ragn-sells
webid=$pod/profile/card#me
email=mikael@ragn-sells.se
pw=mikael123
token_name=rs-token
################################################################################
echo "🧹 Clear currently authenticated WebID"
sld auth clear

echo "🔑 Creating token"
sld auth create-token\
  -v \
  -b $idp \
  -e $email \
  -p $pw \
  -n $token_name

echo "🔐 Authenticating as $webid"
sld auth set $webid

# Public access to services
obj=data/dt/out/ragn-sells-services.ttl
echo "Enable public read access for $obj"
sld perms edit root:$obj p=r

# Admin: read access to all files in dt/out directory
agent=https://css0/admin/profile/card#me
perms=r
for uri in $(sld ls root:data/dt/out/ --full);
do
  echo "Edit permissions of 💾 $uri => 👨‍💻 $agent has permission(s): $perms"
  sld perms edit $uri $agent=r
done;