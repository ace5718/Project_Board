# Pre-commit (optional)

Not installed automatically. Use in a **sub-project** repo after copying the config.

## Setup

```powershell
cd projects\my-app
pip install pre-commit
Copy-Item ..\..\templates\lint\pre-commit\.pre-commit-config.yaml.example .pre-commit-config.yaml
# Edit hooks for Biome vs Ruff vs Prettier
pre-commit install
```

## Biome vs Ruff

- **Biome:** uncomment the `biome-check` hook in `.pre-commit-config.yaml`
- **Ruff:** uncomment the `ruff` hook
- **Prettier + ESLint:** uncomment `prettier` and `eslint` hooks

Run manually: `pre-commit run --all-files`
