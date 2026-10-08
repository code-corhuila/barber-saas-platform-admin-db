# Changelog

All notable changes to `barber-saas-platform-admin-db` are recorded here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-08

MVP 2 (corte 2): first release of this repository to `main`, promoted from `develop` through `qa`
with `git cherry-pick -x` (norm 10–11).

User stories: code-corhuila/barber-saas-docs#12, code-corhuila/barber-saas-docs#59.

### Added

- **ddl:** create the platform_admin schema and its tables
- **dml:** seed the Basico, Pro and Premium plans
- **dcl:** grant the platform_admin permissions

### Documentation

- **readme:** point the header to Barber Saas and barber-saas-docs
- **readme:** explain the schema and how it is migrated

### Maintenance

- **liquibase:** add the liquibase structure and the migration runner

[2.0.0]: https://github.com/code-corhuila/barber-saas-platform-admin-db/releases/tag/v2.0.0
