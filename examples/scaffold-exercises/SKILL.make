---
name: scaffold-exercises
description: Create exercise directory structures with sections, problems, solutions, and explainers that pass linting. Use when user wants to scaffold exercises, create exercise stubs, or set up a new course section.
---

```makefile
# Variables
EXERCISES_DIR = exercises/
LINT_CMD = pnpm ai-hero-cli internal lint

# ── Main entry 
# Scaffold exercise directories from a plan, validate with lint, then commit.
scaffold: parse-plan create-dirs create-readmes lint fix-errors

# ── Reference: naming conventions
naming:
	? Sections: XX-section-name/ inside $(EXERCISES_DIR) (e.g., 01-retrieval-skill-building)
	? Exercises: XX.YY-exercise-name/ inside a section (e.g., 01.03-retrieval-with-bm25)
	? Section number = XX, exercise number = XX.YY
	? Names are dash-case (lowercase, hyphens)

# ── Reference: exercise variants 
variants:
	? Each exercise needs at least one of these subfolders:
	?   - problem/ — student workspace with TODOs
	?   - solution/ — reference implementation
	?   - explainer/ — conceptual material, no TODOs
	? When stubbing, default to explainer/ unless the plan specifies otherwise.

# ── Reference: required files 
required-files:
	? Each subfolder (problem/, solution/, explainer/) needs a readme.md.
	? readme.md must not be empty (even a single title line works) and have no broken links.
	? Stub readmes should have a title and description:
	?   # Exercise Title
	?   Description here
	? If the subfolder has code, it also needs a main.ts (>1 line).
	? For stubs, a readme-only exercise is fine.

# ── Step 1: parse the plan 
parse-plan: naming variants required-files
	? Extract section names, exercise names, and variant types from the plan.

# ── Step 2: create directories 
create-dirs: parse-plan
	@ mkdir -p $(EXERCISES_DIR)/<section>/<exercise>/<variant>

# ── Step 3: create stub readmes 
create-readmes: create-dirs
	? Create one readme.md per variant folder with a title and a description.

# ── Step 4: run lint 
lint: create-readmes
	@ $(LINT_CMD)

# ── Step 5: fix errors until clean 
fix-errors: lint
	? Iterate on lint errors until $(LINT_CMD) passes.

# ── Lint rules reference ─
lint-rules:
	? Each exercise has subfolders (problem/, solution/, explainer/)
	? At least one of problem/, explainer/, or explainer.1/ exists
	? readme.md exists and is non-empty in the primary subfolder
	? No .gitkeep files, no speaker-notes.md files
	? No broken links in readmes, no "pnpm run exercise" commands
	? main.ts required per subfolder unless readme-only

# ── Move/rename exercises 
move:
	@ git mv $(EXERCISES_DIR)/<old-path> $(EXERCISES_DIR)/<new-path>
	? Update the numeric prefix to maintain order.
	@ $(LINT_CMD)
```
