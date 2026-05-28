# Project Structure Reference

## Naming quick reference

| Type | Example |
|------|---------|
| JS/TS file | `user-service.ts` |
| JS/TS folder | `auth-flow/` |
| React component | `UserCard.tsx` |
| Python module | `user_service.py` |
| Python package folder | `user_service/` |

## Placement examples

### Frontend feature

```text
src/
  features/
    auth/
      components/
        LoginForm.tsx
      hooks/
        use-auth.ts
      index.ts
```

### Python module

```text
src/
  my_app/
    billing/
      service.py
      models.py
      tests/
```

## Barrel guidance

Good:

- `features/auth/index.ts` exporting stable public API.

Avoid:

- `src/index.ts` re-exporting every nested file through multiple barrel levels.

## 300-line soft limit

If a file grows >300 lines, split by concern:

- UI + hooks
- handlers + validators
- service + repository

## Optional structure templates

Copy from `templates/structure/` when bootstrapping:

```powershell
Copy-Item -Recurse templates\structure\react-feature projects\my-app\src\features\auth
Copy-Item -Recurse templates\structure\python-module projects\my-python-app\src\my_app\billing
```
