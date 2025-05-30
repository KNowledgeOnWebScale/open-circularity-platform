# Architecture

* [Introduction](#introduction)
* [Using the final setup](#using-the-final-setup)
  * [Using the included Generic Data Viewer](#using-the-included-generic-data-viewer)
  * [Using the included Comunica Webclient](#using-the-included-comunica-webclient)
    * [Adding a Solid pod to the list of datasources for a query](#adding-a-solid-pod-to-the-list-of-datasources-for-a-query)
* [Building and running](#building-and-running)
  * [The localhost setup case](#the-localhost-setup-case)
    * [Prerequisites for the localhost setup case](#prerequisites-for-the-localhost-setup-case)
    * [Environment variables for the localhost setup case](#environment-variables-for-the-localhost-setup-case)
    * [Building the localhost setup case](#building-the-localhost-setup-case)
    * [Running the localhost setup case](#running-the-localhost-setup-case)
    * [Adding pod contents for the additional use cases to the localhost setup case](#adding-pod-contents-for-the-additional-use-cases-to-the-localhost-setup-case)
    * [Using the localhost setup case](#using-the-localhost-setup-case)
    * [Stopping the localhost setup case](#stopping-the-localhost-setup-case)
  * [The public Docker based setup case](#the-public-docker-based-setup-case)
    * [Prerequisites for the public Docker based setup case](#prerequisites-for-the-public-docker-based-setup-case)
    * [Environment variables for the public Docker based setup case](#environment-variables-for-the-public-docker-based-setup-case)
    * [Building the public Docker based setup case](#building-the-public-docker-based-setup-case)
    * [Running the public Docker based setup case](#running-the-public-docker-based-setup-case)
    * [Adding pod contents for the additional use cases to the public Docker based setup case](#adding-pod-contents-for-the-additional-use-cases-to-the-public-docker-based-setup-case)
    * [Using the public Docker based setup case](#using-the-public-docker-based-setup-case)
    * [Bonus: local Generic Data Viewer for querying public pods](#bonus-local-generic-data-viewer-for-querying-public-pods)
    * [Stopping the public Docker based setup case](#stopping-the-public-docker-based-setup-case)
* [Other documentation resources](#other-documentation-resources)

## Introduction

This repository contains the implementation of an Open Circularity Platform as part of the Onto-DESIDE Horizon Europe project.

We demonstrate the Open Circularity Platform through some example use cases:

* [example use case within the Construction domain](./doc/construction-use-case.md);
* [example use case within the Textile domain](./doc/textile-use-case.md);
* some additional use cases:
  * extended example use case within the Textile domain, with data using the CEON ontology and with verifiable credentials;
  * evaluation use cases within different domains.

This repository supports [different setup cases](doc/SETUP_CASES.md).
Some are only valid during development.
The final and publicly available setup of the Open Circularity Platform relies on [Docker containers](https://www.docker.com/resources/what-container/) and
[Docker Compose](https://docs.docker.com/compose/) and illustrates the decentralized nature of the Solid-based data sharing platform.

Within the platform, we have set up:

* multiple data providers each publishing their data behind a secure access layer using Solid pods,
* a Generic Data Viewer providing an easy to use Web UI to execute queries on these Solid pods,
* a Comunica Webclient providing a more technical Web UI to execute similar or user-modified queries on these Solid pods.

During the setup-flow, Solid pods are created and prefilled with example WebIDs and other Resource Description Framework ([RDF](https://www.w3.org/TR/rdf11-primer/)) formatted data.

During the usage-flow, an end user navigates to one of the Web UIs to query the data.

## Using the final setup

The final setup is available online and needs no further action prior to usage.

### Using the included Generic Data Viewer

To use this Generic Data Viewer, navigate to <https://onto-deside.ilabt.imec.be/viewer/>.

The list of predefined queries is shown in expandible groups at the left side.

Some queries may require you to login as one of the actors, described in the use cases.
That is because read permissions to resources may be restricted to specific actors, as can be seen in the [overview of permissions](doc/PERMISSIONS_OVERVIEW.md).  
Find actors' email addresses and passwords in the [overview of actors' WebIDs, emails and passwords](doc/ACTORS_OVERVIEW.md).

To login, click on the icon in the top right.

To execute a query, click on it in the dashboard.

[This screenshot](doc/img/texon-components-materials.png) shows the result of a query about Texon's components and materials.
The result shown was obtained when logged in to identity provider `https://onto-deside.ilabt.imec.be/css5` as `info@texon.com`.

### Using the included Comunica Webclient

> This Comunica Webclient is intended for viewing low level details of the results of some predefined queries or for experimenting with new queries derived from these predefined queries.

To use this Comunica Webclient, navigate to <https://onto-deside.ilabt.imec.be/webclient/>.

Some predefined queries are available in the *Type or pick a query:* field.

The above remark about queries vs. logging in applies here too.

The login dialogue is available after clicking the *Settings asterisk* (top right.)

[This screenshot](doc/img/query-lindner-group-products.png) demonstrates querying Lindner Group's products. The result shown was obtained when logged in to identity provider `https://onto-deside.ilabt.imec.be/css1` as `info@lindner-group.com`.

#### Adding a Solid pod to the list of datasources for a query

All predefined queries are configured to work on a predefined list of datasources (Solid pods in our case). Selecting a query preloads the *Choose datasources:* dialogue.

It is possible to add your own Solid pod to the list, as illustrated [here ("any additional Solid pod")](doc/img/ocp-public-docker-with-additional-pod.png).

If you don't have a pod yet:

* you can obtain one following the [Solid project instructions](https://solidproject.org/users/get-a-pod)
* or [try out Solid pods with the SolidLab Pod Playground](https://solidlabresearch.github.io/documentation-center/getting-started/#try-out-solid-pods-with-the-solidlab-pod-playground)
  (be warned for this one: *"The pods and data on the instance is removed daily and there are no guarantees regarding uptime."*).

To add an external Solid pod to the list of datasources in the Comunica Webclient, place the cursor in
[the field 'Choose datasources'](doc/img/add-pod-to-webclient-1.png).

Next [type the baseURL of an additional Solid pod](doc/img/add-pod-to-webclient-2.png) and confirm with the `<Return>` key.

The additional datasource will be taken into account when the query is executed, and the datasource will be available as a *preset datasource* from here on.

## Building and running

We split up this section for the [different setup cases](doc/SETUP_CASES.md).

Unless specified otherwise, execute all commands below from a bash shell in the **repository root**.

The different setup cases depend on common files.

Some common files read environment variables, that need to be set upfront by sourcing the [environment variables](./doc/DEVELOPERS.md#environment-variables) files.

Some files cannot read environment variables. In these cases derived files are created from common [templates](./doc/DEVELOPERS.md#templates).

### The localhost setup case

#### Prerequisites for the localhost setup case

* a bash shell
* Node >= 18 with npm
* [yarn classic](https://classic.yarnpkg.com/lang/en/)
* Java version 17, e.g. 17.0.10-tem

#### Environment variables for the localhost setup case

Execute this command in any terminal window, before executing any other command in the remainder of this section:

```bash
source env-localhost
```

#### Building the localhost setup case

Before continuing, make sure the result of a previous build isn't running. See [Stopping the localhost setup case](#stopping-the-localhost-setup-case).

Next, execute:

```bash
# install node dependencies
yarn install
# all further build actions
./scripts/setup/finalize-setup.sh
```

#### Running the localhost setup case

Run with new pod contents (mandatory for first run):

```bash
./scripts/local-run/start-csss.sh
```

Re-run with existing pod contents (requires a previous run and stop):

```bash
./scripts/local-run/start-csss.sh -r
```

The commands above start the pods on the localhost in the background and wait until they are all ready (listening).
This takes some time to complete.

The pods log files can be consulted at `./local-run/*.log`.

The pods data can be viewed at `./local-run/data/css*/`.

#### Adding pod contents for the additional use cases to the localhost setup case

> This assumes the following additional prerequisites to the localhost setup case:
>
> * [Docker Engine](https://docs.docker.com/engine/) was installed.
> * Docker host networking is available. See also [here](https://docs.docker.com/network/network-tutorial-host/).

Execute:

```bash
./scripts/stuff-pods/stuff-pods.sh
```

#### Using the localhost setup case

Using the localhost setup case is similar to [using the final setup](#using-the-final-setup), with the following differences:

* The included Generic Data Viewer:
  * needs to be started as follows in a separate terminal window:

    ```bash
    cd ../applied-in-architecture-miravi-a-linked-data-viewer/main
    npm run dev
    ```
  
  * and can be used at the localhost port reported in the output of above command.
* The included Comunica Webclient is not available here.

#### Stopping the localhost setup case

```bash
./scripts/local-run/stop-csss.sh
```

### The public Docker based setup case

#### Prerequisites for the public Docker based setup case

* a bash shell
* Node >= 18 with npm
* [yarn classic](https://classic.yarnpkg.com/lang/en/)
* Java version 17, e.g. 17.0.10-tem
* [Docker Engine](https://docs.docker.com/engine/) and [Docker Compose](https://docs.docker.com/compose/)
  * Depending on your platform, different installation guides are available from the above links.

#### Environment variables for the public Docker based setup case

Execute this command in any terminal window, before executing any other command in the remainder of this section:

```bash
source env-docker-public
```

#### Building the public Docker based setup case

Before continuing, make sure the result of a previous build isn't running. See [Stopping the public Docker based setup case](#stopping-the-public-docker-based-setup-case).

Next, execute:

```bash
# install node dependencies
yarn install
# all further build actions
./scripts/setup/finalize-setup.sh
```

#### Running the public Docker based setup case

Run with new pod contents (mandatory for first run):

```bash
docker compose --profile backend --profile frontend --profile extra-pod up --wait
```

Re-run with existing pod contents (requires a previous run and stop):

```bash
docker compose -f docker-compose-public-restart.yml --profile backend --profile frontend --profile extra-pod up --wait
```

The commands above start all services in a Docker environment and and wait until they are all ready (listening).
This takes some time to complete.

Optional: if you're interested in what's happening while these commands execute, you may open a new terminal window and in it, execute:

```bash
docker compose --profile backend --profile frontend --profile extra-pod logs -f
```

#### Adding pod contents for the additional use cases to the public Docker based setup case

The following command may be executed on the server or on any other computer fulfilling the prerequisites and having access to the public pods, if all above steps where executed before.

Execute:

```bash
./scripts/stuff-pods/stuff-pods.sh
```

#### Using the public Docker based setup case

Usage was explained already above in [using the final setup](#using-the-final-setup).

#### Bonus: local Generic Data Viewer for querying public pods

There is one pleasant side effect of building the public Docker based setup case:
the Generic Data Viewer described in [Running the localhost setup case](#running-the-localhost-setup-case) is also available here *at the localhost*.
This time however it addresses the public pods!
This is very convenient for further query experiments on the data in the public pods...
For more info, see [The modified Generic Data Viewer](./doc/DEVELOPERS.md#the-modified-generic-data-viewer).

#### Stopping the public Docker based setup case

```bash
docker compose --profile backend --profile frontend --profile extra-pod down -t 0
```

## Other documentation resources

* [Overview of actors' WebIDs, emails and passwords](doc/ACTORS_OVERVIEW.md)
* [Overview of permissions](doc/PERMISSIONS_OVERVIEW.md)
* [About the different setup cases](doc/SETUP_CASES.md)
* [Community Solid Server (CSS) configuration](doc/CSS_SETUP.md)
* [The Firefox container](doc/FIREFOX_CONTAINER.md)
* [Developer documentation](doc/DEVELOPERS.md)
* [Testing the viewer](doc/TESTING_VIEWER.md)
