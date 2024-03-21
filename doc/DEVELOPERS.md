# Developer documentation

* [Environment variables](#environment-variables)
  * [Implementation details](#implementation-details)
    * [envvars](#envvars)
    * [envvars2](#envvars2)
    * [envvars3](#envvars3)
* [Templates](#templates)
  * [Making a new template](#making-a-new-template)
  * [Updating templates](#updating-templates)
* [Webclient Docker image](#webclient-docker-image)
* [The modified data viewer](#the-modified-data-viewer)
  * [How the modified data viewer is built](#how-the-modified-data-viewer-is-built)
  * [Using the modified data viewer for query development](#using-the-modified-data-viewer-for-query-development)

## Environment variables

Environment variables files are listed in [Implementation details below](#implementation-details).

> Note:
> When in a new environment variables file the need appears to **add** one or more environment variables,
> revisit the **existing** environment variable files and sync them (perhaps with a different value for the involved environment variables).
> Also, apply the new environment variables in the existing templates.

### Implementation details

Environment variables files are listed in the table in [the Environment variables section of README.md](../README.md#environment-variables).
Below some detailed info.

#### envvars

* Service names are set to their domain name, e.g. `css1.onto-deside.ilabt.imec.be` for css1, whose baseURL is defined as `https://css1.onto-deside.ilabt.imec.be/`.
* Services can be addressed (and can address each other) using their defined baseURL, inside the default Docker compose network, because it resolves the addresses using the service names.
* Services cannot be addressed from the host using their defined baseURL.
* As a consequence, a Firefox container in the Docker compose network is needed to address webclients and CSS's.
* As a second consequence, webclients must be located in a container inside the Docker compose network.
* Services have their own self-signed SSL certificates, based on a custom certification authority, to be trusted by the Firefox container.

#### envvars2

* Service names are set to something else but their domain name, e.g. `css1` for css1, whose baseURL is `https://css1.onto-deside.ilabt.imec.be/`.
* Services can be addressed (and can address each other) using their defined baseURL, from everywhere, **if and only if** an external proxy takes care of this.
* As a consequence, there is no need for a Firefox container; the host's local browser will do.
* Webclients are still available in containers inside the Docker compose network.
* External webclients can work as well.
* Services do not have their own SSL certificates, external certificates must be provided (Let's encrypt is your friend).

#### envvars3

* No `docker-compose3.yml` to support, because no Docker services, no Docker network
* CSS's are running locally and can be accessed at `http://localhost:<port>`.
* No SSL certificates involved.

## Templates

A lot of files in this repository have contents that should be configurable, e.g. to adapt the baseURL of one or more Solid pods.
Unfortunately, not all the tools that read these files can read environment variables at run time. In addition, Docker compose files do not support conditionals.

To overcome this:

* files to be adapted have a companion file, whose name ends with the `.template` suffix (e.g. `docker-compose.yml.template`, `common/css-01.json.template`);
* the original files are now git-ignored (e.g. `docker-compose.yml`, `common/css-01.json`);
* the template files use the environment variables, set by sourcing the appropriate environment variables file;
* a script is provided to generate new file contents from the templates.

After changing or adding one or more templates, repeat all steps starting at [section File templates (in README.md)](../README.md#file-templates).

### Making a new template

File [sed-template-maker-baseurls.txt](../scripts/templates/sed-template-maker-baseurls.txt) is an example command file for `sed`, for creating a new template from an existing file.
Note that it only substitutes the core baseURLs with the corresponding environment variables, which is enough to make templates from queries.

For each new template file:

* remove the original file from version control;
* add the original file to [.gitignore](../.gitignore);
* add the new template file to version control.

### Updating templates

> Some template files have alternatives for the different environment variables files.
> An example: `docker-compose.yml.template`, `docker-compose2.yml.template`, `docker-compose2.yml.template`.
> When updating one of these files, update the other ones too.

## Webclient Docker image

Note that until [this issue](https://github.com/comunica/jQuery-Widget.js/issues/152) is solved, each `${OD_WEBCLIENT_BASE_URL}` needs a specific `${OD_WEBCLIENT_IMAGE}`.

These images are currently supplied from [this GitHub repository](https://github.com/mvanbrab/jQuery-Widget.js/).

## The modified data viewer

This project includes a service based on a modified build of <https://github.com/SolidLabResearch/generic-data-viewer-react-admin>.

### How the modified data viewer is built

When following the setup instruction in the [main README](../README.md)

* a clone of that repo is made in `../applied-in-architecture-generic-data-viewer-react-admin`;
* a known good version of it is checked out;
* the software is built;
* the contents of its `src/config.json` file and its `public` directory are replaced with alternatives found in our directory `actors/viewer/setup`;
* static files are generated from this modified contents and brought back to our directory `actors/viewer/html`, ready for further packaging into a service.

### Using the modified data viewer for query development

We can use the modified build of the data viewer to develop queries in the context of our project.

This will obviously work in the case of environment variables file *envvars3* ("Local development"),
but also in the case of *envvars2* ("Public deployment").
The latter case is interesting to make experiments with data available in the public pods.
Proceed as follows:

* go to `../applied-in-architecture-generic-data-viewer-react-admin`;
* modify the configuration file and modifiy/add queries in the public directory;
* test by running `npm run dev` and browsing the localhost port this command reports.
