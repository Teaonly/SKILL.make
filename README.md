# SKILL.make: Makefile Styled Skill file.

Specification and reference implementation for Makefile-styled Agent Skills.

## What is this?

SKILL.make brings the declarative, dependency-driven paradigm of Makefiles to the Agent Skills format. It replaces fuzzy prose with structured logic, turning SKILL.md into a reproducible execution graph.

## Why Makefile styled SKILL file?

- **Token Efficient**: Optimized syntax reduces SKILL file size by ~15%, saving costs and context window space. With manual optimization, context size can be reduced by more than 30%.

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
| **`multi-line string`** | **Code snippet** | Define code snippets using multi-line strings in Makefile syntax. |


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

## Format Comparison

We tested a complete SKILL collection (from the well-known "Skills for Real Engineers" — https://github.com/mattpocock/skills) using the Makefile format. It not only improves logical structure and readability, but more importantly, these SKILL.make files are well-suited for auditing (git tracking, invocation statistics) and lay a solid foundation for Evolution Engineering.

You can use `convert.sh` to reproduce this conversion. The comparison statistics are as follows:

```txt
File                                       SKILL.md SKILL.make   Change
---------------------------------------- ---------- ---------- --------
caveman                                        1916       1714     -10%
design-an-interface                            3366       2789     -17%
domain-model                                   3512       3376      -3%
edit-article                                    721        692      -4%
git-guardrails-claude-code                     2312       1861     -19%
github-triage                                 10089       8697     -13%
improve-codebase-architecture                  5509       4913     -10%
migrate-to-shoehorn                            2795       1328     -52%
obsidian-vault                                 1511       1233     -18%
qa                                             4965       4781      -3%
request-refactor-plan                          2711       2626      -3%
scaffold-exercises                             3589       2744     -23%
setup-pre-commit                               2261       1703     -24%
tdd                                            4211       3212     -23%
to-issues                                      2737       2027     -25%
to-prd                                         2460       2092     -14%
triage-issue                                   3783       3160     -16%
ubiquitous-language                            4890       4560      -6%
write-a-skill                                  3056       2879      -5%

TOTAL                                         66394      56387     -15%
```

## Status

This is a **proof-of-concept** specification. This specification is designed to be compatible with most Agent Harness implementations.

## License

[MIT](LICENSE)
