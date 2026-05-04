---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable GitHub issues using tracer-bullet vertical slices. Use when user wants to convert a plan into issues, create implementation tickets, or break down work into issues.
target: readme gather_context explore draft_slices quiz_user create_issues
---

readme:
	Break a plan into independently-grabbable GitHub issues using vertical slices (tracer bullets).

gather_context: readme
	Work from whatever is already in the conversation context. If the user passes a GitHub issue number or URL as an argument:
	@gh issue view <number> --comments

explore: readme
	?If you have not already explored the codebase, do so to understand the current state of the code.

draft_slices: readme gather_context explore
	Break the plan into tracer bullet issues. Each issue is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.
	Slices may be HITL or AFK. HITL slices require human interaction (architectural decision, design review). AFK slices can be implemented and merged without human interaction. Prefer AFK over HITL where possible.
	Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests). A completed slice is demoable or verifiable on its own. Prefer many thin slices over few thick ones.

quiz_user: draft_slices
	Present the proposed breakdown as a numbered list. For each slice show:
	- Title: short descriptive name
	- Type: HITL / AFK
	- Blocked by: which other slices must complete first
	- User stories covered: which user stories this addresses
	Ask the user: Does the granularity feel right? Are the dependency relationships correct? Should any slices be merged or split further? Are the correct slices marked HITL/AFK?
	Iterate until the user approves the breakdown.

create_issues: quiz_user
	For each approved slice, create a GitHub issue using `gh issue create`. Create issues in dependency order (blockers first) so you can reference real issue numbers in "Blocked by" field. Do NOT close or modify any parent issue.
	@gh issue create --title "<title>" --body "$(cat <<'EOF'
	## Parent
	#<parent-issue-number> (omit if source was not a GitHub issue)

	## What to build
	A concise description of this vertical slice. Describe end-to-end behavior, not layer-by-layer implementation.

	## Acceptance criteria
	- [ ] Criterion 1
	- [ ] Criterion 2

	## Blocked by
	- Blocked by #<issue-number>
	Or "None - can start immediately" if no blockers.
	EOF
	)"
