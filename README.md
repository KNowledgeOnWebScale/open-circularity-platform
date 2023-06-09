<!-- omit in toc -->
# Architecture

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [General](#general)
  - [Security](#security)
  - [Docker infrastructure](#docker-infrastructure)
- [Usage](#usage)
  - [Query](#query)
- [Demonstration Scenario](#demonstration-scenario)
- [Other documentation resources](#other-documentation-resources)

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

## Prerequisites

- a bash shell
- Node >= 16 with npm
- [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/)
    - Depending on your platform, different installation guides are available from the above links.
- [OpenSSL](https://www.openssl.org/source/)
    - Installation depends on your platform. On Linux (especially on Ubuntu 20.04 LTS), if it is not yet installed, execute `sudo apt install openssl`.
- [yarn classic](https://classic.yarnpkg.com/lang/en/)
 
## Setup

Unless specified otherwise below, execute commands from a bash shell in the repository root.

### General

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

### Security

To enable HTTPS traffic between every actor within the Docker network,
we generate a public/private keypair, a local Certificate Authority (CA) and a self-signed certificate.

```bash
cd ./scripts/cert
./main.sh # generate certificates
cd ../../
```

### Docker infrastructure

#### 1. Build locally defined images

Execute:

```bash
docker compose --profile backend --profile frontend build
```

#### 2. Start containers and wait until all's healthy

Execute:

```bash
docker compose --profile backend --profile frontend up --wait
```

Note that the command above may take some time to complete.

Optional: if you're interested in what's happening while the previous command executes, you may open a new terminal window and in it, execute:

```bash
docker compose --profile backend --profile frontend logs -f
```

#### 3. Let the Firefox browser trust our self-made Certificate Authority

The certificate of our Certificate Authority (CA) must be added to the Firefox
browser.
To do this,
open up a browser and navigate to the Firefox container at <http://localhost:5800>.

1. Open up the Firefox Certificate Manager as follows:
   1. Click the "Settings"-button (upper right),
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

#### 4. Use it

Explore the section [Usage](#usage) and/or follow the [Demonstration Scenario](#demonstration-scenario).

#### 5. Stop and remove containers

To stop and remove the containers, execute:
```bash
docker compose --profile backend --profile frontend down -t 0
```

## Usage

### Query

Browse the network through the Firefox container at <http://localhost:5800>.

To query the Solid pods,
open up a tab within the Firefox browser and navigate to
<https://webclient>.
This Comunica webclient allows you to query both
public and private (if authenticated) data stored within the Solid pods of the
Solid network.
The following screenshot demonstrates querying the `foaf:Agent`s over each actor's Solid pod.
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

## Other documentation resources
- [Overview of actors' WebIDs, emails and passwords](ACTORS_OVERVIEW.md)
- [Overview of permissions in the demo scenario](PERMISSIONS_OVERVIEW.md)
- [Testing guide](TESTING.md)
