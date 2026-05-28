---
name: error-handling-workflow
description: >-
  Applies consistent API error envelopes, status mapping, and safe logging.
  Adds minimum error handling for I/O code and ensures error-path tests for
  feat/fix/refactor changes. Use when implementing handlers, services, and
  external integrations.
---

# Error Handling Workflow

## Step 1: Detect risk points

Identify I/O boundaries and failure points:

- HTTP handlers/controllers
- DB queries/transactions
- External API calls
- File system/network operations

If any are present, error handling is mandatory.

## Step 2: Classify errors

Split into:

- **Expected/domain errors** (validation, not found, conflict, forbidden)
- **Unexpected/system errors** (timeouts, dependency failures, unhandled exceptions)

Do not collapse all errors into generic 500 without classification.

## Step 3: Map to response + status

Use standardized `error.code` and mapped HTTP status (default core mapping from rule `error-handling`).

For API responses:

```json
{
  "error": {
    "code": "SOME_CODE",
    "message": "Safe message",
    "details": {}
  }
}
```

- `message` default English unless project overrides.
- Never expose stack traces or secret internals in client response.

## Step 4: Log safely

- Use logger levels: debug/info/warn/error.
- Avoid `console.log` in production paths.
- Include safe context (operation, request id, module), exclude secrets.

## Step 5: Add tests for error paths

For `feat` / `fix` / `refactor`:

- Add at least one error-path test (e.g., dependency failure, validation fail).
- Keep assertions on status code + error envelope shape/code.

Use `testing-workflow` for command execution.

## Step 6: Validate before handoff

Checklist:

1. No silent catches.
2. Status mapping aligns with rule.
3. Error response format is consistent.
4. Logs are safe.
5. Error-path test exists where required.

More: [reference.md](reference.md)
