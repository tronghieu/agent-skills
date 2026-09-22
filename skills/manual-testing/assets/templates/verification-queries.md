---
title: "Manual Testing — Verification Queries Against <Project>'s Database"
type: reference
status: draft
created: TODO(date)
updated: TODO(date)
related:
  - environment.md
tags: [testing, manual-testing, sql, verification, triangulation]
---

# Verification Queries

The UI is a rendering of the truth, not the truth. These are the read-only queries that
give a second, independent signal — the database itself — for any claim a session makes
about what an action actually did. Column and table names below should be taken directly
from the migration files; if a query in this doc ever stops matching a migration, the
migration wins — fix this doc, don't fix the assumption.

## 1. How to connect

<!-- TODO(confirm): the connection command/string for this project (psql, a wrapper
     script, a GUI) and where its credential comes from — e.g. a CLI status command,
     .env, docker-compose. -->

```bash
TODO(confirm: connection command)
```

**This connection is read-only for a testing session — SELECT only, no exceptions.**
Reason: the local database is _state_, not scratch space. If a session mutates a row to
"help" reproduce something, the next thing anyone observes — including the same
session's own later checks — is partly the tester's doing, not the product's. That
collapses the entire point of using the DB as an independent oracle. If a test needs
different data, drive it through the app (or ask for the project's database reset command), never through a
manual `UPDATE`.

## 2. Schema map

<!-- TODO(confirm): schemas/tables that exist TODAY, taken from migrations — name what
     doesn't exist yet too, so nobody queries for it. -->

| Schema | Tables | Notes |
| --- | --- | --- |
| TODO(confirm) | TODO(confirm) | TODO(confirm) |

## 3. Queries by intent

<!-- Minimum three patterns every adapter needs. Replace the stub SQL with real table and
     column names once the schema map above is filled in. -->

### Newest rows landed ("did my action just land?")

```sql
-- SELECT <columns> FROM <table> ORDER BY created_at DESC LIMIT 5;
```

### Silent-failure oracle (a trigger or derived row that must exist)

```sql
-- SELECT count(*) FROM <derived_table> WHERE <foreign_key> = '<id>';
-- A 0 here after an action that should have populated this row is a real defect,
-- even though nothing on screen would visibly complain.
```

### Tenant isolation probe (only if the product is multi-tenant)

```sql
-- SELECT <tenant_scoping_columns> FROM <membership_table> WHERE <user> = '<outsider account>';
-- Expect only the tenant(s) this account was explicitly given. Any other tenant here
-- is a Critical finding.
```

## 4. Tips

<!-- TODO(confirm): project-specific gotchas — e.g. count-vs-UI comparison, how deletion
     actually works in this schema (soft/hard/status column), any append-only tables. -->
