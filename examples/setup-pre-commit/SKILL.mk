---
name: setup-pre-commit
description: Set up Husky pre-commit hooks with lint-staged (Prettier), type checking, and tests in the current repo. Use when user wants to add pre-commit hooks, set up Husky, configure lint-staged, or add commit-time formatting/typechecking/testing.
target: readme detect_pkg_manager install_deps init_husky create_pre_commit create_lintstagedrc create_prettierrc verify commit
---

readme:
    Sets up a Husky pre-commit hook with:
    - **Husky** pre-commit hook
    - **lint-staged** running Prettier on all staged files
    - **Prettier** config (if missing)
    - **typecheck** and **test** scripts in the pre-commit hook
    Notes:
    - Husky v9+ doesn't need shebangs in hook files
    - `prettier --ignore-unknown` skips files Prettier can't parse (images, etc.)
    - The pre-commit runs lint-staged first (fast, staged-only), then full typecheck and tests

detect_pkg_manager:
    $Check for `package-lock.json` (npm), `pnpm-lock.yaml` (pnpm), `yarn.lock` (yarn), `bun.lockb` (bun). Use whichever is present. Default to npm if unclear.

install_deps: detect_pkg_manager
    @Install as devDependencies:
    @husky lint-staged prettier

init_husky: install_deps
    @npx husky init
    This creates `.husky/` dir and adds `prepare: "husky"` to package.json.

create_pre_commit: init_husky
    Write `.husky/pre-commit` (no shebang needed for Husky v9+):
    @npx lint-staged
    @npm run typecheck
    @npm run test
    Adapt: Replace `npm` with detected package manager. If repo has no `typecheck` or `test` script in package.json, omit those lines and tell the user.

create_lintstagedrc: install_deps
    Create `.lintstagedrc`:
    ```json
    {
      "*": "prettier --ignore-unknown --write"
    }
    ```

create_prettierrc: install_deps
    ?Only create if no Prettier config exists. Use these defaults:
    ```json
    {
      "useTabs": false,
      "tabWidth": 2,
      "printWidth": 80,
      "singleQuote": false,
      "trailingComma": "es5",
      "semi": true,
      "arrowParens": "always"
    }
    ```

verify: create_pre_commit create_lintstagedrc create_prettierrc
    $Check `.husky/pre-commit` exists and is executable
    $Check `.lintstagedrc` exists
    $Check `prepare` script in package.json is `"husky"`
    $Check prettier config exists
    @Run `npx lint-staged` to verify it works

commit: verify
    Stage all changed/created files and commit with message:
    @git commit -m "Add pre-commit hooks (husky + lint-staged + prettier)"
    This will run through the new pre-commit hooks — a good smoke test that everything works.
