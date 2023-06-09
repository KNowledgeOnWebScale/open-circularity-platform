# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

### Added

- Integrated testing framework, based on [Solid's](https://solidproject.org/) - [Conformance Test Harness (CTH)](https://github.com/solid-contrib/conformance-test-harness) (internal [issue#3](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/3)). 
- [ACTORS_OVERVIEW.md](ACTORS_OVERVIEW.md): overview of the current actors, including instructions to generate the overview (internal [issue#19](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/19)).
- [PERMISSIONS_OVERVIEW.md](PERMISSIONS_OVERVIEW.md): overview of the currently assigned permissions, including instructions to generate the overview (internal [issue#20](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/20)).
- [TESTING.md](TESTING.md): separate and improved readme for testing (internal [issue#21](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/21) and [issue#22](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/22) and [issue#24](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/24)). 

### Fixed

- Whenever a query fails due to an error, the other queries can now continue processing and their results will be displayed (internal [issue#1](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/1)).
- `**/css-users.json`: webId URL fix (they were missing '/card' -subpath) (internal [issue#4](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/4)).
- YARRRML Parser pulls incorrect rml prefix from prefix.cc (internal [issue#9](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/9)).
- jQuery Webclient logout works again (internal [issue#12](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/12); see also https://github.com/comunica/jQuery-Widget.js/issues/150).

### Changed

- More efficient start_period/interval/retries combination in health checks (internal [issue#13](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/13)).
- [bashlib-build/Dockerfile](bashlib-build/Dockerfile) changed to become stand-alone (internal [issue#14](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/14) and [issue#15](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/15)).
- [scripts/ac/set_perms.sh](scripts/ac/set_perms.sh) cleaned up and improved (internal [issue#16](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/16)).
- Every actor’s pod contents is now put into a '/pod' parent directory (internal [issue#17](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/17)).
- Extended and improved [README.md](README.md) (internal [issue#18](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/18) and [issue#21](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/21)).

### Deleted

- manufacturer1 (internal [issue#6](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/6)).
- wait-for-container.sh (internal [issue#25](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/25)).
