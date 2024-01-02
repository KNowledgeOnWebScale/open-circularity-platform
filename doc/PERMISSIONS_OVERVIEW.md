# Overview of permissions

We consider the permissions **read**, **write** and **control**.

Obvious permissions
- Owners have *read*, *write* and *control* permissions on their own resources.
- The *admin* actor has *read* permission on all resources.

Use case specific permissions
- Specific permissions are shown in the tables below.
 
## Construction use case

| Owner:Resource                                 | lindner-group | building-owner | building-owner2 | ragn-sells | any other actor (public) |
|------------------------------------------------|---------------|----------------|-----------------|------------|--------------------------|
| lindner-group:boms.ttl                         |               |                |                 | read       |                          |
| lindner-group:materials.ttl                    |               |                |                 | read       |                          |
| lindner-group:products.ttl                     |               |                |                 |            | read                     |
| building-owner:buildings.ttl                   | read          |                |                 |            |                          |
| building-owner2:buildings.ttl                  | read          |                |                 |            |                          |
| building-owner2:building-owner-2-buildings.ttl |               |                |                 |            |                          |
| ragn-sells:services.ttl                        |               |                |                 |            | read                     |

## Textile use case

| Owner:Resource            | texon | manufacturer | brand | any other actor (public)  |
|---------------------------|-------|--------------|-------|---------------------------|
| texon:boms.ttl            |       |              |       |                           |
| texon:components.ttl      |       | read         | read  |                           |
| texon:materials.ttl       |       |              |       |                           |
| manufacturer:boms.ttl     |       |              | read  |                           |
| manufacturer:products.ttl |       |              | read  |                           |

