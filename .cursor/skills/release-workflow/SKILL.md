---
name: release-workflow
description: >-
  Plans SemVer bumps from Conventional Commits, drafts GitHub Release notes and
  tag names, and creates tags/releases only on explicit request. Use when the
  user asks to release, version, tag, changelog, or bump MAJOR/MINOR/PATCH.
---

# Release Workflow

## Prerequisites

1. Work in the **correct repo** (`projects/<name>/` or workspace root) — see rule `release`.
2. Default branch is up to date; latest changes merged via PR (squash) when applicable.
3. Lint and tests green for the release commit (see `code-style-workflow`, `testing-workflow`).

## Step 1: Discover current version

```bash
cd projects/<name>   # or workspace root
git fetch --tags
git tag -l 'v*' --sort=-v:refname | head -5
```

If no tags yet, treat next as `v0.1.0` or ask the user for the starting version.

## Step 2: Commits since last tag

```bash
LAST=v0.7.1   # replace with latest tag or use origin/main only
git log "${LAST}..HEAD" --oneline
```

Use **squash PR titles** on `main` as the changelog source (rule `github-pr`).

## Step 3: Recommend bump

Apply rule `release` tables:

| Signals in range | Suggested bump |
|------------------|----------------|
| Only `fix`, `docs`, `style`, `chore(deps)` | PATCH |
| Any `feat` or non-breaking `refactor` | MINOR |
| `!` in type or `BREAKING CHANGE` in body | MAJOR (or MINOR if still `0.x.x`) |

Present: current tag → proposed tag, one-line rationale, and grouped draft release notes (see [reference.md](reference.md)).

**Stop** — wait for user confirmation before any tag or `gh release` command.

## Step 4: Draft release notes

Use English section headings; body may be 繁體中文. Include date and version in title:

```markdown
## v0.8.0 (2026-06-04)

### Features
- feat(auth): add OAuth login

### Bug Fixes
- fix(api): handle null user id

### Breaking Changes
- feat(api)!: rename /users/me to /users/profile

### Chores
- chore(deps): bump lodash
```

Align manifest `version` (no `v`) when the sub-project ships npm/crates/etc.

## Step 5: Create tag & GitHub Release (explicit request only)

When the user asks (e.g. "打 tag", "發佈 v0.8.0", "create release"):

1. Confirm target **commit SHA** on default branch (`git rev-parse HEAD`).
2. Annotated tag (recommended):

```bash
git tag -a v0.8.0 -m "v0.8.0"
git push origin v0.8.0
```

3. GitHub Release:

```bash
gh release create v0.8.0 --title "v0.8.0" --notes-file /path/to/notes.md
```

Or paste notes via `--notes "$(cat <<'EOF' ... EOF)"`.

Do **not** `git push --force` tags. Do **not** delete or retag published versions unless the user explicitly accepts recovery steps (prefer a new PATCH instead).

## Step 6: Sub-project overrides

- Check `projects/<name>/.cursor/rules/` for stricter release rules.
- Record **major** versioning policy changes in `docs/adr/` (copy from `templates/docs/adr/`).

## Alignment checklist

| Related rule/skill | Link |
|--------------------|------|
| Conventional Commits | `git-commits`, `git-workflow` |
| Squash merge → changelog | `github-pr`, `github-pr-workflow` |
| Breaking changes | `!` / `BREAKING CHANGE` → bump |
| ADR | `docs-policy`, `docs-workflow` |

More: [reference.md](reference.md)
