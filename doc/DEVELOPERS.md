# Developers documentation

## Environment variables

The configuration of this repository is controlled by environment variables, all defined in one file.
Currently, this file is [envvars](../envvars), but other files might contain alternate configurations in the future.

### After changing the environment variables file

Execute (example for file envvars)
```
source envvars
```
again in your bash shell(s) and next follow the same procedure as given below in [After executing apply-templates.sh](#after-executing-apply-templatessh).

## Templates

A lot of files in this repository have contents that should be configurable, e.g. to adapt the baseURL of one or more Solid pods.
Unfortunately, not all the tools that read these files can read environment variables at run time.

To overcome this:
- these file have a companion file, whose name ends with the `.template` suffix (e.g. `docker-compose.yml.template`, `common/css-01.json.template`);
- the original files are now git-ignored (e.g. `docker-compose.yml`, `common/css-01.json`);
- a script is provided to generate new file contents from the templates.

To generate all files from their templates in the entire project:
```
cd <repository-root>
./scripts/templates/apply-templates.sh
```

To only generate all files from their templates in the current directory and below:
```
<repository-root>/scripts/templates/apply-templates.sh
```

### After executing apply-templates.sh

First delete persisted output of previous runs from any of the involved containers, by executing the following commands in directories `actors` and `volumes`:
```
# show git-ignored files - evaluate before going further!!!!
git ls-files --others --ignored --exclude-standard
# remove them, also files created by other users (hence sudo)
git ls-files --others --ignored --exclude-standard | xargs -n 1 sudo rm
```

Then execute again all steps after section [File templates (in README.md)](../README.md#file-templates). 

### Making a new template

File [sed-template-maker-baseurls.txt](../scripts/templates/sed-template-maker-baseurls.txt) is an example command file for `sed`, for creating a new template from an existing file.
Note that it only substitutes the core baseURLs with the corresponding environment variables, which is enough to make templates from queries.

For each new template file:
- remove the original file from version control;
- add the original file to [.gitignore](../.gitignore);
- add the new template file to version control. 

## BaseURLs

The current baseURLs are all of form `https://*.onto-deside.ilabt.imec.be`.
These are the URLs to be used when the Docker network is deployed on the Virtual Wall.
This was achieved by setting the service names in the Docker compose file to the corresponding `*.onto-deside.ilabt.imec.be`.

## Webclient Docker image

Note that until [this issue](https://github.com/comunica/jQuery-Widget.js/issues/152) is solved, each `${OD_WEBCLIENT_BASE_URL}` needs a specific `${OD_WEBCLIENT_IMAGE}`.

These images are currently supplied from [this GitHub repository](https://github.com/mvanbrab/jQuery-Widget.js/).

## Rebuilding the data viewer service

This project includes a service based on <https://github.com/SolidLabResearch/generic-data-viewer-react-admin>.

These contents for this service are built into `actors/viewer/html`, when following the build instructions given in [README.md](README.md).

That build instruction must be repeated when its input has changed.
The input files are:
- `actors/viewer/setup/src/config.json` (the configuration file)
- `actors/viewer/setup/public/**/*` (the public files)
- `scripts/comunica/queries-filtered/*.sparql` (the queries, also used by the webclient)


