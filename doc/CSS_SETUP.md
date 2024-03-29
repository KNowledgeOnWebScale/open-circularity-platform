# Community Solid Server (CSS) configuration

[`/common/css.json`](../common/css.json) is the original CSS configuration,
used for debugging purposes when the Docker Compose infrastructure was being developed.
It disables security settings.
It is valid for CSS version 5.1.

The CSS configuration used by all CSS containers in `docker-compose*.yml`
is controlled by the template [`/common/css-01.json.template`](../common/css-01.json.template).

See also the [documentation on how to configure your CSS server](https://github.com/CommunitySolidServer/CommunitySolidServer).

The template is based on the example configuration generated by the configuration generator:

| configurator versioned URL                                          | settings                                                                        |
|---------------------------------------------------------------------|---------------------------------------------------------------------------------|
| https://communitysolidserver.github.io/configuration-generator/v6/  | [CSS-config-generator-input-for-v6](pdf/CSS-config-generator-input-for-v6.pdf)  |
| https://communitysolidserver.github.io/configuration-generator/v7/ | [CSS-config-generator-input-for-v7](pdf/CSS-config-generator-input-for-v7.pdf) |

