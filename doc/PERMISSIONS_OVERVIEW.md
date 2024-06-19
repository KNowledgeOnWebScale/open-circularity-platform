# Overview of permissions

We consider the permissions **read** (r), **write** (w) and **control** (c).

## Construction use case

*Next resources are set available as pre-built pod contents.*

| Pod:Resource                                               | lindner-group | building-owner | building-owner2 | ragn-sells | admin | any other actor (public) |
|------------------------------------------------------------|---------------|----------------|-----------------|------------|-------|--------------------------|
| lindner-group:data/dt/out/boms.ttl                         | rwc           |                |                 | r          | r     |                          |
| lindner-group:data/dt/out/materials.ttl                    | rwc           |                |                 | r          | r     |                          |
| lindner-group:data/dt/out/products.ttl                     | rwc           |                |                 |            | r     | r                        |
| building-owner:data/dt/out/buildings.ttl                   | r             | rwc            |                 |            | r     |                          |
| building-owner2:data/dt/out/buildings.ttl                  | r             |                | rwc             |            | r     |                          |
| building-owner2:data/dt/out/building-owner-2-buildings.ttl |               |                | rwc             |            | r     |                          |
| ragn-sells:data/dt/out/services.ttl                        |               |                |                 | rwc        | r     | r                        |

## Textile use case

*Next resources are set available as pre-built pod contents.*

| Pod:Resource                          | texon | manufacturer | brand | admin |
|---------------------------------------|-------|--------------|-------|-------|
| texon:data/dt/out/boms.ttl            | rwc   |              |       | r     |
| texon:data/dt/out/components.ttl      | rwc   | r            | r     | r     |
| texon:data/dt/out/materials.ttl       | rwc   |              |       | r     |
| manufacturer:data/dt/out/boms.ttl     |       | rwc          | r     | r     |
| manufacturer:data/dt/out/products.ttl |       | rwc          | r     | r     |

## Additional use cases

*Next resources are NOT set available as pre-built pod contents, hence the information provided here is indicative only.*

### Extended textile use case

| Pod:Resource          | texon | brand | recycler | sorter |
|-----------------------|-------|-------|----------|--------|
| texon:ceon/manuf1_1   | rwc   |       |          |        |
| texon:ceon/manuf1_2   | rwc   | r     |          |        |
| texon:ceon/manuf1_3   | rwc   | r     | r        | r      |

### Evaluation use cases June 2024

TODO