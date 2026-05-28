---
name: project-structure-workflow
description: >-
  Places new files/modules using repo-native structure and naming conventions.
  Uses language defaults when conventions are unclear, applies cautious barrel
  usage, and keeps files under the soft 300-line guideline. Use when adding new
  modules, creating folders, or reorganizing code layout.
---

# Project Structure Workflow

## Step 1: Identify target repo and stack

Work in the owning repo (`projects/<name>/` or workspace root for template-only files).

Detect stack by existing files (e.g. `package.json`, `pyproject.toml`, framework config).

## Step 2: Scan existing structure before creating files

Inspect where similar code already lives:

- Existing features/modules
- Nearby naming style (kebab, PascalCase, snake_case)
- Existing entry points (`index.ts`, `__init__.py`, route registries)

Follow existing structure first; only apply defaults when unclear.

## Step 3: Choose naming

Default naming if no clear local convention:

| Context | File | Folder |
|--------|------|--------|
| JS/TS | `kebab-case` | `kebab-case` |
| React component | `PascalCase.tsx` | `kebab-case` |
| Python | `snake_case.py` | `snake_case` |

For React: file name should match component symbol.

## Step 4: Choose placement

- Put new module next to similar existing module.
- Avoid introducing parallel root-level structures.
- For major/new modules, tell the user placement in one short sentence before edits.

## Step 5: Barrel (`index.ts`) policy

- Default: create barrels only for public module boundaries.
- Avoid deep/chained barrel patterns.
- Respect stricter or different sub-project overrides.

## Step 6: File size guardrail

- Soft limit: 300 lines/file by default.
- Split by responsibility when exceeding limit.
- Keep overrides in sub-project rule files.

## Cross-rule alignment

- Naming and structure should not conflict with `code-style`, `testing`, and import paths.
- If restructuring affects tests, update tests in the same change set.

More examples: [reference.md](reference.md)
