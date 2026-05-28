import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    globals: true,
    environment: 'node',
    include: ['**/*.{test,spec}.{ts,tsx,js,jsx}'],
    coverage: {
      // Sub-project: enable and set thresholds in CI or testing.mdc
      provider: 'v8',
      reporter: ['text', 'html'],
    },
  },
});
