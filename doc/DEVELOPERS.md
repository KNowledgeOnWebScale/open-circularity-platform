# Developer documentation

## Environment variables

Environment variables files are listed in [the Environment variables section of README.md](../README.md#environment-variables).
Below some additional developer info.

After **changing** an environment variables file or **switching** to a new environment variables file,
close your bash shells and open new ones and in each, execute `source <applicable environment variables file>`.
Next, in one bash shell, delete persisted output of previous runs from any of the involved containers.
These files are git-ignored in the repo, so we can remove them with the following command:
```
for d in actors volumes ; do cd $d ; git ls-files --others --ignored --exclude-standard | xargs -r -n 1 sudo rm -v ; cd .. ; done
```

## Templates

A lot of files in this repository have contents that should be configurable, e.g. to adapt the baseURL of one or more Solid pods.
Unfortunately, not all the tools that read these files can read environment variables at run time. In addition, Docker compose files do not support conditionals.

To overcome this:
- files to be adapted have a companion file, whose name ends with the `.template` suffix (e.g. `docker-compose.yml.template`, `common/css-01.json.template`);
- the original files are now git-ignored (e.g. `docker-compose.yml`, `common/css-01.json`);
- a script is provided to generate new file contents from the templates.

After changing or adding one or more template files, delete persisted output of previous runs from any of the involved containers, as instructed in [section Environment variables](#environment-variables).

Next repeat all steps starting at [section File templates (in README.md)](../README.md#file-templates).

### Making a new template

File [sed-template-maker-baseurls.txt](../scripts/templates/sed-template-maker-baseurls.txt) is an example command file for `sed`, for creating a new template from an existing file.
Note that it only substitutes the core baseURLs with the corresponding environment variables, which is enough to make templates from queries.

For each new template file:
- remove the original file from version control;
- add the original file to [.gitignore](../.gitignore);
- add the new template file to version control. 

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


