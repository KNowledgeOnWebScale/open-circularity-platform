# Developer documentation

* [Environment variables](#environment-variables)
  * [Implementation details](#implementation-details)
    * [env-localhost](#env-localhost)
    * [env-docker-public](#env-docker-public)
    * [env-docker-private](#env-docker-private)
* [Templates](#templates)
  * [Making a new template](#making-a-new-template)
  * [Updating templates](#updating-templates)
* [Webclient Docker image](#webclient-docker-image)
* [The modified Generic Data Viewer](#the-modified-generic-data-viewer)
  * [How the modified Generic Data Viewer is built](#how-the-modified-generic-data-viewer-is-built)
  * [Using the modified Generic Data Viewer for query development](#using-the-modified-generic-data-viewer-for-query-development)
* [Direct access to the file system of a CSS](#direct-access-to-the-file-system-of-a-css)
* [How to supporting additional use cases](#how-to-supporting-additional-use-cases)
  * [Adapting the data and mapping files](#adapting-the-data-and-mapping-files)
  * [Merging viewer files](#merging-viewer-files)
  * [Finally](#finally)

## Environment variables

Environment variables files are listed in [Implementation details below](#implementation-details).

> Note:
> When in a new environment variables file the need appears to **add** one or more environment variables,
> revisit the **existing** environment variable files and sync them (perhaps with a different value for the involved environment variables).
> Also, apply the new environment variables in the existing templates.

### Implementation details

Environment variables files are listed in the table in [the Environment variables section of README.md](../README.md#environment-variables).
Below some detailed info.

#### env-localhost

* No `docker-compose-<...>.yml` to support, because no Docker services, no Docker network.
* CSS's are running locally and can be accessed at `http://localhost:<port>`.
* No SSL certificates involved.

#### env-docker-public

* Service names are set to something else but their domain name, e.g. `css1` for css1, whose baseURL is `https://css1.onto-deside.ilabt.imec.be/`.
* Services can be addressed (and can address each other) using their defined baseURL, from everywhere, **if and only if** an external proxy takes care of this.
* External webclients can work as well.
* Services do not have their own SSL certificates, external certificates must be provided (Let's encrypt is your friend).

#### env-docker-private

* Service names are set to their domain name, e.g. `css1.onto-deside.ilabt.imec.be` for css1, whose baseURL is defined as `https://css1.onto-deside.ilabt.imec.be/`.
* Services can be addressed (and can address each other) using their defined baseURL, inside the default Docker compose network, because it resolves the addresses using the service names.
* Services cannot be addressed from the host using their defined baseURL.
* As a consequence, a Firefox container in the Docker compose network is needed to address webclients and CSS's.
* As a second consequence, webclients must be located in a container inside the Docker compose network.
* Services have their own self-signed SSL certificates, based on a custom certification authority, to be trusted by the Firefox container.

## Templates

A lot of files in this repository have contents that should be configurable, e.g. to adapt the baseURL of one or more Solid pods.
Unfortunately, not all the tools that read these files can read environment variables at run time. In addition, Docker compose files do not support conditionals.

To overcome this:

* files to be adapted have a companion file, whose name ends with the `.template` suffix (e.g. `docker-compose-private.yml.template`, `common/css-01.json.template`);
* the adapted files are now git-ignored (e.g. `docker-compose-private.yml`, `common/css-01.json`);
* the template files use the environment variables, set by sourcing the appropriate environment variables file;
* a script is provided to generate new file contents from the templates.

After changing or adding one or more templates, repeat all build steps.

### Making a new template

Script [create-templates.sh](../scripts/templates/create-templates.sh) creates new templates from existing files in the current working directory and its subdirectories.
Note that it only substitutes the core baseURLs with the corresponding environment variables, which is enough to make templates from queries.

For each new template file:

* remove the original file from version control;
* add the original file to [.gitignore](../.gitignore);
* add the new template file to version control.

### Updating templates

> Some template files have alternatives for the different environment variables files.
> An example: `docker-compose-private.yml.template`, `docker-compose-public.yml.template`.
> When updating one of these files, update the other ones too.

## Webclient Docker image

Note that until [this issue](https://github.com/comunica/jQuery-Widget.js/issues/152) is solved, each `${OD_WEBCLIENT_BASE_URL}` needs a specific `${OD_WEBCLIENT_IMAGE}`.

These images are currently supplied from [this GitHub repository](https://github.com/mvanbrab/jQuery-Widget.js/).

## The modified Generic Data Viewer

This project includes a service based on a modified build of <https://github.com/SolidLabResearch/generic-data-viewer-react-admin>.

### How the modified Generic Data Viewer is built

When following the setup instructions in the [main README](../README.md):

* a clone of that repo is made in `../applied-in-architecture-generic-data-viewer-react-admin`;
* a known good version of it is checked out; the known good version is selected with the `-b` option of the `git clone` command in [this script](../scripts/viewer/build-webclient-contents.sh).
* the software is built in the clone's `main` directory;
* the contents of its `src/config.json` file and its `public` directory are replaced with alternatives found in our directory `actors/viewer/setup`;
* static files are generated from this modified contents and brought back to our directory `actors/viewer/html`, ready for further packaging into a service.

### Using the modified Generic Data Viewer for query development

We can use the modified build of the generic data viewer to develop queries in the context of our project.

This will obviously work in the case of environment variables file *env-localhost*,
but also in the case of *env-docker-public*.
The latter case is interesting to make experiments with data available in the public pods.
Proceed as follows:

* go to `../applied-in-architecture-generic-data-viewer-react-admin/main`;
* modify the configuration file and modify/add queries in the public directory;
* test by running `npm run dev` and browsing the localhost port this command reports.

## Direct access to the file system of a CSS

For development and debugging purposes, access the file system of `css<x>` as follows:

* Localhost setup case
  * All files are located on the local file system:

    ```bash
    cd <project-root>/local-run/data/css<x>
    ls -al
    # etc...
    ```

* Docker based setup cases
  * Real direct access (the difficult way)
    * Execute:

      ```bash
      source <appropriate-environment-variables-file>
      docker compose --profile backend --profile frontend --profile extra-pod exec -it css<x> sh
      cd /data
      ls -al
      # etc...
      exit
      ```

  * Via the volume mapped to the local file system (the easy way)
    * Execute:

      ```bash
      cd <project-root>/docker-run/data/css<x>
      ls -al
      # etc...
      ```

## How to supporting additional use cases

As described in the [main README](../README.md), pod contents for the additional use case can be added, once you have the necessary CSSs running,
by executing [stuff-pods.sh](../scripts/stuff-pods/stuff-pods.sh) from the project root.

These additional use cases often come with additional queries for the viewer.

To support an additional use case, proceed as follows.

### Adapting the data and mapping files

* Obtain data and mapping files and put these in a new subdirectory of `project-root/scripts/stuff-pods`, for example  `project-root/scripts/stuff-pods/example`.
* Cd to `project-root/scripts/stuff-pods/example`.
* The obtained data and mapping files are normally hardcoded for using on the CSSs in the domain `onto-deside.ilabt.imec.be`, so we need to create templates for using these in our various setups:
  * Execute `../../templates/create-templates.sh`.
  * Add all original files that now have a ´*.template` alternative to [.gitignore](../.gitignore).
* Add a script named `stuff-pods.sh` to your directory. Start from script with the same name in a sibling directory and adapt to your needs.
* Modify the script `stuff-pods.sh` in the parent directory, so that it calls your new `stuff-pods.sh`, as is already the case for previous additional use cases.

### Merging viewer files

* Obtain additional queries and other resource files and put them in the `project-root/actors/viewer/setup/public` directory structure.
  Take care not to overwrite existing files.
* Obtain additional contents for the viewer's `config.json`.
  These contents are normally hardcoded for using on the CSSs in the domain `onto-deside.ilabt.imec.be`, so a convenient procedure to merge these contents is:
  * Cd to the project root and execute `source env-docker-public`.
  * Cd to `project-root/actors/viewer/setup/src`.
  * Execute `../../../../scripts/templates/apply-templates.sh`: this makes a `project-root/actors/viewer/setup/src/config.json` suitable for the merge.
  * Now merge the additional contents into `project-root/actors/viewer/setup/src/config.json`.
    Avoid conflicts with existing IDs, e.g. for queries and query groups.
  * Delete (!) the existing `project-root/actors/viewer/setup/src/config.json.template`. Don't worry, a new one will be created below...
* Make new templates where needed:
  * Cd to `project-root/actors/viewer/setup`.
  * Execute `../../../scripts/templates/create-templates.sh`.
  * Add all original files that now have a ´*.template` alternative to [.gitignore](../.gitignore).

### Finally

Execute everything (again) as described in [building and running in the main README](../README.md#building-and-running).
