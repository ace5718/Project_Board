# Dev Workspace Template

個人開發用 workspace 模板：集中管理 Cursor rules、MCP 設定與腳本；子專案放在 `projects/`，各自維護獨立的 git repo。

## 目錄結構

```text
.
├── .cursor/
│   ├── rules/              # workspace, git, issues, PRs, style, tests, errors, docs, deps, AI
│   ├── skills/             # git/issue/pr/style/test/structure/env/error/docs/deps/AI workflows
│   ├── mcp.json.example
│   └── mcp.json            # 本機（gitignore）
├── templates/
│   ├── github/             # Issue 模板
│   ├── lint/               # Biome / Prettier+ESLint / Ruff / pre-commit 範本
│   ├── test/               # Vitest / Jest / pytest 範本
│   ├── structure/          # React / Python 模組骨架範本
│   ├── env/                # .env.example / ignore 規範範本
│   └── docs/               # README / OpenAPI / ADR 範本
├── projects/
├── projects.list
└── scripts/
    └── clone.ps1
```

## 首次設定

1. 用 **Cursor 開啟此資料夾根目錄**（不要只開子專案）。
2. 設定 MCP 環境變數（見下方「MCP 伺服器」），然後**完全重啟 Cursor**。
3. 若尚無 `.cursor/mcp.json`，可從範本複製：

   ```powershell
   Copy-Item .cursor\mcp.json.example .cursor\mcp.json
   ```

4. 編輯 `projects.list`，加入你的子專案。
5. 執行 clone 腳本：

   ```powershell
   .\scripts\clone.ps1
   ```

## projects.list 格式

```text
# name | local_path | git_url | branch(optional)
my-app | projects/my-app | https://github.com/you/my-app.git | main
```

## MCP 伺服器

已預設六個 MCP（設定在 `.cursor/mcp.json`）：

| 名稱 | 類型 | 說明 |
|------|------|------|
| **github** | 遠端 HTTP | 官方 GitHub MCP（需 PAT） |
| **filesystem** | npx | 讀寫 `${workspaceFolder}` 與 `projects/` |
| **context7** | 遠端 HTTP | 即時函式庫文件（建議設 API key） |
| **postman** | 遠端 HTTP | Postman Full 模式（需 API key） |
| **playwright** | npx | 瀏覽器自動化 / 測試 |
| **docker** | Docker CLI | Docker MCP Gateway（需 Docker Desktop + MCP Toolkit） |

### 環境變數

複製範本後填入金鑰（擇一方式）：

**方式 A — 系統/使用者環境變數（建議）**

在 Windows「環境變數」或 PowerShell Profile 設定：

