# GitHub PR Reference

## Copy PR template to a sub-project

```powershell
New-Item -ItemType Directory -Force -Path projects\my-app\.github
Copy-Item templates\github\PULL_REQUEST_TEMPLATE.md projects\my-app\.github\PULL_REQUEST_TEMPLATE.md
```

Or repo root: `projects/my-app/PULL_REQUEST_TEMPLATE.md` (also valid on GitHub).

## Body example (繁中正文)

**Title:** `feat(auth): add OAuth callback route`

```markdown
## Summary
新增 OAuth callback，完成登入導回與 state 驗證。

## Changes
- Add `/auth/callback` handler
- Validate `state` against session
- Update `.env.example`

## Testing
- [ ] `npm run lint`
- [ ] `npm test`
- Manual: login with Google sandbox, confirm redirect

## Screenshots / Demo
N/A (backend only)

## Related issues
Fixes #42

## Checklist
- [ ] Lint passed
- [ ] Tests added/updated
- [ ] CI green
```

## UI PR

Replace Screenshots section with images or GIF links; do not use `N/A`.

## gh CLI examples

```powershell
# Draft locally first; then:
gh pr create --base main --title "feat(api): add user validation" --body-file pr-body.md

gh pr checks
gh pr view --web
```

## Sub-project review overrides

In `projects/<name>/.cursor/rules/github-pr.mdc` or README:

```markdown
- Required approvals: 1
- Required reviewers: @team-name
```

Branch protection on GitHub is the source of truth for enforceability.

## Workflow detection

| File | Expect |
|------|--------|
| `.github/workflows/ci.yml` | Read `jobs.*.steps` for lint/test/build |
| No workflows | Run local lint per `code-style`; note CI may be absent |

## Link to other skills

| Step | Skill |
|------|-------|
| Before PR | `code-style-workflow` |
| Commits on branch | `git-workflow` |
| Issue spec | `github-issue-workflow` |
