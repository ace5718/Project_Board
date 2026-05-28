# Git Workflow Reference

## Allowed types

| type | Use for |
|------|---------|
| feat | New feature |
| fix | Bug fix |
| docs | Documentation only |
| style | Formatting, no logic change |
| refactor | Code change, no feature/fix |
| test | Tests |
| chore | Tooling, deps, misc |
| ci | CI/CD config |
| perf | Performance |
| revert | Revert a commit |

## Scope inference

| Changed paths (examples) | scope |
|--------------------------|-------|
| `src/auth/`, `**/auth/**` | `auth` |
| `apps/web/`, `frontend/` | `web` |
| `packages/api/` | `api` |
| `.cursor/`, `scripts/`, `templates/` (root) | `workspace` or `template` |
| Single top-level module folder | folder name |

If unclear, use the narrowest meaningful scope or omit only when the repo consistently omits scopes (check `git log -5`).

## Breaking changes

```
feat(api)!: remove legacy v1 endpoints

BREAKING CHANGE: v1 routes removed; clients must use v2.
```

## Issue linking

| Keyword | Effect on merge |
|---------|-----------------|
| `Fixes #123` | Closes issue |
| `Closes #123` | Closes issue |
| `Refs #123` | Links only, does not close |

Use the issue number from the **same repo** as the commit.

## Windows commit example (PowerShell)

```powershell
git commit -m @"
feat(scope): short subject

- Bullet one
- Bullet two

Fixes #42
"@
```
