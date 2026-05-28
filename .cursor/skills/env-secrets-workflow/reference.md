# Env & Secrets Reference

## `.env.example` template pattern

```dotenv
# Required
DATABASE_URL=
JWT_SECRET=

# Optional
REDIS_URL=
```

Guidelines:

- Keys only, no real values
- Keep naming consistent with runtime code
- Remove deprecated keys promptly

## Suggested ignore patterns (sub-project)

```gitignore
.env
.env.local
.env.*
!.env.example
```

## PR checklist addition

- [ ] `.env.example` updated if env keys changed

## CI secret usage (GitHub Actions)

```yaml
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

Never print secret values in logs.

## Local secret storage

- Store real values in 1Password
- Copy required keys into local `.env` only when needed
- Rotate/revoke immediately if a leak is suspected
