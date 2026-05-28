---
name: git-branch-workflow
description: >-
  Names branches as type/issue-number-slug, detects default branch (main/master),
  avoids direct pushes to protected branches, and aligns with issue triage. Use
  when creating branches, starting work on an issue, or before push/PR.
---

# Git Branch Workflow

## Step 1: Repo and default branch

1. `cd` to `projects/<name>/` (or workspace root for template-only work).
2. Detect default branch before checkout or PR:
   - `git symbolic-ref refs/remotes/origin/HEAD` → `origin/main`, or
   - `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`
3. New repos should use `main`; respect `master` if that is still the remote default.

## Step 2: Issue triage → branch name

Run issue triage (rule `github-issues`) first.

| Triage | Branch pattern |
|--------|----------------|
| Use existing `#n` | `<type>/issue-<n>-<slug>` |
| Issue needed (new) | Create or draft issue first, then `issue-<n>-<slug>` |
| Skip issue | `docs/`, `chore/`, or `style/` + slug only (no issue segment) |

Pick **type** from the change (same as commit type). Pick **slug** from the feature or fix (2–4 words).

**Draft example:** `feat/issue-42-oauth-login`

## Step 3: Create branch (when starting work)

Only when the user asks to start work or explicitly requests a branch:

```bash
git fetch origin
git checkout <default-branch>
git pull
git checkout -b feat/issue-42-oauth-login
```

Do not push to `main` / `master` or other protected branches (rule `git-branches`).

## Step 4: Push feature branch

Push only when the user explicitly requests:

```bash
git push -u origin feat/issue-42-oauth-login
```

## Step 5: After PR merge

- Remote branch should be deleted (GitHub UI or user enabled auto-delete).
- Locally: `git checkout main && git pull && git fetch --prune`

## Protected branches (sub-project override)

Check `projects/<name>/.cursor/rules/git-branches.mdc` for extra protected names (`develop`, `staging`, etc.).

## Handoff

| Next | Skill / rule |
|------|----------------|
| Commits | `git-workflow` |
| PR | `github-pr-workflow` |
| Lint before PR | `code-style-workflow` |

More: [reference.md](reference.md)
