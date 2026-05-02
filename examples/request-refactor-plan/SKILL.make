---
name: request-refactor-plan
description: Create a detailed refactor plan with tiny commits via user interview, then file it as a GitHub issue. Use when user wants to plan a refactor, create a refactoring RFC, or break a refactor into safe incremental steps.
---

```makefile
# Target: plan — full refactor planning workflow
plan: gather-context explore verify-options interview define-scope check-tests commit-plan file-issue

gather-context:
	? Ask the user for a long, detailed description of the problem they want to solve and any potential ideas for solutions.

explore:
	? Explore the repo to verify their assertions and understand the current state of the codebase.

verify-options:
	? Ask whether they have considered other options, and present other options to them.

interview:
	? Interview the user about the implementation. Be extremely detailed and thorough.

define-scope:
	? Hammer out the exact scope of the implementation. Work out what you plan to change and what you plan not to change.

check-tests:
	? Look in the codebase for test coverage of the relevant area. If there is insufficient test coverage, ask the user what their plans for testing are.

commit-plan:
	? Break the implementation into a plan of tiny commits. Remember Martin Fowler's advice to "make each refactoring step as small as possible, so that you can always see the program working."

file-issue:
	$ Create a GitHub issue with the refactor plan using the <refactor-plan-template> below.
```

<refactor-plan-template>

## Problem Statement

The problem that the developer is facing, from the developer's perspective.

## Solution

The solution to the problem, from the developer's perspective.

## Commits

A LONG, detailed implementation plan. Write the plan in plain English, breaking down the implementation into the tiniest commits possible. Each commit should leave the codebase in a working state.

## Decision Document

A list of implementation decisions that were made. This can include:

- The modules that will be built/modified
- The interfaces of those modules that will be modified
- Technical clarifications from the developer
- Architectural decisions
- Schema changes
- API contracts
- Specific interactions

Do NOT include specific file paths or code snippets. They may end up being outdated very quickly.

## Testing Decisions

A list of testing decisions that were made. Include:

- A description of what makes a good test (only test external behavior, not implementation details)
- Which modules will be tested
- Prior art for the tests (i.e. similar types of tests in the codebase)

</refactor-plan-template>
