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

Every actors has their a pod, hosted by their own [Community Solid server][css].
Each pod contains the Turtle files of the actor owning the pod.</br>
To operate on the Solid pods (e.g. specifying access control),
we use of [Bashlib][bashlib]: a Command-Line Interface to interact with actors in a Solid.</br>
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
- The “admin” actor can *READ* every actor’s generated data (i.e. data within `<actor>/data/dt/out`)

## Demo

> 📽️ [Demo][screencast-d4_2]
 
When an actor is not yet authenticated,
only access to publicly shared data can be read.
For example, the actors within the Solid network.
[📽️ [Not authenticated] Query actors within the Solid network](https://youtube.com/clip/UgkxKL2O-5JJ3dZ1f01BJPbMRP1egqnx5Sjb)

A Manufacturer can *READ* User/Customer data.</br>
When authenticating as a Manufacturer,
like Lindner Group,
one can query the where its tiles are located.

- [Authenticating as Lindner Group](https://youtube.com/clip/UgkxsSfr3KDmiqoZUs5xoSrSxWW6IZotsKIw)
- [[Authenticated as Lindner Group] Query: What are the tiles of Building B0?](https://youtube.com/clip/UgkxC3Mawc5yP-2ZTL8gwjs2uhVueoC6kvKR)
- [[Authenticated as Lindner Group] Query: What are the tiles of the building at a specific address?](https://youtube.com/clip/Ugkx4wWg-6mgz45aUczUXiFEeOyNmP43OXHP)
- [[Authenticated as Lindner Group] Query 1: What are Linder Group's Products? Query 2: What are the product details?](https://youtube.com/clip/UgkxtDBtWkJkZbwGElBf0hrZiOcF1drFmxQa)

A User can *READ* the *Products* of a *Manufacturer*.</br>
From the perspective of a Building Owner, only product data is readable.
However, it is not possible for a *User* to read *Product Details*.</br>
More specifically, the *Building Owner* is not able to query the product details.

- [Authenticating as Building Owner](https://youtube.com/clip/UgkxndBmpEvsJerW3oTNNQSWKLnlcuQZjZRK)
- [[Authenticated as Building Owner] Query Lindner Group's products](https://youtube.com/clip/UgkxEfq0IwN144XwS-KZ1B9gkdCAKUQk4_ZS)
- [[Authenticated as Building Owner] Query Lindner Group's product details: Not Authorized!](https://youtube.com/clip/UgkxlDoAHFJQVidm9s1WWCyHUho1P8_Q7iXH)

The *Admin* actor can *READ* every actor’s generated data.

- [[Authenticated as Admin] Count & Query all triples!](https://youtube.com/clip/UgkxXGvlJCiqNT1zaLBESrmgRErY0puAlrw7)

<!-- Refs -->
[comunica-webclient]: https://github.com/comunica/jQuery-Widget.js
[css]: https://github.com/CommunitySolidServer/CommunitySolidServer
[bashlib]: https://github.com/SolidLabResearch/Bashlib
[rmlmapper]: https://github.com/RMLio/rmlmapper-java
[yarrrml-parser]: https://github.com/RMLio/yarrrml-parser/tree/development/lib
