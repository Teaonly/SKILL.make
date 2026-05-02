---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable GitHub issues using tracer-bullet vertical slices. Use when user wants to convert a plan into issues, create implementation tickets, or break down work into issues.
---

PARENT_ISSUE ?= $(args)

to-issues: gather-context explore-codebase draft-slices quiz-user create-issues

gather-context:
	? Work from whatever is already in conversation context.
	@ if [ -n "$(PARENT_ISSUE)" ]; then gh issue view $(PARENT_ISSUE) --comments; fi

explore-codebase:
	? If the codebase has not already been explored, explore it to understand the current state of the code.

draft-slices: gather-context explore-codebase
	? Break the plan into tracer bullet issues — thin vertical slices cutting through ALL integration layers end-to-end, NOT horizontal slices of one layer.
	? Mark each slice as HITL (requires human interaction) or AFK (can be implemented and merged autonomously). Prefer AFK over HITL.
	? Each slice must deliver a narrow but COMPLETE path through every layer (schema, API, UI, tests). A completed slice is demoable or verifiable on its own. Prefer many thin slices over few thick ones.

quiz-user: draft-slices
	? Present the proposed breakdown as a numbered list. For each slice show: Title, Type (HITL/AFK), Blocked by, User stories covered.
	? Ask the user: Does the granularity feel right? Are dependency relationships correct? Should any slices be merged or split? Are HITL/AFK markings correct?
	? Iterate until the user approves the breakdown.

create-issues: quiz-user
	? For each approved slice, create a GitHub issue in dependency order (blockers first) so you can reference real issue numbers in "Blocked by".
	@ gh issue create --title "<title>" --body "<body>"
	? Issue body template: Parent (#number if applicable), What to build (end-to-end behavior, not layer-by-layer), Acceptance criteria (checkbox list), Blocked by (issue numbers or "None — can start immediately").
	? Do NOT close or modify any parent issue.
