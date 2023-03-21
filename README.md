<!-- omit in toc -->
# Architecture

- [Introduction](#introduction)
- [Setup](#setup)
  - [Security](#security)
    - [Self-Signed Certificates](#self-signed-certificates)
    - [Firefox browser](#firefox-browser)
- [Usage](#usage)
  - [Query](#query)
- [Demonstration Scenario](#demonstration-scenario)

![Open Circularity Platform](doc/img/ocp.png)

## Introduction

This repository contains the implementation
of an Open Circularity Platform as part of the Onto-DESIDE Horizon Europe project.</br>
We demonstrate the Open Circularity Platform through an [example use case within the Construction domain](./doc/construction-use-case.md).

The setup of the Open Circularity Platform is made reproducible by relying on [Docker containers](https://www.docker.com/resources/what-container/) and
[Docker Compose](https://docs.docker.com/compose/) for setting up the network locally
that represents the Solid-based decentralized data sharing platform.

Within the network, we have set up:

- multiple data providers each publishing their data behind a secure access layer using Solid pods,
- a webclient providing a Web UI to execute queries on these Solid pods, and
- a Firefox container providing a means to browse the Solid-based data-sharing platform.
 
During the setup-flow, an administrative user generates and loads all data structured using the Resource Description Framework ([RDF](https://www.w3.org/TR/rdf11-primer/)) into a Solid pod.

During the usage-flow, an end user browses to the emulated Firefox browser (<http://localhost:5800/>)
which provides access to the Solid-based decentralised data-sharing platform.
Within the emulated browser, the user navigates to the Comunica Webclient (<http://webclient>)
which provides a set of predefined queries the user can execute over the Solid pods. 

## Setup

```bash
# Install dependencies
yarn install
# Setup scripts
# - Download RML Mapper JAR
# - Setup file structure
# - Compile comunica queries
yarn run setup
# Parse YARRRML Mappings to RML & Execute RML Mappings
yarn run dt:mapping:pipeline
```

Now it is time to create the  [Self-Signed Certificates](#self-signed-certificates) and start the Docker infrastructure!

### Security

To enable HTTPS traffic between every actor within the Docker network,
we generate a public/private keypair and a certificate that is signed by
a local Certificate Authority (CA).

#### Self-Signed Certificates

🚀 Generate self-signed certificates and fire up the services !

```bash
cd ./scripts/cert
./main.sh # generate certificates
cd ../../
docker compose --profile backend --profile frontend up
```

#### Firefox browser

The certificate of our Certificate Authority (CA) must be added to the Firefox
browser.
To do this,
open up a browser and navigate to the Firefox container at <http://localhost:5800>.

1. Open up the Firefox Certificate Manager as follows:
   1. Click the the "Settings"-button (upper right),
   ![Browser setup (step 1): Settings / Privacy & Security](doc/img/setup-browser-step1.png)
   2. Click the "Privacy & Security"-tab (left),
   3. "View Certificates..." (bottom of the page)
   ![Browser setup: Firefox Certificate Manager](doc/img/setup-browser-step2.png)
  
2. Import the certificate of our CA as follows:
   1. Click on the "Import..."-button to open up the file manager
   2. Navigate to "Desktop" (left panel)
   3. Select `ca.cert` and click the "Open"-button (lower right)
   ![Browser setup: Select `ca.cert`](doc/img/setup-browser-step3.png)
   4. Check "Trust this CA to identify websites" and click "OK"
   ![Browser setup: Trust this CA to identify websites](doc/img/setup-browser-step4.png)

At this point,
the Solid network can be browsed securely over HTTPS.

## Usage

### Query

Browse the network through the Firefox container at <http://localhost:5800>.

To query the Solid pods,
open up a tab within the Firefox browser and navigate to
<https://webclient>.
This Comunica webclient allows you to query both
public and private (if authenticated) data stored within the Solid pods of the
Solid network.
The following screenshot demonstrates queries the `foaf:Agent`s over each actor's Solid pod.
![Query: FOAF Agents](doc/img/query-agents.png)

## Demonstration Scenario

We demonstrate how this Open Circularity Platform copes with multiple existing data sources in different serializations,
and with different actors that have different authorization levels.

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

[screencast-d4_2]: https://youtu.be/WkQUwIwi_1M
