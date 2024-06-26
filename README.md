# Architecture

* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Setup](#setup)
  * [General](#general)
    * [Installation](#installation)
    * [Environment variables](#environment-variables)
    * [File templates](#file-templates)
    * [Finalize setup](#finalize-setup)
  * [Docker infrastructure](#docker-infrastructure)
    * [1. Start containers](#1-start-containers)
    * [2. Use it](#2-use-it)
    * [3. Stop and remove containers](#3-stop-and-remove-containers)
  * [Local development infrastructure](#local-development-infrastructure)
    * [1. Start pods](#1-start-pods)
    * [2. Use it](#2-use-it-1)
    * [3. Stop pods](#3-stop-pods)
* [Usage](#usage)
  * [Before continuing](#before-continuing)
  * [Low level querying using the included technical Comunica webclient](#low-level-querying-using-the-included-technical-comunica-webclient)
    * [Add a Solid pod to the list of datasources for a query](#add-a-solid-pod-to-the-list-of-datasources-for-a-query)
  * [Higher level querying using the included data viewer](#higher-level-querying-using-the-included-data-viewer)
* [Other documentation resources](#other-documentation-resources)

## Introduction

This repository contains the implementation
of an Open Circularity Platform as part of the Onto-DESIDE Horizon Europe project.</br>
We demonstrate the Open Circularity Platform through some example use cases:

* [example use case within the Construction domain](./doc/construction-use-case.md)
* [example use case within the Textile domain](./doc/textile-use-case.md)

The setup of the Open Circularity Platform is made reproducible by relying on [Docker containers](https://www.docker.com/resources/what-container/) and
[Docker Compose](https://docs.docker.com/compose/) for setting up the network locally
that represents the Solid-based decentralized data sharing platform.

Within the network, we have set up:

* multiple data providers each publishing their data behind a secure access layer using Solid pods,
* a (technical) webclient providing a Web UI to execute queries on these Solid pods, and
* a (more user friendly) data viewer providing an easier to use Web UI to execute queries on these Solid pods.

During the setup-flow, Solid pods are created and prefilled with example WebIDs and other Resource Description Framework ([RDF](https://www.w3.org/TR/rdf11-primer/)) formatted data.

During the usage-flow, an end user navigates either to the rather technical Comunica Webclient
which provides a set of predefined queries the user can execute over the Solid pods
or to the generic data viewer, a more user-friendly web application that works with the same underlying predefined queries.

> A **public deployment** is available. To use it as is, no further setup is needed, so continue reading at [Usage](#usage) and choose *Selected setup = Public deployment*.

## Prerequisites

* a bash shell
* Node >= 18 with npm
* [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/)
  * Depending on your platform, different installation guides are available from the above links.
* [OpenSSL](https://www.openssl.org/source/)
  * Installation depends on your platform. On Linux (especially on Ubuntu 20.04 LTS), if it is not yet installed, execute `sudo apt install openssl`.
* [yarn classic](https://classic.yarnpkg.com/lang/en/)

## Setup

Unless specified otherwise below, execute commands from a bash shell in the **repository root**.

### General

#### Installation

```bash
# Install dependencies
yarn install
```

#### Environment variables

The files in this repository were prepared to generate output for three different selected setups.
The selection of a selected setup is done by means of environment variables.
These environment variables are assigned in *environment variables files*.

An overview:

| Selected setup                                   | Details                                                                                                                             | Environment variables file | Docker based |
|--------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|----------------------------|--------------|
| Development and stand-alone demo                 | URLS `https://...`, same as in [envvars2](envvars2), but nothing publicly accessible (use included webapps via included browser)    | [envvars](envvars)         | yes          |
| Public deployment                                | URLS `https://...`, publicly accessible pods and included webapps, open for external webapps                                        | [envvars2](envvars2)       | yes          |
| Local development                                | URLs `http://localhost:...`, pods running on the local host, webapps not included, open for local webapps                           | [envvars3](envvars3)       | no           |

In any new bash shell, before executing any of the commands in this Setup section and in the other sections,
first assign the environment variables using the appropriate environment variables file:

```bash
# example for file 'envvars2'
source envvars2
```

For a closer look at the different selected setups, see [here](doc/SELECTED_SETUPS.md).

#### File templates

This repository contains template files `*.template`.
When following the instructions below, from every template file `x.template` a file `x` will be derived with contents
depending on the environment variables file sourced above. The files `x` themselves are git-ignored.

#### Finalize setup

The list of actions to be executed here is managed in a script.
The script takes into account the sourced environment variables file.
Execute:

```bash
./scripts/setup/finalize-setup.sh
```

### Docker infrastructure

> This section applies to Docker based setups only.

#### 1. Start containers

Execute...

```bash
# if you are on a server where previous versions still are running:
docker compose --profile backend --profile frontend --profile extra-pod down -t 0
# and then:
docker compose --profile backend --profile frontend --profile extra-pod up --wait
```

The command above starts all services in a Docker environment and and waits until they are all ready (listening).
This takes some time to complete.

Optional: if you're interested in what's happening while the previous command executes, you may open a new terminal window and in it, execute:

```bash
docker compose --profile backend --profile frontend --profile extra-pod logs -f
```

#### 2. Use it

Explore the section [Usage](#usage).

#### 3. Stop and remove containers

To stop and remove the containers, execute:

```bash
docker compose --profile backend --profile frontend --profile extra-pod down -t 0
```

### Local development infrastructure

> This section applies to the local development setup only.

#### 1. Start pods

Execute...

```bash
./scripts/local-run/start-csss.sh
```

The command above starts the pods in the background and waits until they are all ready (listening).
This takes some time to complete.

The pods log files can be consulted at `./local-run/*.log`.

The pods data can be viewed at `./local-run/data/css*/`.

#### 2. Use it

Explore the section [Usage](#usage).

#### 3. Stop pods

Execute:

```bash
./scripts/local-run/stop-csss.sh
```

## Usage

### Before continuing

In case of environment variables file *envvars*, you need to let the Firefox browser trust our self-made Certificate Authority.
Follow the instructions in [the Setup section of FIREFOX_CONTAINER.md](doc/FIREFOX_CONTAINER.md#setup).

Some queries may require you to login as one of the actors, described in the use cases.
That is because read permissions to resources may be restricted to specific actors, as can be seen in the [overview of permissions](doc/PERMISSIONS_OVERVIEW.md).  
Find actors' email addresses and passwords in the [overview of actors' WebIDs, emails and passwords](doc/ACTORS_OVERVIEW.md).

The queries acting on the resources described as "Textile use case 2" in the [overview of permissions](doc/PERMISSIONS_OVERVIEW.md) give results only if
these resources are added to the involved pod(s) after the pods are running. If not done before, you may add them now by executing:

```bash
./scripts/stuff-pods/stuff-pods.sh
```

### Low level querying using the included technical Comunica webclient

> Skip this section in favor of [higher level querying using the included data viewer](#higher-level-querying-using-the-included-data-viewer),
> unless if you really need to see low level details.

To query the Solid pods, navigate to the URL configured for the webclient:

| Selected setup                                   | Included technical Comunica webclient URL      | Browse via                                            |
|--------------------------------------------------|------------------------------------------------|-------------------------------------------------------|
| Development and stand-alone demo                 | <https://webclient.onto-deside.ilabt.imec.be/> | Included Firefox container at <http://localhost:5800> |
| Public deployment                                | <https://webclient.onto-deside.ilabt.imec.be/> | Your local browser                                    |
| Local development                                | Not available; do it yourself if needed (1)    | Your local browser                                    |

(1) The queries as used in other setups are prepared for you in `./scripts/comunica/outputs/queries/`.

This Comunica webclient allows you to query both public and private (if authenticated) data stored within
the Solid pods of the Solid network.

[This screenshot](doc/img/query-lindner-group-products.png) demonstrates querying Lindner Group's products. The result shown was obtained when logged in to identity provider `https://css1.onto-deside.ilabt.imec.be` as `info@lindner-group.com`.

#### Add a Solid pod to the list of datasources for a query

All queries are configured to work on a predefined list of datasources (Solid pods in our case). Selecting a query preloads the *Choose datasources:* dialogue.

In the public deployment setup case, it is possible to add your own Solid pod to the list.
See also [Public deployment with additional external Solid pods](doc/SELECTED_SETUPS.md#public-deployment-with-additional-external-solid-pods).

If you don't have a pod yet:

* you can obtain one following the [Solid project instructions](https://solidproject.org/users/get-a-pod)
* or [try out Solid pods with the SolidLab Pod Playground](https://solidlabresearch.github.io/documentation-center/getting-started/#try-out-solid-pods-with-the-solidlab-pod-playground)
  (be warned for this one: *"The pods and data on the instance is removed daily and there are no guarantees regarding uptime."*).

To add an external Solid pod to the list of datasources in the Comunica webclient, place the cursor in
[the field 'Choose datasources'](doc/img/add-pod-to-webclient-1.png).

Next [type the baseURL of an additional Solid pod](doc/img/add-pod-to-webclient-2.png) and confirm with the `<Return>` key.

The additional datasource will be taken into account when the query is executed, and the datasource will be available as a *preset datasource* from here on.

### Higher level querying using the included data viewer

To use this data viewer, navigate to the URL configured for the data viewer:

| Selected setup                                   | Included data viewer URL                           | Browse via                                            |
|--------------------------------------------------|----------------------------------------------------|-------------------------------------------------------|
| Development and stand-alone demo                 | <https://viewer.onto-deside.ilabt.imec.be/>        | Included Firefox container at <http://localhost:5800> |
| Public deployment                                | <https://viewer.onto-deside.ilabt.imec.be/> (2)    | Your local browser                                    |
| Local development                                | <http://localhost:port-nr> (1)(2)                  | Your local browser                                    |

(1) Go to `../applied-in-architecture-generic-data-viewer-react-admin`, spin up the viewer with `npm run dev` and browse the localhost at the port reported by this command.

(2) More about how to use `../applied-in-architecture-generic-data-viewer-react-admin` for local query development: see [The modified data viewer in the developer documentation](doc/DEVELOPERS.md#the-modified-data-viewer).

[This screenshot](doc/img/texon-components-materials.png) shows the result of a query about Texon's components and materials.
The result shown was obtained when logged in to identity provider `https://css5.onto-deside.ilabt.imec.be` as `info@texon.com`.

## Other documentation resources

* [Overview of actors' WebIDs, emails and passwords](doc/ACTORS_OVERVIEW.md)
* [Overview of permissions](doc/PERMISSIONS_OVERVIEW.md)
* [About the different selected setups](doc/SELECTED_SETUPS.md)
* [Testing guide](doc/TESTING.md)
* [Community Solid Server (CSS) configuration](doc/CSS_SETUP.md)
* [The Firefox container](doc/FIREFOX_CONTAINER.md)
* [Developer documentation](doc/DEVELOPERS.md)
