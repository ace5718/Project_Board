# Test templates

Copy into **sub-project** repos (`projects/<name>/`). Merge snippets into existing config; do not put under `.cursor/`.

| Directory | Stack |
|-----------|--------|
| `vitest/` | New JS/TS (preferred) |
| `jest/` | Existing Jest projects (scripts snippet only) |
| `pytest/` | Python |

E2E: use Playwright (`npx playwright init`) or existing Cypress; optional Playwright MCP in Cursor.

Sub-projects may define coverage % in CI or `.cursor/rules/testing.mdc`.

See rule `testing` and skill `testing-workflow`.
