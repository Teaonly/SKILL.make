---
name: triage-issue
description: Triage a bug or issue by exploring the codebase to find root cause, then create a GitHub issue with a TDD-based fix plan. Use when user reports a bug, wants to file an issue, mentions "triage", or wants to investigate and plan a fix for a problem.
---

# This is a mostly hands-off workflow — minimize questions to the user.

triage: create-issue

capture:
	? Get a brief description of the issue from the user. If they haven't provided one, ask ONE question: "What's the problem you're seeing?"
	? Do NOT ask follow-up questions yet. Start investigating immediately.

explore: capture
	$ Agent(subagent_type=Explore) Deeply investigate the codebase to find: where the bug manifests (entry points, UI, API responses), what code path is involved, why it fails (root cause), what related code exists.
	? Look at: related source files and dependencies, existing tests (tested/missing), recent changes to affected files (git log on relevant files), error handling in the code path, similar patterns elsewhere that work correctly.

diagnose: explore
	? Determine: the minimal change needed to fix root cause, which modules/interfaces are affected, what behaviors need test verification, whether this is a regression/missing-feature/design-flaw.

tdd-plan: diagnose
	? Create a concrete ordered list of RED-GREEN cycles. Each cycle is one vertical slice: RED describes a test capturing broken/missing behavior, GREEN describes minimal code change to pass.
	? Tests verify behavior through public interfaces not implementation details. One test at a time, vertical slices (NOT all tests first then all code). Each test should survive internal refactors. Include a final refactor step if needed.
	? Durability: only suggest fixes that survive radical codebase changes. Describe behaviors and contracts not internal structure. Tests assert observable outcomes (API responses, UI state, user-visible effects) not internal state. A good suggestion reads like a spec; a bad one reads like a diff.

create-issue: tdd-plan
	@ gh issue create --body "$(TEMPLATE)"
	? Do NOT ask the user to review before creating — just create and share the URL.
	? After creating, print the issue URL and a one-line summary of the root cause.

TEMPLATE = \
## Problem\n\
\n\
- What happens (actual behavior)\n\
- What should happen (expected behavior)\n\
- How to reproduce (if applicable)\n\
\n\
## Root Cause Analysis\n\
\n\
- The code path involved\n\
- Why the current code fails\n\
- Any contributing factors\n\
\n\
Do NOT include specific file paths, line numbers, or implementation details that couple to current code layout. Describe modules, behaviors, and contracts instead.\n\
\n\
## TDD Fix Plan\n\
\n\
1. **RED**: Write a test that [describes expected behavior]\n\
   **GREEN**: [Minimal change to make it pass]\n\
\n\
2. **RED**: Write a test that [describes next behavior]\n\
   **GREEN**: [Minimal change to make it pass]\n\
\n\
...\n\
\n\
**REFACTOR**: [Any cleanup needed after all tests pass]\n\
\n\
## Acceptance Criteria\n\
\n\
- [ ] Criterion 1\n\
- [ ] Criterion 2\n\
- [ ] All new tests pass\n\
- [ ] Existing tests still pass
