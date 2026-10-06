# barber-saas-platform-admin-db

> platform-admin bounded context: database (schema, seeds, migrations)

Part of the **Barber Saas** distributed system — team `barber-saas`, Grupo 2.
Governance and documentation live in [`barber-saas-docs`](https://github.com/code-corhuila/barber-saas-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `barber-saas-docs`.

---

## BarberSaaS — what this repository is

The `platform_admin` schema of BarberSaaS (06-data/models.md §9), versioned with Liquibase
(ADR-007) and migrated into the single PostgreSQL instance of `barber-saas-infra-postgres` (ADR-011,
Annex J). It has no instance and no volume of its own.

| Changeset | What |
|---|---|
| `ddl-schemas-001` | schema `platform_admin` |
| `ddl-tables-001` | `subscription_plan`: price in cents, barber cap, active flag (FR-024) |
| `ddl-tables-002` | `idempotency_key`: plan creation with `Idempotency-Key` (norm 5.3.8) |
| `dml-upserts-001` | the plans Basico, Pro and Premium, upserted on the name |
| `dcl-roles-001`, `dcl-grants-001` | `platform_admin_reader` / `_writer`; the writer granted to `platform_admin_app` |

Barbershops are not here: they live in `barbershop`, and platform-admin changes them through
barbershop-api's internal operations (`DEC-SHOP-06`). Applied changesets are never edited.

### How to migrate it

From `barber-saas-infra-postgres`: `./scripts/migrate.sh dev` (or `up.sh`, which calls it). Alone:
`docker compose --env-file env/dev.env --profile tooling run --rm platform-admin-db-migrate`.

### How it is tested

CI builds the schema from an empty database, applies again (nothing must run), rolls everything
back and applies once more.
