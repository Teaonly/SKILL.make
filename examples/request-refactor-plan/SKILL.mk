---
name: request-refactor-plan
description: Create a detailed refactor plan with tiny commits via user interview, then file it as a GitHub issue. Use when user wants to plan a refactor, create a refactoring RFC, or break a refactor into safe incremental steps.
target: interview explore options scope test_coverage commits issue
---

interview:
	This skill will be invoked when the user wants to create a refactor request. You may skip steps if you don't consider them necessary.
	?Ask the user for a long, detailed description of the problem they want to solve and any potential ideas for solutions.
	?Interview the user about the implementation. Be extremely detailed and thorough.

explore: interview
	@Explore the repo to verify their assertions and understand the current state of the codebase.

options: explore
	?Ask whether they have considered other options, and present other options to them.

scope: options
	?Hammer out the exact scope of the implementation. Work out what you plan to change and what you plan not to change.

test_coverage: scope
	@Look in the codebase to check for test coverage of this area of the codebase.
	?If there is insufficient test coverage, ask the user what their plans for testing are.

commits: test_coverage
	@Break the implementation into a plan of tiny commits. Remember Martin Fowler's advice to "make each refactoring step as small as possible, so that you can always see the program working."

issue: commits template
	@Create a GitHub issue with the refactor plan using the template below.

template:
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

	## Out of Scope
	A description of the things that are out of scope for this refactor.

	## Further Notes (optional)
	Any further notes about the refactor.
