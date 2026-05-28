# Error Handling Reference

## Example API error response

```json
{
  "error": {
    "code": "USER_NOT_FOUND",
    "message": "User not found",
    "details": {
      "userId": "..."
    }
  }
}
```

## Status mapping quick table

| Case | Status |
|------|--------|
| Invalid payload | 400 |
| Unauthorized | 401 |
| Forbidden | 403 |
| Not found | 404 |
| Conflict | 409 |
| Validation error | 422 |
| Rate limit | 429 |
| Internal error | 500 |
| Dependency outage | 503 |

## Logging do/don't

Do:

- `logger.warn('rate limit exceeded', { requestId, route })`
- `logger.error('db query failed', { requestId, operation, errorCode })`

Don't:

- log raw `Authorization` headers
- log plaintext passwords/tokens
- send stack traces in API response

## Error-path test examples

- API returns `404` + `error.code=USER_NOT_FOUND` when repo returns null.
- API returns `503` when upstream timeout occurs.
- Validation returns `422` with field details.
