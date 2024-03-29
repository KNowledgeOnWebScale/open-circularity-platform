# Use case: Construction

TODOs

- [ ] update diagram to include new actors (building owner 2 & ragn sells)

---

The use case is as follows:

A building owner owns some buildings. Floors in a building are covered with
floor tiles, delivered by a manufacturer (Lindner Group), who uses materials to
construct the tiles. At some time in a building’s lifetime, the building owner
refurbishes a building and wants to decide on what to do with the floor tiles,
based on economic and environmental costs.

From Lindner Group's perspective, all product data and quality metrics are known. On
the other hand, Lindner does not have information on dismantled raised floor
elements: where to find them, how many can be found, when we these elements be
available? Therefore, procuring secondary raw materials in a secure way is hard
due to lack of data on those materials. Access to more data, and at increased
granularity, would increase the usage of those materials.

Information on product level are not registered throughout the lifecycle of the
product which makes it hard to securely assess the quality and secure the
correct handling of the product, either for reuse or to transform it into
secondary raw materials.

![Construction use case](img/construction-use-case.png)

## Implementation

We map the source data to Linked Data using the [YARRRML parser][yarrrml-parser]
and the [RMLMapper][rmlmapper].
As a result, every actor's source data will be transformed to RDF, serialized as Turtle.

Every actor has its pod, hosted by its own [Community Solid server][css].
Each pod contains the Turtle files of the actor owning the pod.</br>
Access control on the Turtle files is preset;

To query the distributed data, we use the [Comunica Webclient][comunica-webclient]:
a jQuery widget to query heterogeneous interfaces using Comunica SPARQL.

## Features

### Flexible support for heterogeneous systems

There are 4 actors,
each storing their data using a different data model and different serialization:

- Building Owner (User)
  - Buildings (CSV)
- Building Owner 2 (User)
  - Buildings (JSON)
- Lindner Group (Manufacturer)
  - Bill of Materials (CSV)
  - Materials (CSV)
  - Products (CSV)
- Ragn-Sells (Sorter, Recycler)
  - Services (XML)
  
#### Related user stories

| ID | Name | AS A | I WANT TO |
| --- | --- | --- | --- |
| CUS1 | End of life scenarios         | Building owner | I want to know which are the different EOL scenarios for building materials |
| CUS2 | Material business case        | Building owner | I want to obtain economic and environmental costs of different end-of-life scenarios for building material |
| CUS3 | Inventory | Manufacturer | I want to obtain information on quantities and locations of my products that will be dismantled. |
| CUS4 | Rest material from production | Manufacturer   | I want to find out if the rest material from my production could be used in other production processes     |
| CUS5 | Cost                          | Manufacturer   | I want to know the costs of dismantling and refurbishing my products.                                      |
| CUS8 | Tender                        | Tenderer       | I want to retrieve product information from the manufacturer.                                              |
| CUS10 | Deconstruction | Deconstruction company | I want to be informed on buildings where the deconstruction is planned and for what  |
| CUS13 | Planning | Manufacturer, Dismantler, Tenderer, Recycler, Deconstruction company, Planner, Marketplace | I want to retrieve product information such as measurements, composition, qualities, quantities, and location. I also need to be able to access the process and handling information that are related to these products. |

#### Data - Building

