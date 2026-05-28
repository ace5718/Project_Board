---
name: ai-execution-workflow
description: >-
  Applies global AI execution boundaries: ask when ambiguous, limit proactive
  high-risk actions, and validate done criteria by change type before handoff.
  Use for implementation tasks across all sub-projects.
---

# AI Execution Workflow

## Step 1: Classify task risk and scope

- Identify if the task touches dependency installation, file deletion, or critical config changes.
- For high-risk actions, request explicit user approval before applying.

## Step 2: Resolve ambiguity early

- If requirement is unclear, ask one focused clarification question.
- If multiple approaches are valid, provide 2-3 options and recommend one.
- If request exceeds current agreed scope, state boundary and wait for confirmation.

## Step 3: Execute with minimal necessary changes

- Create new files only when required to complete requested outcomes.
- Respect project-specific rules under `projects/<name>/.cursor/rules/`.
- Keep edits scoped; avoid unrelated refactors.

## Step 4: Validate done criteria by change type

For `feat` / `fix` / `refactor`:

1. Run lint (`code-style-workflow`).
2. Run required unit/integration tests (`testing-workflow`).
3. Run build when relevant build scripts exist and changes can affect runtime/build output.
4. Run E2E only if user requested or AC requires.

For `docs` / `style` / minor `chore`:

- Run only checks relevant to the modified scope.

## Step 5: Respect explicit-request write policies

- Do not commit/push/create PR/update issue unless user explicitly asks (see git and GitHub workflows).

## Step 6: Final handoff format

- State what changed.
- State what was verified (lint/tests/build).
- State any deferred checks and why.

More: [reference.md](reference.md)
