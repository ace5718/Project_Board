---
name: github-pr-workflow
description: >-
  Drafts pull requests with Conventional titles and six-section bodies, checks
  CI workflows before merge, and uses squash merge guidance. GitHub MCP read
  anytime; create/update/merge only on explicit request. Use for pull requests,
  PR reviews, CI failures on PRs, or after implementing an issue.
---

# GitHub PR Workflow

## Prerequisites

1. Changes committed on a feature branch in the correct repo (`projects/<name>/` or workspace root).
2. Run skills `code-style-workflow` (lint/format) and `testing-workflow` (unit/integration) before opening a PR.
3. If tied to an issue: read issue AC; body must include `Fixes #<n>` when appropriate.

## Step 1: Target repo and checks

- Confirm repo from `git remote` in the project directory.
- List `.github/workflows/` — note jobs (lint, test, build). **Lint** should pass when defined.
- Optional: read PR/check status via GitHub MCP or `gh pr checks`.

## Step 2: Draft PR (default — do not create on GitHub yet)

**Title (English):** `type(scope): subject` — align with main commit; no `#` in title.

**Body** — use English headings; 正文可用繁體中文:

| Section | Content |
|---------|---------|
| Summary | What this PR does |
| Changes | Bullet list of main changes |
| Testing | Commands run, manual steps |
| Screenshots / Demo | Required for UI; else `N/A` |
| Related issues | `Fixes #42` / `Refs #42` |
| Checklist | Lint, tests, CI (see template) |

Review recent merged PRs in the repo for tone if helpful.

## Step 3: Create or update PR (explicit request only)

When the user asks (e.g. "開 PR", "create pull request"):

- Push branch first only if the user asked to push.
- Create PR via GitHub MCP or `gh pr create --title "..." --body "..."`.
- Base branch: usually `main` or repo default — confirm if unsure.

Do **not** request review or merge unless asked.

## Step 4: After PR is open

- Help diagnose CI failures (Actions logs, lint errors).
- Remind: **squash merge**, PR title becomes squash message, delete branch after merge.
- Merge only when user explicitly requests **and** CI is green (and approvals met if required).

## Merge policy reminder

| Item | Value |
|------|-------|
| Merge type | Squash |
| Squash message | PR title |
| Branch | Delete after merge |
| Approvals | 0 default (solo); sub-project may differ |

More: [reference.md](reference.md)
