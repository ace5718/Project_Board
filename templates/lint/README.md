# Lint & format templates

Copy into **sub-project repo root** (`projects/<name>/`). Do not use as workspace-root config for application code.

| Directory | Use when |
|-----------|----------|
| `biome/` | New JavaScript / TypeScript project |
| `prettier-eslint/` | Project already uses ESLint |
| `ruff/` | Python project |
| `pre-commit/` | Optional git hooks (manual install) |

## Default style

- **JS/TS:** 2 spaces, single quotes, semicolons, line width 100
- **Python:** 4 spaces, line width 88 (Ruff)

Sub-projects may override. See `.cursor/rules/code-style.mdc` and skill `code-style-workflow`.
