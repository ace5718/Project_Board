# GitHub Issue Reference

## Triage examples

| Task | Triage | Reason |
|------|--------|--------|
| Add OAuth login flow | Issue needed | New feature + multiple files |
| Fix typo in README | Skip issue | Single-file trivial |
| "Do #38" | Use existing #38 | User linked issue |
| Rename internal helper in one file | Skip issue | Single-file, no behavior change |
| Change API response shape | Issue needed | Behavior / possible breaking change |
| "Make it faster" (unclear scope) | Issue needed (draft) | Uncertain — spec first |

## Title examples (English)

```
feat(auth): add OAuth login callback
fix(api): return 404 when user not found
docs(readme): add local setup steps
chore(deps): bump eslint to v9
```

## Full body example (繁中正文)

**Title:** `feat(notifications): add email digest for weekly summary`

```markdown
## Summary
新增每週摘要 email，讓使用者收到一週內重要通知彙整。

## Problem / Goal
使用者錯過即時通知，希望有低頻 digest 降低干擾。

## Acceptance criteria
- [ ] 使用者可在設定頁開關 weekly digest
- [ ] 每週一 09:00（使用者時區）寄送一封摘要
- [ ] 摘要內容包含過去 7 天內未讀的重要通知
- [ ] 關閉 digest 後不再寄信

## Out of scope
- 即時推播
- 自訂摘要頻率（每日/每月）

## Technical notes
- 排程：現有 job queue
- 相關路徑：`src/notifications/`
```

## Labels (minimal set)

| Label | When |
|-------|------|
| feat | New capability |
| fix | Bug |
| docs | Documentation |
| chore | Tooling, config, deps |
| refactor | Refactor (optional) |

## Repo placement

| Change location | Open issue on |
|-----------------|---------------|
| `projects/my-app/` | `my-app` repository |
| `.cursor/rules/`, template scripts | Workspace template repository |

## Copy GitHub templates into a sub-project

```powershell
# From workspace root
New-Item -ItemType Directory -Force -Path projects\my-app\.github\ISSUE_TEMPLATE
Copy-Item templates\github\ISSUE_TEMPLATE\* projects\my-app\.github\ISSUE_TEMPLATE\
```

## Implement → close loop

1. Issue `#42` defines AC.
2. Branch + commits in `projects/my-app/`.
3. PR body: `Fixes #42` + summary.
4. After merge: issue closed by GitHub (AI does not call close).

If no PR (rare): user verifies AC, then explicitly asks to close or closes manually.
