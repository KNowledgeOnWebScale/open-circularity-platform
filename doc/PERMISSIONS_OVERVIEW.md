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

### Evaluation use cases June 2024: Construction

(All users `construction_userX` abbreviated to `userX`)

| Pod:Resource     | user1 | user2 | user3 | user4 | user5 | user6 | user7 | user8 | user9 |
|------------------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| user1:ceon/index | rwc   | r     | r     | r     | r     | r     |       |       |       |
| user1:ceon/data  | rwc   | r     | r     | r     | r     | r     |       |       |       |
| user2:ceon/index |       | rwc   | r     | r     | r     |       |       |       |       |
| user2:ceon/data  |       | rwc   | r     | r     | r     |       |       |       |       |
| user3:ceon/index |       | r     | rwc   | r     | r     | r     |       |       |       |
| user3:ceon/data  |       | r     | rwc   | r     | r     | r     |       |       |       |
| user4:ceon/index |       | r     |       | rwc   |       |       |       |       |       |
| user4:ceon/data  |       | r     |       | rwc   |       |       |       |       |       |
| user5:ceon/index |       | r     |       |       | rwc   |       |       |       |       |
| user5:ceon/data  |       | r     |       |       | rwc   |       |       |       |       |
| user6:ceon/index |       | r     |       |       |       | rwc   |       |       |       |
| user6:ceon/data  |       | r     |       |       |       | rwc   |       |       |       |
| user9:ceon/index | r     | r     | r     | r     | r     |       |       |       | rwc   |

### Evaluation use cases June 2024: Electronics

(All users `electronics_userX` abbreviated to `userX`)

| Pod:Resource        | user1 | user2 | user3 | user4 | user5 | user6 | user7 | user8 | user9 |
|---------------------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| user1:ceon/index    | rwc   |       |       |       |       | r     |       |       |       |
| user1:ceon/products | rwc   |       |       |       |       | r     |       |       |       |
| user2:ceon/index    |       | rwc   |       |       |       | r     |       |       |       |
| user2:ceon/products |       | rwc   |       |       |       | r     |       |       |       |
| user3:ceon/index    |       |       | rwc   |       |       | r     |       |       |       |
| user3:ceon/products |       |       | rwc   |       |       | r     |       |       |       |
| user4:ceon/index    |       |       |       | rwc   |       | r     |       |       |       |
| user4:ceon/products |       |       |       | rwc   |       | r     |       |       |       |
| user5:ceon/index    |       |       |       |       | rwc   | r     |       |       |       |
| user5:ceon/products |       |       |       |       | rwc   | r     |       |       |       |
| user6:ceon/index    |       |       |       |       |       | rwc   | r     |       |       |
| user6:ceon/products |       |       |       |       |       | rwc   | r     |       |       |
| user9:ceon/index    | r     | r     | r     | r     | r     | r     | r     |       | rwc   |

### Evaluation use cases June 2024: Textile

(All users `textile_userX` abbreviated to `userX`)

| Pod:Resource     | user1 | user2 | user3 | user4 | user5 | user6 | user7 | user8 | user9 |
|------------------|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| user1:ceon/index | rwc   |       |       |       |       | r     | r     |       |       |
| user1:ceon/data  | rwc   |       |       |       |       | r     | r     |       |       |
| user2:ceon/index |       | rwc   |       |       |       | r     | r     |       |       |
| user2:ceon/data  |       | rwc   |       |       |       | r     | r     |       |       |
| user3:ceon/index |       |       | rwc   |       |       | r     | r     |       |       |
| user3:ceon/data  |       |       | rwc   |       |       | r     | r     |       |       |
| user4:ceon/index |       |       |       | rwc   |       | r     | r     |       |       |
| user4:ceon/data  |       |       |       | rwc   |       | r     | r     |       |       |
| user6:ceon/index |       |       |       |       |       | rwc   | r     |       |       |
| user6:ceon/data  |       |       |       |       |       | rwc   | r     |       |       |
| user7:ceon/index |       |       |       |       |       | r     | rwc   |       |       |
| user7:ceon/data  |       |       |       |       |       | r     | rwc   |       |       |
| user9:ceon/index | r     | r     | r     | r     | r     | r     | r     |       | rwc   |
