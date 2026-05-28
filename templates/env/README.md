# Env templates

Use these templates in sub-project repos for environment variable hygiene.

| File | Use |
|------|-----|
| `.env.example.template` | Copy to `.env.example` and keep synchronized with runtime keys |
| `.gitignore.snippet` | Merge into sub-project `.gitignore` to block local env files |

Rules:

- Real secrets stay in local secret manager (1Password) and GitHub Secrets for CI.
- Never commit `.env` values.
