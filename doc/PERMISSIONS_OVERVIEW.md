# Overview of permissions

Next overview can be created semi-automatically.

1. After successful Docker infrastructure startup, execute `docker logs architecture-bashlib-1 | dos2unix | sort | grep -Eo 'https:\/\/.*\.ttl => .*' | awk '{print "| " $1 " | " $4 " | " $7 " |"}'`
2. Copy the output below the table header.

## Note on baseURLs

In the table below, baseURLs are of the form `https://css*.onto-deside.ilabt.imec.be/`.
These are valid for the selected setups *Development and stand-alone demo* and *Public deployment*.
For other selected setups, replace the baseURLs with the values from the corresponding [environment variables file](../README.md#environment-variables).


| Resource                                                                                          | WebID granted the permission (p = public)                            | permission |
|---------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|------------|
| https://css1.onto-deside.ilabt.imec.be/lindner-group/data/dt/out/boms.ttl                         | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css1.onto-deside.ilabt.imec.be/lindner-group/data/dt/out/boms.ttl                         | https://css4.onto-deside.ilabt.imec.be/ragn-sells/profile/card#me    | r          |
| https://css1.onto-deside.ilabt.imec.be/lindner-group/data/dt/out/materials.ttl                    | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css1.onto-deside.ilabt.imec.be/lindner-group/data/dt/out/materials.ttl                    | https://css4.onto-deside.ilabt.imec.be/ragn-sells/profile/card#me    | r          |
| https://css1.onto-deside.ilabt.imec.be/lindner-group/data/dt/out/products.ttl                     | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css1.onto-deside.ilabt.imec.be/lindner-group/data/dt/out/products.ttl                     | p                                                                    | r          |
| https://css2.onto-deside.ilabt.imec.be/building-owner/data/dt/out/buildings.ttl                   | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css2.onto-deside.ilabt.imec.be/building-owner/data/dt/out/buildings.ttl                   | https://css1.onto-deside.ilabt.imec.be/lindner-group/profile/card#me | r          |
| https://css3.onto-deside.ilabt.imec.be/building-owner2/data/dt/out/building-owner-2-buildings.ttl | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css3.onto-deside.ilabt.imec.be/building-owner2/data/dt/out/buildings.ttl                  | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css3.onto-deside.ilabt.imec.be/building-owner2/data/dt/out/buildings.ttl                  | https://css1.onto-deside.ilabt.imec.be/lindner-group/profile/card#me | r          |
| https://css4.onto-deside.ilabt.imec.be/ragn-sells/data/dt/out/services.ttl                        | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css4.onto-deside.ilabt.imec.be/ragn-sells/data/dt/out/services.ttl                        | p                                                                    | r          |
| https://css5.onto-deside.ilabt.imec.be/texon/data/dt/out/boms.ttl                                 | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css5.onto-deside.ilabt.imec.be/texon/data/dt/out/components.ttl                           | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css5.onto-deside.ilabt.imec.be/texon/data/dt/out/components.ttl                           | https://css6.onto-deside.ilabt.imec.be/manufacturer/profile/card#me  | r          |
| https://css5.onto-deside.ilabt.imec.be/texon/data/dt/out/components.ttl                           | https://css7.onto-deside.ilabt.imec.be/brand/profile/card#me         | r          |
| https://css5.onto-deside.ilabt.imec.be/texon/data/dt/out/materials.ttl                            | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css6.onto-deside.ilabt.imec.be/manufacturer/data/dt/out/boms.ttl                          | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css6.onto-deside.ilabt.imec.be/manufacturer/data/dt/out/boms.ttl                          | https://css7.onto-deside.ilabt.imec.be/brand/profile/card#me         | r          |
| https://css6.onto-deside.ilabt.imec.be/manufacturer/data/dt/out/products.ttl                      | https://css0.onto-deside.ilabt.imec.be/admin/profile/card#me         | r          |
| https://css6.onto-deside.ilabt.imec.be/manufacturer/data/dt/out/products.ttl                      | https://css7.onto-deside.ilabt.imec.be/brand/profile/card#me         | r          |

