# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.0] - 2025-05-29

### Added

- Cross-domain evaluation 2025 (internal [issue#64](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/64)).

## Changed

- Upgraded the viewer to [its v2.0.0](https://github.com/SolidLabResearch/miravi-a-linked-data-viewer/releases/tag/v2.0.0) (mind the modified repository name) (internal [issue#65](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/65)).

## [1.0.0] - 2025-02-27

### Changed

- Synchronized evaluation use cases to state on 2025-02-25 (internal [issue#62](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/62)).
- Solid Community Servers configured to use local copies of verifiable credentials related context files (internal [issue#63](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/63)).

## [0.3.2] - 2025-01-06

### Changed

- Upgraded the viewer to [its v1.5.0](https://github.com/SolidLabResearch/generic-data-viewer-react-admin/tree/v1.5.0).
- Synchronized evaluation use cases to state on 2025-01-06 (internal [issue#61](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/61)).

## [0.3.1] - 2024-10-16

### Added

- Queries with indirect sources make use of link traversal capabilities of the viewer (internal [issue#57](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/57)).
- Logged in users can save their custom queries in a pod now (internal [issue#58](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/58)).
- Changed URL composition from `https://<service>.onto-deside.ilabt.imec.be` to `https://onto-deside.ilabt.imec.be/<service>` (internal [issue#60](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/60)).

### Fixed

- Parent container of pod roots is no longer writable by everyone (internal [issue#59](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/59)).

### Changed

- Upgraded the viewer to [its v1.4.1](https://github.com/SolidLabResearch/generic-data-viewer-react-admin/tree/v1.4.1).

## [0.3.0] - 2024-08-08

### Added

- The June 2024 evaluation cases (internal [issue#55](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/55)).
- Templated queries with indirect variables in the *Generic query examples* group and in all *Evaluation June 2024* groups (internal [issue#56](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/56)).

### Fixed

### Changed

- Eased viewing files in pods in containers using volume mapping (internal [issue#52](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/52)).
- Automated stuffing pod contents with verifiable credentials (internal [issue#54](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/54)).
- Upgraded the viewer to [its v1.3.0](https://github.com/SolidLabResearch/generic-data-viewer-react-admin/tree/v1.3.0).

## [0.2.4] - 2024-04-08

### Added

### Fixed

### Changed

- In response to Onto-DESIDE project review:
  - Changed names of environment variable files, docker compose files, setup cases (internal [issue#49](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/49)).
  - Restructed documentation to first explain online resources and next provide separate build instructions per setup case (internal [issue#50](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/50)).

## [0.2.3] - 2024-03-28

### Added

- Integrated upload of data for project demo March 2024 (internal [issue#48](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/48)).

### Fixed

### Changed

## [0.2.2] - 2024-03-21

### Added

- Added extra pods for further developments (internal [issue#44](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/44)).
- Added localhost option (internal [issue#46](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/46)).
- Extra queries in the Generic Data Viewer (internal [issue#47](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/47)).

### Fixed

- Use correct replacement for `{{podBaseUrl}}` in CSS7 (internal [issue#43](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/43)).
- For the online version: documented how to make the Docker compose setup survive a system reboot (internal [issue#45](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/45)).

### Changed

## [0.2.1] - 2024-01-02

### Added

### Fixed

### Changed

- Changed from private CSS image to solidproject/community-server:7 image (internal [issue#32](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/32) and [issue#42](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/42)).

## [0.2.0] - 2023-11-09

### Added

- Added textile use case and visualization with Generic Data Viewer (internal [issue#29](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/29)).
- Added configuration to run with `http://localhost:<portnr>` baseURLs (internal [issue#31](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/31)).
- Added configuration to run behind a proxy (internal [issue#36](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/36)).
- Added documentation topics (internal [issue#40](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/40)).

### Fixed

- Fixed creation of directories that were git-ignored while fixing internal issue#33 above (internal [issue#34](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/34)).
- Removed shebang line from scripts/cert/main.sh.template (internal [issue#38](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/38)).
- Avoided GitHub's download limit for rmlmapper.jar (internal [issue#39](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/39)).
- Fixed a bug that caused all query results to be empty after switching envirnment variables files (internal [issue#41](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/41)).

### Changed

- Reduced the number of files that contain CSS baseURLs and WebIDs (internal [issue#33](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/33)).
- Easy baseURLs changes using environment variables and template files (internal [issue#35](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/35)).

## [0.1.0] - 2023-08-17

### Added

- Integrated testing framework, based on [Solid's](https://solidproject.org/) - [Conformance Test Harness (CTH)](https://github.com/solid-contrib/conformance-test-harness) (internal [issue#3](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/3)).
- Documentation files:
  - [ACTORS_OVERVIEW.md](doc/ACTORS_OVERVIEW.md): overview of the current actors, including instructions to generate the overview (internal [issue#19](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/19)).
  - [PERMISSIONS_OVERVIEW.md](doc/PERMISSIONS_OVERVIEW.md): overview of the currently assigned permissions, including instructions to generate the overview (internal [issue#20](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/20)).
  - [TESTING.md](doc/TESTING.md): separate and improved readme for testing (internal [issue#21](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/21) and [issue#22](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/22) and [issue#24](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/24)). 
  - [CSS_SETUP.md](doc/CSS_SETUP.md): about the setup of Community Solid Servers (CSS) used in the project (internal [issue#26](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/26)).

### Fixed

- Whenever a query fails due to an error, the other queries can now continue processing and their results will be displayed (internal [issue#1](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/1)).
- `**/css-users.json`: webId URL fix (they were missing '/card' -subpath) (internal [issue#4](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/4)).
- YARRRML Parser pulls incorrect rml prefix from prefix.cc (internal [issue#9](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/9)).
- jQuery Webclient logout works again (internal [issue#12](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/12); see also https://github.com/comunica/jQuery-Widget.js/issues/150).

### Changed

- More efficient start_period/interval/retries combination in health checks (internal [issue#13](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/13)).
- `bashlib-build/Dockerfile` changed to become stand-alone (internal [issue#14](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/14) and [issue#15](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/15)).
- `scripts/ac/set_perms.sh` cleaned up and improved (internal [issue#16](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/16)).
- Every actor’s pod contents is now put into a '/pod' parent directory (internal [issue#17](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/17)).
- Extended and improved [README.md](README.md) (internal [issue#18](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/18) and [issue#21](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/21)).

### Deleted

- manufacturer1 (internal [issue#6](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/6)).
- wait-for-container.sh (internal [issue#25](https://gitlab.ilabt.imec.be/KNoWS/projects/onto-deside/architecture/-/issues/25)).

[0.1.0]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.1.0
[0.2.0]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.2.0
[0.2.1]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.2.1
[0.2.2]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.2.2
[0.2.3]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.2.3
[0.2.4]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.2.4
[0.3.0]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.3.0
[0.3.1]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.3.1
[0.3.2]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v0.3.2
[1.0.0]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v1.0.0
[1.1.0]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/releases/tag/v1.0.0
[Unreleased]: https://github.com/KNowledgeOnWebScale/open-circularity-platform/compare/v1.1.0...HEAD
