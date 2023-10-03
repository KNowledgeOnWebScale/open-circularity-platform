<!-- omit in toc -->
# Architecture

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
  - [General](#general)
    - [Installation](#installation)
    - [Environment variables](#environment-variables)
    - [File templates](#file-templates)
    - [Finalise setup](#finalise-setup)
  - [Security](#security)
  - [Mappings](#mappings)
  - [Building the webclient contents](#building-the-webclient-contents)
  - [Building the data viewer contents](#building-the-data-viewer-contents)
  - [Docker infrastructure](#docker-infrastructure)
    - [1. Build locally defined images](#1-build-locally-defined-images)
    - [2. Start containers and wait until all's healthy](#2-start-containers-and-wait-until-alls-healthy)
    - [3. Let the Firefox browser trust our self-made Certificate Authority](#3-let-the-firefox-browser-trust-our-self-made-certificate-authority)
    - [4. Use it](#4-use-it)
    - [5. Stop and remove containers](#5-stop-and-remove-containers)
- [Usage](#usage)
  - [Low level querying using a technical Comunica webclient](#low-level-querying-using-a-technical-comunica-webclient)
  - [Higher level querying using the data viewer](#higher-level-querying-using-the-data-viewer)
  - [Other documentation resources](#other-documentation-resources)

## Introduction

This repository contains the implementation
of an Open Circularity Platform as part of the Onto-DESIDE Horizon Europe project.</br>
We demonstrate the Open Circularity Platform through some example use cases:
- [example use case within the Construction domain](./doc/construction-use-case.md)
- [example use case within the Textile domain](./doc/textile-use-case.md)

The setup of the Open Circularity Platform is made reproducible by relying on [Docker containers](https://www.docker.com/resources/what-container/) and
[Docker Compose](https://docs.docker.com/compose/) for setting up the network locally
that represents the Solid-based decentralized data sharing platform.

Within the network, we have set up:

- multiple data providers each publishing their data behind a secure access layer using Solid pods,
- a webclient providing a Web UI to execute queries on these Solid pods, and
- a Firefox container providing a means to browse the Solid-based data-sharing platform.
 
During the setup-flow, an administrative user generates and loads all data structured using the Resource Description Framework ([RDF](https://www.w3.org/TR/rdf11-primer/)) into a Solid pod.

During the usage-flow, an end user browses to the emulated Firefox browser
which provides access to the Solid-based decentralised data-sharing platform.
Within the emulated browser, the user navigates
either to the rather technical Comunica Webclient which provides a set of predefined queries the user can execute over the Solid pods
or to the Data viewer, a more user-friendly web application that works with the same underlying predefined queries. 

## Prerequisites

- a bash shell
- Node >= 16 with npm
- [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/)
    - Depending on your platform, different installation guides are available from the above links.
- [OpenSSL](https://www.openssl.org/source/)
    - Installation depends on your platform. On Linux (especially on Ubuntu 20.04 LTS), if it is not yet installed, execute `sudo apt install openssl`.
- [yarn classic](https://classic.yarnpkg.com/lang/en/)
 
## Setup

Unless specified otherwise below, execute commands from a bash shell in the **repository root**.

### General

#### Installation

```bash
# Install dependencies
yarn install
```

#### Environment variables

In any new bash shell, before executing any of the commands given below (in this Setup section and in the other sections),
first execute `source <environment variables file>` at the repository root, where `<environment variables file>`
is one of the files listed below.
- [envvars](envvars): services in Docker compose network support HTTPS internally
- [envvars2](envvars2): services in Docker compose network rely on external proxy for HTTPS support

```
# example for envvars2
source envvars2
```

Developers: see also [Developer documentation](doc/DEVELOPERS.md).

#### File templates

Create files from their templates:
```
./scripts/templates/apply-templates.sh
```

#### Finalise setup

```bash
# Setup scripts
# - Download RML Mapper JAR
# - Setup file structure
yarn run setup
```

### Security

To enable HTTPS traffic between every actor within the Docker network,
we generate a public/private keypair, a local Certificate Authority (CA) and a self-signed certificate.

> Note: this step is only needed in case of environment variables file *envvars*.

```bash
# generate certificates
cd ./scripts/cert && bash ./main.sh && cd ../../
```

### Mappings

```bash
# Parse YARRRML Mappings to RML & Execute RML Mappings
yarn run dt:mapping:pipeline
```

### Building the webclient contents

```bash
# Collect queries
yarn run comunica:queries:setup
```

### Building the data viewer contents

Clone and select tag of the [Generic data viewer builder](<https://github.com/SolidLabResearch/generic-data-viewer-react-admin>) and install it:
```
# will clone in the parent directory of this clone, an assumption of our scripts
pushd ..
git clone git@github.com:SolidLabResearch/generic-data-viewer-react-admin.git
cd generic-data-viewer-react-admin
# select tag
git checkout ref2-internal
npm install
# come back to the root of this clone
popd
```

Prepare the viewer builder, by providing it links to our input, build the static content and copy it to its destination location:
```
cd ./scripts/viewer && ./prepare.sh && ./build-and-harvest.sh && cd ../../
```

After this step, `../generic-data-viewer-react-admin` is no longer needed.

### Docker infrastructure

#### 1. Build locally defined images

Execute:

```bash
yarn run dc:build
```

#### 2. Start containers and wait until all's healthy

Execute:

```bash
yarn run dc:up
```

Note that the command above may take some time to complete.

Optional: if you're interested in what's happening while the previous command executes, you may open a new terminal window and in it, execute:

```bash
yarn run dc:logs
```

#### 3. Let the Firefox browser trust our self-made Certificate Authority

> Note: this step is only needed in case of environment variables file *envvars*.

Follow the instructions in [the Setup section of FIREFOX_CONTAINER.md](doc/FIREFOX_CONTAINER.md#setup).

#### 4. Use it

Explore the section [Usage](#usage).

#### 5. Stop and remove containers

To stop and remove the containers, execute:
```bash
yarn run dc:down
```

## Usage

### Before continuing

In case of environment variables file *envvars*, browse the Docker network through the Firefox container,
available from your local browser at <http://localhost:5800>.

Otherwise, browse through your favorite local browser.

Below, we'll just mention the selected browser as "your browser".

### Low level querying using a technical Comunica webclient

To query the Solid pods, open up a tab within your browser and navigate to the URL configured for the webclient
(<https://webclient.onto-deside.ilabt.imec.be/> or other, depending on the configuration).

This Comunica webclient allows you to query both public and private (if authenticated) data stored within
the Solid pods of the Solid network.

The following screenshot demonstrates querying the `foaf:Agent`s over each actor's Solid pod.
![Query: FOAF Agents](doc/img/query-agents.png)

### Higher level querying using the data viewer

To use this data viewer, open up a tab within your browser and navigate to the URL configured for the data viewer
(<https://viewer.onto-deside.ilabt.imec.be:8443/> or other, depending on the configuration).

The following screenshot shows the result of a query about Texon's components and materials.
![View: Texon's components and materials](doc/img/texon-components-materials.png)

## Other documentation resources

- [Overview of actors' WebIDs, emails and passwords](doc/ACTORS_OVERVIEW.md)
- [Overview of permissions](doc/PERMISSIONS_OVERVIEW.md)
- [Testing guide](doc/TESTING.md)
- [Community Solid Server (CSS) configuration](doc/CSS_SETUP.md)
- [The Firefox container](doc/FIREFOX_CONTAINER.md)
- [Developer documentation](doc/DEVELOPERS.md)
