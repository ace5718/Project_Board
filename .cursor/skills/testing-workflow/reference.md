# Testing Reference

## Copy Vitest starter (new JS/TS)

```powershell
Copy-Item templates\test\vitest\vitest.config.ts projects\my-app\
# Merge templates\test\vitest\package.json.snippet into package.json
```

## Copy pytest snippet (Python)

Merge `templates/test/pytest/pyproject.toml.snippet` into `projects/my-app/pyproject.toml`.

## Sub-project coverage override

`projects/my-app/.cursor/rules/testing.mdc`:

```markdown
## Coverage

- Minimum line coverage: 80% (CI enforced)
- Tool: vitest --coverage
```

## Exempt vs required (quick)

| Commit/branch type | Tests |
|--------------------|-------|
| feat/issue-42-* | Required |
| fix/issue-108-* | Required |
| docs/fix-typo | Exempt |
| chore/bump-deps | No new tests; run CI |

## Command cheat sheet

```bash
# JS/TS
npm test
npx vitest run
npx jest

# Python
pytest
pytest tests/unit -q

# Go
go test ./...

# E2E (on request)
npx playwright test
```

## Pipeline with other skills

```text
issue triage → branch → implement + tests
  → code-style-workflow
  → testing-workflow (unit/integration)
  → git-workflow (on "commit")
  → github-pr-workflow (on "開 PR")
```

## E2E vs Playwright MCP

- **testing-workflow:** run `playwright test` in the repo when asked.
- **Playwright MCP:** browser automation in Cursor; optional for debugging, not a substitute for CI E2E unless the user wants it.
