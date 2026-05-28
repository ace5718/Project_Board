---
name: dependency-workflow
description: >-
  Applies dependency governance: require rationale for new packages, enforce
  lockfile commits, check license constraints, and follow monthly updates with
  immediate security patches. Use when adding/upgrading/removing dependencies.
---

# Dependency Workflow

## Step 1: Detect dependency change type

Classify change:

- new dependency
- version bump
- removal/replacement
- transitive lockfile refresh only

## Step 2: Enforce rationale for new packages

If adding a package, document in Issue or PR:

1. why needed
2. why alternatives are insufficient
3. impact scope (runtime/build/security)

## Step 3: Lockfile policy

- Ensure lockfile changes are committed with dependency changes.
- For JS sub-projects, avoid mixed package managers/lock files.
- Keep lockfile ownership at sub-project repo level.

## Step 4: License and denylist check

- Validate new dependency license against allowed defaults:
  - MIT, BSD, Apache-2.0, ISC
- Flag GPL/AGPL/LGPL for explicit approval.
- Check package against denylist when defined.

## Step 5: Versioning approach

- Keep manifest ranges (`^` / `~`) unless sub-project requires exact pins.
- Reproducibility comes from committed lockfile.

## Step 6: Update cadence

- Security updates: prioritize immediately.
- Non-security updates: batch monthly when possible.
- Dependabot is default automation path for GitHub repos.

## Step 7: PR checklist alignment

For dependency-related PRs, confirm:

- rationale documented
- lockfile updated
- license policy checked
- tests/lint still pass

More: [reference.md](reference.md)
