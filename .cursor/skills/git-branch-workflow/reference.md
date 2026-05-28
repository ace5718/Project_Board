# Git Branch Reference

## Naming examples

| Scenario | Branch |
|----------|--------|
| Feature for issue #42 | `feat/issue-42-oauth-login` |
| Bugfix for issue #108 | `fix/issue-108-null-user-id` |
| README typo (skip issue) | `docs/fix-readme-typo` |
| Format only (skip issue) | `chore/format-src-tree` |

## Invalid examples

| Branch | Why |
|--------|-----|
| `feat/oauth-login` | Missing `issue-<n>` when issue is required |
| `fix/issue-42` | Missing slug |
| `feature/42-oauth` | Wrong prefix (`feature` → use `feat`) |

## Detect default branch

```powershell
git symbolic-ref refs/remotes/origin/HEAD
# refs/remotes/origin/main

gh repo view --json defaultBranchRef -q .defaultBranchRef.name
```

## Protected branch override (sub-project)

`projects/my-app/.cursor/rules/git-branches.mdc`:

```markdown
## Extra protected branches

- develop
- staging

No direct push; open PR into these branches from feature branches.
```

## Stale branch workflow (optional)

```powershell
New-Item -ItemType Directory -Force -Path projects\my-app\.github\workflows
Copy-Item templates\github\workflows\stale-branches.yml.example projects\my-app\.github\workflows\stale-branches.yml
```

Runs weekly; lists branches inactive 30+ days in the Actions summary. **Does not delete** branches.

## GitHub settings (manual)

- **Settings → General → Default branch:** `main`
- **Settings → Branches → Branch protection:** require PR for `main`; no direct push
- **Settings → General → Pull Requests:** enable **Delete branch after merge**

## End-to-end

```text
Issue #42
  → feat/issue-42-oauth-login
  → commits (Fixes #42)
  → PR → squash merge
  → delete remote branch
  → git fetch --prune
```
