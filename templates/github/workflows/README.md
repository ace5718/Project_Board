# GitHub Actions templates (optional)

Copy into `projects/<name>/.github/workflows/` and rename (remove `.example`).

| File | Purpose |
|------|---------|
| `stale-branches.yml.example` | Weekly report of branches inactive 30+ days (no auto-delete) |

Enable branch protection and “Delete branch after merge” in GitHub repo settings separately. See rule `git-branches`.