- `GITHUB_PERSONAL_ACCESS_TOKEN`
- `CONTEXT7_API_KEY`（可選，見 [context7.com/dashboard](https://context7.com/dashboard)）
- `POSTMAN_API_KEY`

**方式 B — 本機檔案**

```powershell
Copy-Item .cursor\mcp.env.example .cursor\mcp.env
# 編輯 .cursor\mcp.env 後，在啟動 Cursor 前載入（或自行加入 Profile）
```

### 前置需求

- **Node.js**（npx）：filesystem、playwright
- **Docker Desktop**：github 若改本地 Docker 版、以及 **docker** MCP gateway
- **Playwright 瀏覽器**（首次使用 playwright 時）：`npx playwright install`

### 驗證

1. Cursor → **Settings → Tools & MCP**，各伺服器應為綠燈。
2. 若 github/postman/context7 失敗，多半是環境變數未設或未重啟 Cursor。
3. **docker** 需在 Docker Desktop 啟用 [MCP Toolkit](https://docs.docker.com/ai/mcp-catalog-and-toolkit/toolkit/)，並在 Toolkit 裡安裝需要的 catalog 伺服器。

### 調整 Postman 模式

在 `mcp.json` 將 `postman.url` 改為：

- `https://mcp.postman.com/minimal` — 精簡
- `https://mcp.postman.com/code` — API 搜尋與程式碼產生
- `https://mcp.postman.com/mcp` — 完整（目前預設）

## 規則分層

| 位置 | 用途 |
|------|------|
| `.cursor/rules/`（此 repo） | 工作區、Git、Branch、Issue、PR、風格、測試、結構、Env/Secrets、錯誤處理、文件、依賴管理、AI 行為 |
| `.cursor/skills/` | `git-workflow`、`git-branch-workflow`、`github-issue-workflow`、`github-pr-workflow`、`code-style-workflow`、`testing-workflow`、`project-structure-workflow`、`env-secrets-workflow`、`error-handling-workflow`、`docs-workflow`、`dependency-workflow`、`ai-execution-workflow` |
| `projects/<name>/.cursor/rules/` | 該專案專用 rule（可覆寫） |
| Cursor User Rules / `~/.cursor/skills` | 個人偏好 |

### Git commit（摘要）

- Conventional Commits：`type(scope): subject`（英文）
- 產訊息前：`git log -5 --oneline`；有 Issue 時 PR/commit 用 `Fixes #n`
- 僅在你明確要求時才 `commit` / `push`

### Branch（摘要）

- 命名：`type/issue-<number>-<slug>`（小改可用 `docs/`、`chore/`、`style/` 免 issue 編號）
- 主線：新 repo 用 `main`；操作前偵測 default branch（相容 `master`）
- **禁止直接 push** 到 `main`/`master`；子專案可額外保護 `develop`、`staging`
- PR merge 後刪 branch；30 天閒置僅提醒（可選 workflow 範本）

### GitHub Issue（摘要）

- **實作前先 triage**：依規則判斷要開 Issue、略過、或沿用既有 `#n`
- 實作前先寫規格；標題英文、body 五區（正文可繁中）
- 產品 issue 在子專案 repo；模板 issue 在根 repo
- GitHub MCP 寫入僅在你明確要求時執行

### 子專案 GitHub 模板

```powershell
New-Item -ItemType Directory -Force -Path projects\my-app\.github\ISSUE_TEMPLATE
Copy-Item templates\github\ISSUE_TEMPLATE\* projects\my-app\.github\ISSUE_TEMPLATE\
Copy-Item templates\github\PULL_REQUEST_TEMPLATE.md projects\my-app\.github\PULL_REQUEST_TEMPLATE.md

# 可選：stale branch 提醒（不自動刪除）
New-Item -ItemType Directory -Force -Path projects\my-app\.github\workflows
Copy-Item templates\github\workflows\stale-branches.yml.example projects\my-app\.github\workflows\stale-branches.yml
```

### Pull Request（摘要）

- 標題：`type(scope): subject`（英文）；Issue 用 body `Fixes #n`，不寫在標題
- Body 六區：Summary、Changes、Testing、Screenshots、Related issues、Checklist（正文可繁中）
- Merge：**Squash**、squash 訊息用 PR 標題、合併後刪 branch
- Review：預設 solo 0 approve；**CI 必須通過**；checks 依 workflow（至少 lint）
- AI：先草稿 PR；**明確要求才**建立/更新 PR；不主動 merge

### 程式碼風格（摘要）

| 語言 | 工具 | 預設 |
|------|------|------|
| JS/TS（新） | Biome lint + format | 2 空格、單引號、分號、行寬 100 |
| JS/TS（既有 ESLint） | ESLint + Prettier | 同上（Prettier） |
| Python | Ruff check + format | 行寬 88 |

- 設定檔在**子專案 repo 根目錄**；從 `templates/lint/` 複製。
- 改完程式後：優先 `npm run lint`（若已含 format），否則 format → lint。
- pre-commit：見 `templates/lint/pre-commit/`（可選，自行 `pre-commit install`）。

```powershell
Copy-Item templates\lint\biome\biome.json projects\my-app\biome.json
```

### 測試（摘要）

| 項目 | 規則 |
|------|------|
| 必測 | `feat` / `fix` / `refactor` 需附單元或整合測試 |
| 免測 | `docs`、`style`；deps bump（CI 過即可） |
| 覆蓋率 % | 子專案自訂，模板不訂全域門檻 |
| 框架 | Vitest / Jest / pytest / go test — **以 repo 為準** |
| API 測試 | 可用 Postman MCP（依需求或 AC 要求） |
| AI | 實作時寫測試；改完跑單元/整合；E2E 僅在你要求時 |
| commit 前 | 你要求 commit 時須 lint + 相關測試通過 |

```powershell
Copy-Item templates\test\vitest\vitest.config.ts projects\my-app\
# 並合併 templates\test\vitest\package.json.snippet
```

### 檔案與資料夾結構（摘要）

| 項目 | 規則 |
|------|------|
| 命名策略 | 依語言預設，並優先遵循 repo 既有慣例 |
| React 元件檔名 | `PascalCase.tsx` |
| 新模組位置 | 放在現有相似模組旁，不新增平行根目錄 |
| `index.ts` | 預設謹慎使用（僅公開 API 邊界） |
| 檔案行數 | 軟限制 300 行（子專案可覆寫） |
| AI 行為 | 建檔前先掃目錄；大改先說明放置位置 |

```powershell
Copy-Item -Recurse templates\structure\react-feature projects\my-app\src\features\auth
Copy-Item -Recurse templates\structure\python-module projects\my-python-app\src\my_app\billing
```

### 環境變數與機密（摘要）

| 項目 | 規則 |
|------|------|
| `.env` 版控 | 一律 ignore（`.env`, `.env.local`, `.env.*`） |
| 範本檔 | 每個子專案維護 `.env.example`（只放 key/安全預設） |
| 更新時機 | env key 新增/改名/刪除時，同 PR 更新 `.env.example` |
| AI 讀取 | 預設禁止讀取 `.env` 真值 |
| 機密來源 | 本機 1Password、CI/CD 用 GitHub Secrets |

```powershell
Copy-Item templates\env\.env.example.template projects\my-app\.env.example
Add-Content projects\my-app\.gitignore "`n# env`n$(Get-Content templates\env\.gitignore.snippet -Raw)"
```

### 錯誤處理（摘要）

| 項目 | 規則 |
|------|------|
| API 錯誤格式 | 預設統一 envelope：`error.code` / `message` / `details`（子專案可覆寫） |
| HTTP 狀態碼 | 預設核心對照表（400/401/403/404/409/422/429/500/503） |
| 錯誤訊息語言 | 預設英文（子專案可覆寫） |
| Log 等級 | `debug` / `info` / `warn` / `error`（子專案可覆寫） |
| production 日誌 | 預設禁止 `console.log`，改用 logger |
| AI 最低標準 | I/O 代碼必加 error handling，且 `feat/fix/refactor` 至少一條錯誤路徑測試 |

### 文件規則（摘要）

| 項目 | 規則 |
|------|------|
| README | 各子專案皆需獨立 README（Overview / Setup / Start / Env / Testing） |
| README 語言 | 英文標題，正文可繁中 |
| API 文件 | 預設 OpenAPI/Swagger；子專案可覆寫為 Postman/混合 |
| 更新時機 | API contract 變更需同 PR 更新文件 |
| ADR | 啟用；重大架構/安全/工具鏈決策需記錄 |
| ADR 位置 | `docs/adr/`（例如 `0001-title.md`） |

```powershell
Copy-Item templates\docs\README.template.md projects\my-app\README.md
New-Item -ItemType Directory -Force -Path projects\my-app\docs\adr
New-Item -ItemType Directory -Force -Path projects\my-app\docs\api
Copy-Item templates\docs\adr\0000-template.md projects\my-app\docs\adr\0000-template.md
Copy-Item templates\docs\api\openapi.yaml projects\my-app\docs\api\openapi.yaml
```

### 依賴管理（摘要）

| 項目 | 規則 |
|------|------|
| 新增套件 | 必須在 PR/Issue 說明理由與影響 |
| 禁用清單 | 模板維護 denylist（子專案可加嚴） |
| License | 預設允許 MIT/BSD/Apache-2.0/ISC；GPL 類需審核 |
| Lock file | 一律進 git，且子專案各自維護 |
| 版本策略 | `^` / `~` range + lock file 固定解析版本 |
| 更新頻率 | 安全更新即時；一般依賴每月更新 |
| 自動化 | 預設使用 Dependabot |

```powershell
New-Item -ItemType Directory -Force -Path projects\my-app\.github
Copy-Item templates\github\dependabot.yml.example projects\my-app\.github\dependabot.yml
```

### AI 行為通用規則（摘要）

| 項目 | 規則 |
|------|------|
| 高風險主動行為 | 安裝套件 / 刪檔 / 改 `package.json`、`tsconfig.json` 需明確同意 |
| 建立新檔 | 僅在完成任務必要時可建立 |
| 需求不明確 | 先問一個關鍵澄清問題 |
| 多種方案 | 列 2-3 個選項並附推薦 |
| 超出範圍 | 先標註邊界，等待確認再繼續 |
| 完成定義 | `feat/fix/refactor`：lint + required tests，必要時 build；E2E 僅在要求或 AC 需要時 |

## Git 注意事項

- **此 repo**：只 commit 模板設定，不包含 `projects/` 下的子專案。
- **子專案**：在 `projects/<name>/` 內各自 `git commit` / `git push`。
