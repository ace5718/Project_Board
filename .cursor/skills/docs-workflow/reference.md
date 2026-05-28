# Documentation Reference

## Sub-project README skeleton

```markdown
# Project Name

## Project Overview

## Installation / Setup

## Run / Start

## Environment Variables

See `.env.example`.

## Testing
```

## API docs placement

Recommended:

- `docs/api/openapi.yaml`
- `docs/api/README.md` (optional index)

Alternative:

- `openapi.yaml` at repo root, linked from README.

## ADR template path

- `docs/adr/0000-template.md` (copy then increment)
- Example: `docs/adr/0003-adopt-vitest-for-unit-tests.md`

## ADR status lifecycle

- `proposed` → under discussion
- `accepted` → adopted
- `deprecated` → no longer recommended
- `superseded` → replaced by newer ADR

## PR checklist suggestions

- [ ] docs updated (if applicable)
- [ ] API docs updated (if API changed)
- [ ] ADR added/updated (if major decision)
