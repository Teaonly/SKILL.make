---
name: scaffold-exercises
description: Create exercise directory structures with sections, problems, solutions, and explainers that pass linting. Use when user wants to scaffold exercises, create exercise stubs, or set up a new course section.
target: workflow moving example
---

directory_naming:
	Sections: `XX-section-name/` inside `exercises/` (e.g., `01-retrieval-skill-building`)
	Exercises: `XX.YY-exercise-name/` inside a section (e.g., `01.03-retrieval-with-bm25`)
	Section number = `XX`, exercise number = `XX.YY`, names are dash-case (lowercase, hyphens)

variants:
	Each exercise needs at least one subfolder:
	- `problem/` - student workspace with TODOs
	- `solution/` - reference implementation
	- `explainer/` - conceptual material, no TODOs
	Default to `explainer/` unless the plan specifies otherwise.

required_files:
	Each subfolder needs a `readme.md` that is non-empty and has no broken links.
	Stub with a title and description:
	@# Exercise Title
	@Description here
	?If subfolder has code, also needs `main.ts` (>1 line). Stubs can be readme-only.

lint_rules:
	@pnpm ai-hero-cli internal lint
	Checks: subfolders exist per exercise, at least one variant, readme.md non-empty, no .gitkeep, no speaker-notes.md, no broken links, no `pnpm run exercise` in readmes, `main.ts` required unless readme-only

workflow: directory_naming variants required_files lint_rules
	Create exercise directories that pass lint, then commit with `git commit`.
	1. Parse the plan - extract section names, exercise names, and variant types
	2. Create directories - `mkdir -p` for each path
	@mkdir -p exercises/<XX>-<section>/<XX.YY>-<exercise>/<variant>
	3. Create stub readmes - one `readme.md` per variant folder with a title
	4. Run lint to validate
	@pnpm ai-hero-cli internal lint
	5. Fix any errors - iterate until lint passes

moving: directory_naming lint_rules
	Use `git mv` (not `mv`) to rename directories - preserves git history.
	Update the numeric prefix to maintain order, then re-run lint.
	@git mv exercises/<section>/<old>-<name> exercises/<section>/<new>-<name>
	@pnpm ai-hero-cli internal lint

example: directory_naming variants
	Given a plan: "Section 05: Memory Skill Building - 05.01 Intro, 05.02 Short-term (explainer+problem+solution), 05.03 Long-term"
	@mkdir -p exercises/05-memory-skill-building/05.01-introduction-to-memory/explainer
	@mkdir -p exercises/05-memory-skill-building/05.02-short-term-memory/{explainer,problem,solution}
	@mkdir -p exercises/05-memory-skill-building/05.03-long-term-memory/explainer
	Create readme stubs:
	@05.01/.../explainer/readme.md → "# Introduction to Memory"
	@05.02/.../{explainer,problem,solution}/readme.md → "# Short-term Memory"
	@05.03/.../explainer/readme.md → "# Long-term Memory"
