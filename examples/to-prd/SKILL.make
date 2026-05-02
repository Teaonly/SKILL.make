---
name: to-prd
description: Turn the current conversation context into a PRD and submit it as a GitHub issue. Use when user wants to create a PRD from the current context.
---

```makefile
# This skill takes the current conversation context and codebase understanding
# and produces a PRD. Do NOT interview the user — just synthesize what you
# already know.

PRD_TEMPLATE = \
  Problem Statement, Solution, User Stories (numbered list: \
  "As an <actor>, I want <feature>, so that <benefit>"), \
  Implementation Decisions (modules, interfaces, architecture, schema, API \
  contracts — NO file paths or code snippets), Testing Decisions (test \
  external behavior only, which modules to test, prior art), \
  Out of Scope, Further Notes.

# ── Targets ──────────────────────────────────────────────────────────

# Main entry point
prd: explore modules submit

# Explore the repo to understand the current state of the codebase
explore:
	? If you haven't already, explore the repository to understand the current state of the codebase. Read relevant source files, configuration, and any existing documentation to build context.

# Sketch out modules and validate with user
modules: explore
	? Based on the codebase understanding, sketch out the major modules you will need to build or modify to complete the implementation. Actively look for opportunities to extract deep modules — modules that encapsulate a lot of functionality in a simple, testable interface which rarely changes.
	? Present the module breakdown to the user and confirm it matches their expectations. Ask the user which modules they want tests written for.

# Write the PRD and submit as a GitHub issue
submit: modules
	? Write the PRD using the following template sections: $(PRD_TEMPLATE). Make user stories extremely extensive, covering all aspects of the feature.
	$ Create a GitHub issue with the PRD content using: gh issue create --title "<descriptive title>" --body "<prd-body>"
```
