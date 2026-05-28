# Dependency Management Reference

## Allowed default licenses

- MIT
- BSD (2/3-clause)
- Apache-2.0
- ISC

## Requires explicit review

- GPL
- AGPL
- LGPL

## Example PR note for new dependency

```markdown
### Dependency rationale
- Added `package-x` for OAuth PKCE verification.
- Existing built-in utilities do not provide standards-compliant verifier/challenge flow.
- Impact: server runtime only, no frontend bundle increase.
```

## Lockfile expectations

| Ecosystem | Manifest | Lock file |
|-----------|----------|-----------|
| npm | `package.json` | `package-lock.json` |
| pnpm | `package.json` | `pnpm-lock.yaml` |
| yarn | `package.json` | `yarn.lock` |
| Poetry | `pyproject.toml` | `poetry.lock` |
| uv | `pyproject.toml` | `uv.lock` |

## Dependabot starter

Copy `templates/github/dependabot.yml.example` to:

```text
projects/<name>/.github/dependabot.yml
```

Adjust schedule/groups per repo needs.
