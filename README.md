# SKILL.make: Makefile Styled Skill file.

Specification and reference implementation for Makefile-styled Agent Skills.

## What is this?

SKILL.make brings the declarative, dependency-driven paradigm of Makefiles to the Agent Skills format. It replaces fuzzy prose with structured logic, turning SKILL.md into a reproducible execution graph.

## Why Makefile styled SKILL file?

- **Token Efficient**: Optimized syntax reduces SKILL file size by ~30%, saving costs and context window space.

- **Dependency Resolution**: The harness resolves the DAG (Directed Acyclic Graph) automatically. No more relying on an LLM to "guess" the next logical step.Uses the Target: Dependency + Recipe model to ensure Agents follow a strict execution order without skipping steps.

- **Highly Composable**: Modularize skills by calling targets across different files—just like a professional build system.

- **Auditability and evolution** — Lays the groundwork for auditable and evolvable SKILL implementations.

## Rule Definitions

| Prefix | Type | Description |
| :--- | :--- | :--- |
| **`VAR = val`** | **Variable** | Define constants to reduce repetition. |
| **`@ cmd`** | **Shell** | Direct command-line instructions for execution. |
| **`$ tool`** | **Invocable** | Explicit calls to agent-defined tools/functions. |
| **`? prompt`** | **Reasoning** | Free-form prompts where the Agent decides the action. |
| **`ifeq`** | **Logic** | Conditional branching based on state or env vars. |

## A Simple Example

Below is a typical code-review skill written in SKILL.make format:

````markdown
---
name: code-review
description: A full code review workflow.
---

```makefile
# Variables
CODE_DIR = src/

# Target: review — run a full code review
review: lint test summary

lint:
	@ cd $(CODE_DIR) && eslint . --format json

test:
	@ cd $(CODE_DIR) && npm test

summary: lint test
	? Based on lint errors and test failures, write a review summary.
```

### Addtional info is also OK.
````



## Status

This is a **proof-of-concept** specification. This specification is designed to be compatible with most Agent Harness implementations.

## License

[MIT](LICENSE)
