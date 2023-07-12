# Testing

## Local testing

### Prepare testing

Make sure that the **backend** containers are up and running healthy:

```bash
docker compose --profile backend up --wait
```

Note that the command above may take some time to complete.

Optional: if you're interested in what's happening while the previous command executes, you may open a new terminal window and in it, execute:

```bash
docker compose --profile backend logs -f
```

### Do some tests

To test scenarios between the administrator and all other actors:

```bash
docker compose --profile test up --wait
cd specification-tests && ./run.sh -d . admin-any && cd -
# Ignore the warning 'Network architecture_default  Resource is still in use'.
docker compose --profile test down -t 0
```

To test scenarios between "Lindner Group" and the building owners.

```bash
docker compose --profile test up --wait
cd specification-tests && ./run.sh -d . lindner-building && cd -
# Ignore the warning 'Network architecture_default  Resource is still in use'.
docker compose --profile test down -t 0
```

As illustrated by the previous commands,
the command for running tests has the following form:

```bash
./run.sh -d . <basename environment file>
```

For more details, check out the section [Environment Variables](https://github.com/solid-contrib/conformance-test-harness/blob/main/USAGE.md#3-environment-variables) in the CTH Usage docs.

### Cleanup after testing

When done all testing, stop and remove all **backend** containers:

```bash
docker compose --profile backend down -t 0
```

and also remove the left-over containers from the test harness:

```bash
docker ps -a | awk '/solidproject\/conformance-test-harness/ { print $1 }' | xargs -n 1 docker container rm
```

and also remove the empty directories created by the tests:
```bash
find actors -type d -empty | xargs -n 1 rmdir
```

## CTH Testing Environment

The testing environment is configured in
[`specification-tests/config/application.yaml`](./specification-tests/config/application.yaml).</br>
In this file, 3 important settings can be configured:

1. `subjects` - The location of the file describing test subjects.
   For example, [`test-subjects.ttl`](./specification-tests/test-subjects.ttl).
2. `sources` - The locations of annotated documents that list the test cases to be run.
3. `mappings` - Maps test cases IRIs to a local file system (there can be multiple mappings).

For more details, check out the section [CTH Configuration](https://github.com/solid-contrib/conformance-test-harness/blob/main/USAGE.md#2-cth-configuration) in the CTH Usage docs.

### Subjects

The files referred to in `subjects` are Turtle files which describes the test subject and its capabilities, primarily using EARL and DOAP vocabularies.</br>
For example,

```turtle
<lindner-building>
  a earl:Software, earl:TestSubject ;
  solid-test:skip "alice-admin", "alice-building" , "http-redirect" .
```

The subjects object in the configuration file states in which file the test subjects are defined. These define subjects which will be tested. In our case this is set to test-subjects.ttl

The subjects file gives a description of the “subject” that gets tested. The name however is crucial. Whenever we test, e.g. “css”, CTH will also look for the css.env file. So these names must match.

For more details, check out the section[Test Subject Description](https://github.com/solid-contrib/conformance-test-harness/blob/main/USAGE.md) in the CTH Usage docs.

### Sources

A source is a path to a manifest file where test cases that need to be tested are defined.
For example,
[`./specification-tests/access-control-scenarios/construction/web-access-control-test-manifest.ttl`](./specification-tests/access-control-scenarios/construction/web-access-control-test-manifest.ttl)

The prefixes defined in the manifest file get replaced by the defined `mappings`,
which will be explained in the following subsection.

#### Mappings

Mappings are used to map the IRIs of test cases to a local file system (there can be multiple mappings).
Mappings should be ordered so the most specific is first.
This allows individual files to be mapped
separately from their containing directories.

> The `path` refers to a path within the CTH Docker container.

An example can be found below,
where the prefix will get replaced by `/data` in every file regarded to testing.

```YAML
mappings:
  - prefix: https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture
    path: /data
```
