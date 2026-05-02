---
name: qa
description: Interactive QA session where user reports bugs or issues conversationally, and the agent files GitHub issues. Explores the codebase in the background for context and domain language. Use when user wants to report bugs, do QA, file issues conversationally, or mentions "QA session".
---

```makefile
# Variables
MAX_CLARIFY_QUESTIONS = 3

# ── Main entry ──────────────────────────────────────────
# Run an interactive QA session. The user describes problems they're
# encountering. You clarify, explore the codebase for context, and
# file GitHub issues that are durable, user-focused, and use the
# project's domain language.

qa: listen explore assess file continue

# ── Listen and lightly clarify ──────────────────────────
listen:
	? Let the user describe the problem in their own words.
	? Ask at most $(MAX_CLARIFY_QUESTIONS) short clarifying questions focused on:
	?   - What they expected vs what actually happened
	?   - Steps to reproduce (if not obvious)
	?   - Whether it's consistent or intermittent
	? Do NOT over-interview. If the description is clear enough to file, move on.

# ── Explore the codebase in the background ──────────────
explore:
	$ Agent(subagent_type=Explore, run_in_background=true)
	? While talking to the user, explore the relevant area to:
	?   - Learn the domain language used in that area (check UBIQUITOUS_LANGUAGE.md)
	?   - Understand what the feature is supposed to do
	?   - Identify the user-facing behavior boundary
	? The goal is NOT to find a fix — it's to gather context for writing a better issue.
	? The issue itself should NOT reference specific files, line numbers, or internal implementation details.

# ── Assess scope ────────────────────────────────────────
assess:
	? Before filing, decide whether this is a single issue or needs to be broken down into multiple issues.
	? Break down when:
	?   - The fix spans multiple independent areas
	?   - There are clearly separable concerns that different people could work on in parallel
	?   - The user describes something with multiple distinct failure modes or symptoms
	? Keep as a single issue when:
	?   - It's one behavior that's wrong in one place
	?   - The symptoms are all caused by the same root behavior

# ── File the GitHub issue(s) ───────────────────────────
file: assess
	@ gh issue create
	? Create issues without asking the user to review first — just file and share URLs.
	? Issues must be durable — they should still make sense after major refactors.
	? Write from the user's perspective.

	ifeq ($(SCOPE), single)
		? Use this template:
		? ## What happened
		? [Describe the actual behavior the user experienced, in plain language]
		? ## What I expected
		? [Describe the expected behavior]
		? ## Steps to reproduce
		? 1. [Concrete, numbered steps a developer can follow]
		? 2. [Use domain terms from the codebase, not internal module names]
		? 3. [Include relevant inputs, flags, or configuration]
		? ## Additional context
		? [Any extra observations from the user or from codebase exploration that help frame the issue]
	endif

	ifeq ($(SCOPE), breakdown)
		? Create issues in dependency order (blockers first) so you can reference real issue numbers.
		? Use this template for each sub-issue:
		? ## Parent issue
		? #<parent-issue-number> or "Reported during QA session"
		? ## What's wrong
		? [Describe this specific behavior problem — just this slice, not the whole report]
		? ## What I expected
		? [Expected behavior for this specific slice]
		? ## Steps to reproduce
		? 1. [Steps specific to THIS issue]
		? ## Blocked by
		? - #<issue-number> if this issue can't be fixed until another is resolved
		? Or "None — can start immediately" if no blockers.
		? ## Additional context
		? [Any extra observations relevant to this slice]
		? Prefer many thin issues over few thick ones — each independently fixable and verifiable.
		? Mark blocking relationships honestly.
		? Create issues in dependency order to reference real issue numbers in "Blocked by".
		? Maximize parallelism — multiple people (or agents) can grab different issues simultaneously.
	endif

	? Rules for all issue bodies:
	?   - No file paths or line numbers — these go stale

# ── Continue the session ───────────────────────────────
continue:
	? Keep going until the user says they're done. Each issue is independent — don't batch them.
```
