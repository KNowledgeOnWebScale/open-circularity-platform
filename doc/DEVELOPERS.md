# Developer documentation

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
- Service names are set to their domain name, e.g. `css1.onto-deside.ilabt.imec.be` for css1, whose baseURL is defined as `https://css1.onto-deside.ilabt.imec.be/`.
- Services can be addressed (and can address each other) using their defined baseURL, inside the default Docker compose network, because it resolves the addresses using the service names.
- Services cannot be addressed from the host using their defined baseURL.
- As a consequence, a Firefox container in the Docker compose network is needed to address webclients and CSSs.
- As a second consequence, webclients must be located in a container inside the Docker compose network.
- Services have their own self-signed SSL certificates, based on a custom certification authority, to be trusted by the Firefox container.

#### envvars2
- Service names are set to something else but their domain name, e.g. `css1` for css1, whose baseURL is `https://css1.onto-deside.ilabt.imec.be/`.
- Services can be addressed (and can address each other) using their defined baseURL, from everywhere, **if and only if** an external proxy takes care of this.
- As a consequence, there is no need for a Firefox container; the host's local browser will do.
- Webclients are still available in containers inside the Docker compose network.
- External webclients can work as well.
- Services do not have their own SSL certificates, external certificates must be provided (Let's encrypt is your friend).

#### envvars3
- Service names are set to something else but their domain name, e.g. `css1` for css1, whose baseURL is `http://localhost:3001/`.
- Services use the **host** network mode ([which is available on Linux hosts only](https://docs.docker.com/network/network-tutorial-host/#prerequisites)).
- Services can be addressed (and can address each other) using their defined baseURL, from the **host network**.
- As a consequence, there is no need for a Firefox container; the host's local browser will do.
- Webclients are still available in containers inside the Docker compose network.
- External webclients can work as well, **if and only if** they are available from the host network.
- Services do not need SSL certificates. Note that only baseURLs of the format `http://localhost...` can work over http.

This environment is well suited for further development of webclients, using data in pods only available at localhost.

As an example, test this in the `../generic-data-viewer-react-admin` as follows:
```
# we should have that directory already and in it, we should have our input files already, if we followed the procedure in README.md. 
pushd ../generic-data-viewer-react-admin/
# same as npm run dev there, but use a free port (we're using the default port 8080 already):
npx vite --port 8082
# now browse http://localhost:8082 and test here...
# finally, press Ctrl-C and come back:
popd
```

## Templates

A lot of files in this repository have contents that should be configurable, e.g. to adapt the baseURL of one or more Solid pods.
Unfortunately, not all the tools that read these files can read environment variables at run time. In addition, Docker compose files do not support conditionals.

To overcome this:
- files to be adapted have a companion file, whose name ends with the `.template` suffix (e.g. `docker-compose.yml.template`, `common/css-01.json.template`);
- the original files are now git-ignored (e.g. `docker-compose.yml`, `common/css-01.json`);
- the template files use the environment variables, set by sourcing the appropriate environment variables file;
- a script is provided to generate new file contents from the templates.

After changing or adding one or more templates, repeat all steps starting at [section File templates (in README.md)](../README.md#file-templates).

### Making a new template

File [sed-template-maker-baseurls.txt](../scripts/templates/sed-template-maker-baseurls.txt) is an example command file for `sed`, for creating a new template from an existing file.
Note that it only substitutes the core baseURLs with the corresponding environment variables, which is enough to make templates from queries.

For each new template file:
- remove the original file from version control;
- add the original file to [.gitignore](../.gitignore);
- add the new template file to version control. 

### Updating templates

> Some template files have alternatives for the different environment variables files.
> An example: `docker-compose.yml.template`, `docker-compose2.yml.template`, `docker-compose2.yml.template`.
> When updating one of these files, update the other ones too.

## Webclient Docker image

Note that until [this issue](https://github.com/comunica/jQuery-Widget.js/issues/152) is solved, each `${OD_WEBCLIENT_BASE_URL}` needs a specific `${OD_WEBCLIENT_IMAGE}`.

These images are currently supplied from [this GitHub repository](https://github.com/mvanbrab/jQuery-Widget.js/).

## Rebuilding the data viewer service

This project includes a service based on <https://github.com/SolidLabResearch/generic-data-viewer-react-admin>.

These contents for this service are built into `actors/viewer/html`, when following the build instructions given in [the appropriate section in README.md](README.md#building-the-data-viewer-contents).

That build instruction must be repeated when its input has changed.
The input files are:
- `actors/viewer/setup/src/config.json` (the configuration file)
- `actors/viewer/setup/public/**/*` (the public files)
- `scripts/comunica/queries-filtered/*.sparql` (the queries, also used by the webclient)


