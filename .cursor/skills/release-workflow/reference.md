# Release Reference

## SemVer cheat sheet

```
v1.4.2
│ │ └── PATCH — fix, docs, style, chore(deps)
│ └──── MINOR — feat, compatible refactor
└────── MAJOR — breaking (or MINOR while 0.x.x)
```

## `0.x.x` vs stable

| Change | `>=1.0.0` | `0.x.x` |
|--------|-----------|---------|
| New feature | MINOR +1 | MINOR +1 |
| Bug fix | PATCH +1 | PATCH +1 |
| Breaking | MAJOR +1 | MINOR +1 |

Custom `1.0.0` gate: core complete, docs/tests, stable public API.

## Pre-release suffixes

| Stage | Tag example |
|-------|-------------|
| Alpha | `v1.0.0-alpha.1` |
| Beta | `v1.0.0-beta.1` |
| RC | `v1.0.0-rc.1` |
| Stable | `v1.0.0` |

## Tag vs package version

| Context | Format |
|---------|--------|
| `git tag`, `gh release` | `v1.4.2` |
| `package.json` `version` | `1.4.2` |

## Release notes template

Save as `RELEASE_NOTES.md` locally (do not commit unless the repo keeps changelogs in-tree):

```markdown
## v0.8.0 (YYYY-MM-DD)

### Features
- feat(scope): description

### Bug Fixes
- fix(scope): description

### Breaking Changes
- type(scope)!: description

### Chores
- chore(deps): description
```

Automation options (sub-project choice; document in ADR if adopted):

- [release-please](https://github.com/googleapis/release-please)
- [semantic-release](https://github.com/semantic-release/semantic-release)

## Useful commands

```bash
# Latest semver tags
git tag -l 'v*' --sort=-v:refname | head -1

# Commits since tag
git log v0.7.1..HEAD --pretty=format:'%s'

# Dry-run: show tag target
git rev-parse HEAD

# List GitHub releases
gh release list --limit 10
```

## ADR for versioning policy

When the team changes semver rules or `1.0.0` criteria:

```powershell
Copy-Item templates\docs\adr\0000-template.md projects\my-app\docs\adr\0001-semver.md
```

Fill Status, Context, Decision, Consequences per `docs-policy`.

## Copy release rule to a sub-project (optional stricter rules)

```powershell
New-Item -ItemType Directory -Force -Path projects\my-app\.cursor\rules
Copy-Item .cursor\rules\release.mdc projects\my-app\.cursor\rules\release.mdc
```

Then edit overrides (e.g. required RC before `1.0.0`).
