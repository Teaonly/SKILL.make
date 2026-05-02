---
name: setup-pre-commit
description: Set up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests in the current repo. Use when user wants to add pre-commit hooks, set up Husky, configure lint-staged, or add commit-time formatting/typechecking/testing.
---

# Variables
DEPS = husky lint-staged prettier
PRETTIER_DEFAULTS = { "useTabs": false, "tabWidth": 2, "printWidth": 80, "singleQuote": false, "trailingComma": "es5", "semi": true, "arrowParens": "always" }

# Target: setup — full pre-commit hook setup
setup: detect-pkg install init-husky pre-commit-hook lintstagedrc prettierrc verify commit

detect-pkg:
	? Check for package-lock.json (npm), pnpm-lock.yaml (pnpm), yarn.lock (yarn), bun.lockb (bun). Use whichever is present. Default to npm if unclear.

install:
	? Install $(DEPS) as devDependencies using the detected package manager.

init-husky:
	@ npx husky init

pre-commit-hook:
	? Write .husky/pre-commit with "npx lint-staged". If package.json has a "typecheck" script, add "<pkg-manager> run typecheck". If it has a "test" script, add "<pkg-manager> run test". Replace <pkg-manager> with the detected package manager. Omit lines for missing scripts and inform the user.

lintstagedrc:
	$ Write file .lintstagedrc with content: { "*": "prettier --ignore-unknown --write" }

prettierrc:
	? If no Prettier config file exists, create .prettierrc with: $(PRETTIER_DEFAULTS)

verify:
	? Check .husky/pre-commit exists and is executable, .lintstagedrc exists, package.json has "prepare": "husky", and a prettier config exists. Run npx lint-staged to verify it works.

commit:
	@ git add -A && git commit -m "Add pre-commit hooks (husky + lint-staged + prettier)"
