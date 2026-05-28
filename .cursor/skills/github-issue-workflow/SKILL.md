---
name: github-issue-workflow
description: >-
  Triage whether a GitHub Issue is needed before coding, then draft or create
  specs (Conventional title, five-section body). Reads recent issues for style.
  MCP write only on explicit request. Use when starting features, bugs, refactors,
  or when the user asks to implement, fix, or add something in projects/.
---

# GitHub Issue Workflow

## Spec-first (issue before code)

For features and non-trivial bugs: draft or create an issue with acceptance criteria **before** writing implementation code.

## Step 0: Issue triage (mandatory before product code)

Run **before** editing files under `projects/<name>/` or template paths at workspace root. Announce the result in one line, then follow the branch.

### Decision checklist

1. **Existing issue?** User gave `#n`, issue URL, or "implement #42" → **Use existing** — read it; do not open a duplicate.
2. **New feature or behavior change?** → **Issue needed**
3. **Bug needing steps or acceptance criteria?** → **Issue needed**
4. **Multiple files/modules?** → **Issue needed**
5. **Refactor or breaking API change?** → **Issue needed**
6. **Only typo / single-file trivial / format / comments?** → **Skip issue**
7. **Uncertain?** → **Issue needed** (draft or ask the user)

### Branches

| Outcome | Next step |
|---------|-----------|
| **Use existing #n** | Section C — implement from issue |
| **Issue needed** | Section A — draft (then B only if user asks to create) |
| **Skip issue** | Implement directly; use `git-workflow` for commits; no new issue |

Do not skip triage because the task "sounds small" — if unsure, default to **Issue needed** (draft only).

## Determine the repository

| Work | GitHub repo |
|------|-------------|
| `projects/<name>/` | Sub-project remote |
| Workspace template files | Template repo (workspace root) |

## Workflow

### A. Draft an issue (default)

1. Confirm target repo (owner/name from `git remote` in the correct directory, or ask the user).
2. **Read ~10 recent issues** (GitHub MCP or `gh issue list`) — align title style.
3. Draft:
   - **Title (English):** `type(scope): subject`
   - **Body (sections below; 正文可用繁體中文)**
   - **Labels:** one of `feat`, `fix`, `docs`, `chore` (match type)
4. Show the draft. **Do not create** on GitHub until the user explicitly asks (e.g. "開 issue", "create the issue").

### B. Create issue (explicit request only)

Use GitHub MCP to create the issue with the approved title, body, and labels.

### C. Implement from issue

1. Read the full issue (title, AC checkboxes, out of scope).
2. Implement only in the matching `projects/<name>/` (or root for template work).
3. Follow skill `git-workflow` for commits; include `Fixes #<n>` when appropriate.
4. Prefer closing via **PR merge**, not by calling close via MCP.
5. Do **not** close the issue or check off AC on GitHub unless the user explicitly asks.

## Body template

```markdown
## Summary
（一兩句話）

## Problem / Goal
（為什麼要做）

## Acceptance criteria
- [ ] ...
- [ ] ...

## Out of scope
- ...

## Technical notes
（路徑、API、連結；可省略）
```

## MCP write policy

| Action | Allowed |
|--------|---------|
| List/read issues | Yes |
| Create / update / comment / label / close | Only on explicit user request |

## Handoff to git

When implementation is done and a PR will merge:

- PR description or commit: `Fixes #<number>`
- Do not use MCP to close if merge will auto-close.

More examples: [reference.md](reference.md)
