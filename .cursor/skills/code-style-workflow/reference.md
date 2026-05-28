# Code Style Reference

## Copy templates into a new sub-project

### Biome (JS/TS, recommended for new repos)

```powershell
Copy-Item templates\lint\biome\biome.json projects\my-app\biome.json
```

Add to `package.json`:

```json
{
  "scripts": {
    "lint": "biome check .",
    "format": "biome format --write .",
    "check": "biome check --write ."
  },
  "devDependencies": {
    "@biomejs/biome": "^1.9.0"
  }
}
```

Unified script (format + lint in one): `"lint": "biome check --write ."` or `"lint": "biome ci ."`

### ESLint + Prettier (existing ESLint repos)

```powershell
Copy-Item templates\lint\prettier-eslint\prettier.config.mjs projects\my-app\
Copy-Item templates\lint\prettier-eslint\eslint.config.mjs.example projects\my-app\eslint.config.mjs
```

### Ruff (Python)

Merge `templates/lint/ruff/pyproject.toml.snippet` into `projects/my-app/pyproject.toml`.

```powershell
pip install ruff
# or add ruff to [project.optional-dependencies] / dev deps
```

### Pre-commit (optional)

```powershell
cd projects\my-app
pip install pre-commit
Copy-Item ..\..\templates\lint\pre-commit\.pre-commit-config.yaml.example .pre-commit-config.yaml
pre-commit install
```

## Default style values

| Setting | JS/TS | Python |
|---------|-------|--------|
| Indent | 2 spaces | 4 spaces |
| Quotes | single | single |
| Semicolons | always | — |
| Line width | 100 | 88 |

## Detection quick reference

```
biome.json          → Biome
eslint.config.*     → ESLint (+ Prettier if prettier config exists)
pyproject [tool.ruff] → Ruff
```

## package.json lint script examples

**Biome (unified — preferred for 9:C):**

```json
"lint": "biome check --write ."
```

**Separate:**

```json
"format": "biome format --write .",
"lint": "biome check ."
```

**ESLint + Prettier:**

```json
"format": "prettier --write .",
"lint": "eslint ."
```
