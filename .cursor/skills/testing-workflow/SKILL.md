---
name: testing-workflow
description: >-
  Decides if tests are required, writes tests for feat/fix/refactor, runs
  unit/integration after changes, and E2E only on request. Detects Vitest, Jest,
  pytest, go test, and optional Postman MCP API checks per sub-project. Use when
  implementing features, fixing bugs, validating API behavior, or before
  commit/PR.
---

# Testing Workflow

## Step 1: Classify the change

| Type | Tests required? | Run before done? |
|------|-----------------|------------------|
| feat / fix / refactor (behavior) | Yes | Yes (unit/integration) |
| docs / style | No | No |
| chore (deps) | No new tests | Yes (existing suite) |
| chore (other) | Usually no | Optional smoke |

Use commit/branch/issue type and file paths to classify.

## Step 2: Detect framework

In the sub-project root (`projects/<name>/`):

| Signal | Framework |
|--------|-------------|
| `vitest.config.*` or `vitest` in devDependencies | Vitest |
| `jest.config.*` or `jest` in devDependencies | Jest |
| `[tool.pytest]` or `pytest.ini` | pytest |
| `go.mod` + `*_test.go` | go test |
| `playwright.config.*` | Playwright (E2E) |
| `cypress.config.*` | Cypress (E2E) |
| Postman collection/workspace use | Postman MCP / Newman (API testing) |

Prefer scripts in `package.json` / `Makefile` / `pyproject.toml`:

- `npm test` / `pnpm test` / `yarn test`
- `npm run test:unit`, `test:integration`
- `pytest`, `go test ./...`
- Postman collection checks (MCP/Newman) when required by request or AC

If no test setup exists and tests are required: suggest copying from `templates/test/` (see [reference.md](reference.md)).

## Step 3: Write tests (feat / fix / refactor)

- Add or update tests **with** implementation (same PR/commit set).
- Cover happy path and important edge cases from issue AC when present.
- Place tests per project convention (`*.test.ts`, `tests/`, `__tests__/`, `test_*.py`).

Do not write tests for exempt types unless the user asks.

## Step 4: Run tests (before delivery)

**Order:** `code-style-workflow` (lint/format) → then tests.

| Stack | Typical command |
|-------|-----------------|
| Vitest / Jest | `npm test` or `npx vitest run` / `npx jest` |
| pytest | `pytest` or `uv run pytest` |
| Go | `go test ./...` |

Run focused tests for large repos when possible (changed packages/paths).

**E2E:** only when user asks ("跑 e2e", "Playwright test") or AC explicitly requires it.

**API checks (Postman MCP):** run when user asks for Postman-based API verification or AC references Postman collection/workspace checks.

## Step 5: Failures

- Fix failures when straightforward.
- If blocked, report what failed and what was not run.
- Do not claim work is complete if required tests fail.

## Step 6: Before commit (user explicitly asks)

Confirm:

1. Lint/format passed (`code-style-workflow`).
2. Required tests passed (this skill).
3. Then proceed with `git-workflow`.

## Step 7: PR

Ensure PR **Testing** section lists commands run. CI must pass per `github-pr`.

More: [reference.md](reference.md)
