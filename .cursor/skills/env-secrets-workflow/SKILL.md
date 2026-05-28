---
name: env-secrets-workflow
description: >-
  Applies env and secret hygiene: keep .env ignored, maintain .env.example,
  block secret leaks in commits/PRs, and use 1Password locally plus GitHub
  Secrets in CI. Use when adding env vars, updating setup docs, or handling
  credentials in code changes.
---

# Env & Secrets Workflow

## Step 1: Detect env impact

Before or during implementation, check if the change:

- Introduces a new environment variable
- Renames/removes an existing env key
- Changes whether a key is required
- Touches auth/credential/provider configuration

If yes, this workflow applies.

## Step 2: Enforce ignore rules

- Ensure real env files are ignored (`.env`, `.env.local`, `.env.*`).
- Keep `.env.example` tracked.
- Never stage or commit real secret files.

## Step 3: Update `.env.example` (same change set)

When env contract changes:

1. Add/update/remove keys in `.env.example`
2. Use safe placeholders only
3. Keep comments concise (required/optional, example format)

## Step 4: Update docs and PR context

- If setup changed, update README/setup docs.
- In PR body, mention env changes under **Changes** or **Technical notes**.

## Step 5: AI secret safety

- Do not read `.env` values by default.
- For debugging, request non-secret checks from user:
  - key exists?
  - value non-empty?
  - expected prefix/format?
- Never echo secrets into chat, commits, PR, or issue comments.

## Step 6: Secret manager split

- Local dev: 1Password (or equivalent)
- CI/CD: GitHub Secrets / Environments

Do not hardcode secrets in code, config, scripts, or workflow YAML.

## Step 7: Before commit / PR

Confirm:

- No secret files staged
- `.env.example` synced when required
- Lint/tests still pass after config updates

More: [reference.md](reference.md)
