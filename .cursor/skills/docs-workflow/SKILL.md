---
name: docs-workflow
description: >-
  Keeps README, API docs, and ADR records synchronized with code changes.
  Enforces required README sections per sub-project and same-PR API doc updates.
  Use when changing setup, endpoints, architecture, or project conventions.
---

# Documentation Workflow

## Step 1: Detect documentation impact

Check whether the change affects:

- setup/run steps
- env keys or configuration flow
- API contracts (request/response/status)
- architecture/toolchain/security decisions

If yes, docs must be updated in the same change set.

## Step 2: README maintenance

For each affected sub-project, ensure `README.md` contains required sections:

1. Project Overview
2. Installation / Setup
3. Run / Start
4. Environment Variables
5. Testing

Headings in English; body can be Traditional Chinese.

## Step 3: API documentation

Default to OpenAPI/Swagger unless project overrides.

- Update API docs when endpoint contract changes.
- Keep docs in `docs/api/` (or linked root `openapi.yaml`).
- Ensure README includes where API docs live.

## Step 4: ADR decision gate

Create/update ADR when change is:

- major architecture change
- breaking API contract
- security strategy change
- primary toolchain change

Use `docs/adr/NNNN-title.md` format.

## Step 5: PR checklist alignment

When applicable, include in PR:

- docs updated
- API docs updated
- ADR added/updated

## Step 6: Keep docs concise and current

- Remove stale instructions and old paths.
- Prefer links over duplicated long explanations.
- Keep examples runnable and consistent with scripts/config.

More: [reference.md](reference.md)
