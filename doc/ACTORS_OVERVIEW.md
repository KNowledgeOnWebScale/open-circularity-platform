# Overview of actors

## Note on webIds

In the tables below, webId alternatives are given for all possible setups provided in the supported setup cases.

## Construction use case

| **actor**       | **webId**                                                                                                                           | **email**               | **password** |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------|-------------------------|--------------|
| admin           | https://onto-deside.ilabt.imec.be/css0/admin/profile/card#me <br/> http://localhost:3000/admin/profile/card#me                      | admin@ocp.com           | admin123     |
| lindner-group   | https://onto-deside.ilabt.imec.be/css1/lindner-group/profile/card#me <br/> http://localhost:3001/lindner-group/profile/card#me      | info@lindner-group.com  | lindner123   |
| building-owner  | https://onto-deside.ilabt.imec.be/css2/building-owner/profile/card#me <br/> http://localhost:3002/building-owner/profile/card#me    | info@building-owner.com | building123  |
| building-owner2 | https://onto-deside.ilabt.imec.be/css3/building-owner2/profile/card#me <br/> http://localhost:3003/building-owner2/profile/card#me  | bob@realestate.com      | bob123       |
| ragn-sells      | https://onto-deside.ilabt.imec.be/css4/ragn-sells/profile/card#me <br/> http://localhost:3004/ragn-sells/profile/card#me            | mikael@ragn-sells.se    | mikael123    |

## Textile use case

| **actor**    | **webId**                                                                                                                    | **email**             | **password**    |
|--------------|------------------------------------------------------------------------------------------------------------------------------|-----------------------|-----------------|
| admin        | https://onto-deside.ilabt.imec.be/css0/admin/profile/card#me <br/> http://localhost:3000/admin/profile/card#me               | admin@ocp.com         | admin123        |
| texon        | https://onto-deside.ilabt.imec.be/css5/texon/profile/card#me <br/> http://localhost:3005/texon/profile/card#me               | info@texon.com        | texon123        |
| manufacturer | https://onto-deside.ilabt.imec.be/css6/manufacturer/profile/card#me <br/> http://localhost:3006/manufacturer/profile/card#me | info@manufacturer.com | manufacturer123 |
| brand        | https://onto-deside.ilabt.imec.be/css7/brand/profile/card#me <br/> http://localhost:3007/brand/profile/card#me               | info@brand.com        | brand123        |

## Extended textile use case

| **actor**    | **webId**                                                                                                                    | **email**             | **password**    |
|--------------|------------------------------------------------------------------------------------------------------------------------------|-----------------------|-----------------|
| recycler     | https://onto-deside.ilabt.imec.be/css8/recycler/profile/card#me <br/> http://localhost:3008/recycler/profile/card#me         | info@recycler.com     | recycler123     |
| retailer     | https://onto-deside.ilabt.imec.be/css9/retailer/profile/card#me <br/> http://localhost:3009/retailer/profile/card#me         | info@retailer.com     | retailer123     |
| sorter       | https://onto-deside.ilabt.imec.be/css10/sorter/profile/card#me <br/> http://localhost:3010/sorter/profile/card#me            | info@sorter.com       | sorter123       |

## Evaluation use cases June 2024

Note: in the next table, `X` stands for a positive integer number. As many actors exist as needed per use case.

| **actor**          | **webId**                                                                                                                                 | **email**                      | **password**       |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|--------------------|
| construction_userX | https://onto-deside.ilabt.imec.be/css11/construction_userX/profile/card#me <br/> http://localhost:3011/construction_userX/card#me         | construction_userX@example.com | construction_userX |
| textile_userX      | https://onto-deside.ilabt.imec.be/css11/textile_userX/profile/card#me <br/> http://localhost:3011/textile_userX/card#me                   | textile_userX@example.com      | textile_userX      |
| electronics_userX  | https://onto-deside.ilabt.imec.be/css11/electronics_userX/profile/card#me <br/> http://localhost:3011/electronics_userX/card#me           | electronics_userX@example.com  | electronics_userX  |

## Testing

| **actor** | **webId**                                                                                                           | **email**    | **password** |
|-----------|---------------------------------------------------------------------------------------------------------------------|--------------|--------------|
| test      | https://onto-deside.ilabt.imec.be/css-test/test/profile/card#me <br/> http://localhost:3999/test/profile/card#me    | test@ocp.com | test123      |
