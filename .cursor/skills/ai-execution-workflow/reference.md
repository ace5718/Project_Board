# AI Execution Reference

## Approval-required actions

Require explicit user confirmation before:

- installing dependencies
- deleting files
- editing critical config (e.g. `package.json`, `tsconfig.json`)

## Ambiguity examples

- Unclear requirement:
  - Ask: "這次要先做最小可用版本，還是完整方案？"
- Multiple options:
  - Provide option A/B/C with trade-offs, recommend one.
- Out-of-scope request:
  - Explain boundary, request confirmation to expand scope.

## Done criteria quick matrix

| Change type | Lint | Unit/Integration | Build | E2E |
|-------------|------|------------------|-------|-----|
| feat/fix/refactor | Required | Required | If relevant | On request/AC |
| docs/style/minor chore | Scoped checks | Usually not required | Usually not required | Not required |

## Handoff checklist

- [ ] Scope completed
- [ ] Required validations completed
- [ ] No high-risk action without explicit approval
- [ ] Remaining risks/checks disclosed