The (dummy) data describes a *Building* owned by *Building Owner 2*.<br>
The data is loosely based based on the [BIM](https://en.wikipedia.org/wiki/Building_information_modeling#:~:text=Building%20Information%20Modeling%20(BIM)%20is%20a%20digital%20representation%20of%20physical,from%20earliest%20conception%20to%20demolition) model.


```json
{
  "id": "fsml88",
  "address": "88 Fairview Street Mount Laurel, NJ 08054",

  "building-storey": [
    {
      "type": "floor",
      "name": "l0",
      "tiles": [ "0x03", "0x04", "0x05" ]
    },
    {
      "type": "floor",
      "name": "l1",
      "tiles": [ "0x06", "0x07", "0x08" ]
    }
  ]
}
```

#### Data - Service

The (dummy) data describes the *Sorting* service provided by Ragn-Sells.<br>
The *Sorting* service accepts different *Waste Streams*.

```xml
<root>
	<services>
		<service name="Sorting">
			<waste-streams>

				<waste-stream name="LDPE">
					<description>
						Low-density polyethylene (LDPE) is a thermoplastic made from the monomer ethylene. It was the first grade of polyethylene, produced in 1933 by Imperial Chemical Industries (ICI) using a high pressure process via free radical polymerization.
					</description>
				</waste-stream>

				<waste-stream name="HDPE">
					<description>
						High-density polyethylene (HDPE) or polyethylene high-density (PEHD) is a thermoplastic polymer produced from the monomer ethylene. It is sometimes called "alkathene" or "polythene" when used for HDPE pipes.[1] With a high strength-to-density ratio, HDPE is used in the production of plastic bottles, corrosion-resistant piping, geomembranes and plastic lumber. HDPE is commonly recycled, and has the number "2" as its resin identification code.
					</description>
				</waste-stream>

				<waste-stream name="Ferrous">
					<description>
						...
					</description>
				</waste-stream>

				<waste-stream name="ConstructionAndDemolition">
					<description>
						The EPA defines this type of waste as “Construction and Demolition (CD) debris is a type of waste that is not included in municipal solid waste (MSW).”[11] Items typically found in CD include but are not limited to steel, wood products, drywall and plaster, brick and clay tile, asphalt shingles, concrete, and asphalt. Generally speaking, construction and demolition waste can be categorized as any components needed to build infrastructures. In 2018, the EPA estimated that the US generated approximately 600 million tons of CD waste. [11]  The waste generated by construction and demolition is often intended to be reused or is sent to the landfill. Examples of reused waste is milled asphalt can be used again for the asphalt mixture or fill dirt can be used to level grade.
					</description>
				</waste-stream>
			</waste-streams>

		</service>
	</services>
</root>
```

These different *data models* and different *serializations* are mapped onto a common (draft) data model,
showcasing that this Open Circularity Platform can cope with multiple existing  systems.

### Access Control

Generally, the following ACL rules are applied

- a Manufacturer can *READ* User/Customer data
- a User can *READ* the *Products* of a *Manufacturer*
- every authenticated actor can *READ* the available services of a Recycler or Sorter
- the platform Administrator can *READ* all data generated by the actors

Applied to the construction example use case, this comes down to

- “Lindner Group” can *READ* buildings data from “Building Owner” & “Building Owner 2”
- “Building Owner” & “Building Owner 2” can *READ* product data from “Lindner Group”
- All actors can *READ* service descriptions from Ragn-Sells
- The “admin” actor can *READ* every actor’s generated data (i.e. data within `<actor>/pod/data/dt/out`)

<!-- Refs -->
[comunica-webclient]: https://github.com/comunica/jQuery-Widget.js
[css]: https://github.com/CommunitySolidServer/CommunitySolidServer
[rmlmapper]: https://github.com/RMLio/rmlmapper-java
[yarrrml-parser]: https://github.com/RMLio/yarrrml-parser/tree/development/lib

## Demonstration Scenario

We demonstrate how this Open Circularity Platform copes with multiple existing
data sources in different serializations,
and with different actors that have different authorization levels.
Concretely, the data sharing capabilities of the Open Circularity Platform
are demonstrated through the Comunica Web client: a jQuery widget to query heterogeneous interfaces using SPARQL.
This client allows actors to log in to their Solid pod and execute queries on data federated over Solid pods that are connected to the platform.

The [screencasts](https://www.youtube.com/playlist?list=PLRjX1hcEWzHCrKURt1XuCoS79I0swX8Bs)
showcase the access control scenarios from different perspectives,
depending on the actor.
For example,
(i) unauthenticated users can only query public data (e.g. Ragn-Sells' service descriptions);
(ii) customers (e.g. the building owners) can query the details of the buildings they own,
and general product information from manufacturers (e.g. Lindner Group);
(iii) manufacturers can read details the buildings from each customer;
(iv) recyclers (e.g. Ragn-Sells) can read a manufacturer's general product information,
as well as details (e.g. materials, and material compositions) required for their sorting service.

