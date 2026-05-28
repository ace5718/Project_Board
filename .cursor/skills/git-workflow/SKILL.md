---
name: git-workflow
description: >-
  Drafts and runs git commits using Conventional Commits in the correct repo
  (projects/* or workspace root). Runs git log -5 before messaging. Use when the
  user mentions commit, git, push, amend, or asks to save changes to version
  control.
---

# Git Workflow

## Determine the repo

| Changes in | Work in |
|------------|---------|
| `projects/<name>/...` | `projects/<name>/` |
| `.cursor/`, `scripts/`, `templates/`, root docs | Workspace root |

## Workflow

1. `cd` to the correct repo root.
2. `git status` and `git diff` (and `git diff --staged` if needed).
3. **`git log -5 --oneline`** — match tone and format.
4. Infer **type** from change nature; **scope** from primary paths (see [reference.md](reference.md)).
5. Draft:
   - Subject: `type(scope): subject` (English, imperative, ≤72 chars)
   - Body (English, `-` bullets) when: multiple files, behavior change, or breaking change
6. If an issue applies, include `Fixes #<n>` in the draft.
7. Present the draft to the user. **Do not commit** until they explicitly ask (e.g. "commit", "幫我 commit").
8. On explicit request only:
   - Confirm **lint** (`code-style-workflow`) and **tests** (`testing-workflow`) passed for this change type
   - Stage relevant files (not secrets)
   - `git commit` with the approved message (HEREDOC on Unix; here-string or file on Windows PowerShell)
9. Do not `git push` unless explicitly requested.

## Safety

Never run unless the user explicitly requests: `push --force`, `reset --hard`, `--no-verify`, force push to `main`/`master`.

`git commit --amend` only if: user asked, HEAD is from this session, and branch is not pushed.

## Examples

**Small fix (subject only):**

```
fix(api): handle null user id
```

**With body and issue:**

```
feat(auth): add OAuth callback route

- Add callback handler and state validation
- Update env docs for client id/secret

Fixes #42
```

More: [reference.md](reference.md)
