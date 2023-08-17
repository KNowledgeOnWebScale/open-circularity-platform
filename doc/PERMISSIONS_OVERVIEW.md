# Overview of permissions in the demo

Next overview can be created semi-automatically.

1. After successful Docker infrastructure startup, execute `docker logs architecture-bashlib-1 | dos2unix | sort | grep -Eo 'https:\/\/.*\.ttl => .*' | awk '{print "| " $1 " | " $4 " | " $7 " |"}'`
2. Copy the output below the table header.

| Resource                                                                | WebID granted the permission (p = public)  | permission |
|-------------------------------------------------------------------------|--------------------------------------------|------------|
| https://css1/lindner-group/data/dt/out/boms.ttl | https://css0/admin/profile/card#me | r |
| https://css1/lindner-group/data/dt/out/boms.ttl | https://css4/ragn-sells/profile/card#me | r |
| https://css1/lindner-group/data/dt/out/materials.ttl | https://css0/admin/profile/card#me | r |
| https://css1/lindner-group/data/dt/out/materials.ttl | https://css4/ragn-sells/profile/card#me | r |
| https://css1/lindner-group/data/dt/out/products.ttl | https://css0/admin/profile/card#me | r |
| https://css1/lindner-group/data/dt/out/products.ttl | p | r |
| https://css2/building-owner/data/dt/out/buildings.ttl | https://css0/admin/profile/card#me | r |
| https://css2/building-owner/data/dt/out/buildings.ttl | https://css1/lindner-group/profile/card#me | r |
| https://css3/building-owner2/data/dt/out/building-owner-2-buildings.ttl | https://css0/admin/profile/card#me | r |
| https://css3/building-owner2/data/dt/out/buildings.ttl | https://css0/admin/profile/card#me | r |
| https://css3/building-owner2/data/dt/out/buildings.ttl | https://css1/lindner-group/profile/card#me | r |
| https://css4/ragn-sells/data/dt/out/services.ttl | https://css0/admin/profile/card#me | r |
| https://css4/ragn-sells/data/dt/out/services.ttl | p | r |
