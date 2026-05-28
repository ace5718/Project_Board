---
name: code-style-workflow
description: >-
  Detects Biome, ESLint+Prettier, or Ruff in sub-projects under projects/, runs
  format and lint after code changes (prefer unified lint script when available).
  Use when editing source code, fixing lint errors, or setting up code style in
  a new repo.
---

# Code Style Workflow

## When to run

After completing code changes in a sub-project (`projects/<name>/`) or template files at workspace root — **before** presenting work as done.

## Step 1: Locate project root

`cd` to the repo that owns the changed files (sub-project directory, not workspace root unless only template files changed).

## Step 2: Detect toolchain

| If present | Stack | Config |
|------------|-------|--------|
| `biome.json` | Biome lint + format | `biome.json` |
| `eslint.config.*` or `.eslintrc*` | ESLint (+ Prettier if `prettier.config.*` / `.prettierrc`) | separate Prettier file for format |
| `[tool.ruff]` in `pyproject.toml` | Ruff check + format | `pyproject.toml` |

If none found: tell the user to copy from `templates/lint/` (see [reference.md](reference.md)). Do not skip checks.

## Step 3: Run checks (prefer unified script)

**If** `package.json` has `"lint"` that runs format check + lint (or project documents it):

```bash
npm run lint
# or: pnpm lint / yarn lint
```

**Else** run format write, then lint:

| Stack | Format | Lint |
|-------|--------|------|
| Biome | `npx @biomejs/biome format --write .` | `npx @biomejs/biome check .` |
| Prettier + ESLint | `npx prettier --write "<changed paths or .>"` | `npx eslint .` or `npm run lint` |
| Ruff | `ruff format .` | `ruff check .` |

Prefer formatting only changed files when the change set is small.

## Step 4: Fix or report

- Auto-fix when safe (Biome/Prettier/Ruff fixable rules).
- Re-run until clean or explain remaining errors.
- Optionally use editor diagnostics (ReadLints) as a supplement.

## Step 5: Pre-commit (optional)

Hooks are **not** installed by default. If the user wants hooks, point them to `templates/lint/pre-commit/` and `pre-commit install` in the sub-project.

## Overrides

Respect stricter or different settings in the sub-project's config files. Document exceptions in `projects/<name>/.cursor/rules/code-style.mdc` if needed.

More: [reference.md](reference.md)
