---
name: domain-model
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when user wants to stress-test a plan against their project's language and documented decisions.
disable-model-invocation: true
---

```makefile
# Variables
CONTEXT_FILE = CONTEXT.md
CONTEXT_MAP  = CONTEXT-MAP.md
ADR_DIR      = docs/adr/

# Target: domain-model — full grilling session
domain-model: load-context interview

interview:
	? Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.
	? Ask the questions one at a time, waiting for feedback on each question before continuing.
	? If a question can be answered by exploring the codebase, explore the codebase instead of asking.

# Target: load-context — discover existing domain documentation
load-context:
	? Scan the repo root for CONTEXT.md and docs/adr/. If CONTEXT-MAP.md exists, the repo has multiple bounded contexts — load each CONTEXT.md it points to.

# Target: challenge-glossary — flag terms conflicting with CONTEXT.md
challenge-glossary:
	? When the user uses a term that conflicts with the existing language in CONTEXT.md, call it out immediately: "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

# Target: sharpen-language — propose precise canonical terms for vague language
sharpen-language:
	? When the user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account' — do you mean the Customer or the User? Those are different things."

# Target: test-scenarios — stress-test domain relationships with edge cases
test-scenarios:
	? When domain relationships are being discussed, stress-test them with specific scenarios. Invent scenarios that probe edge cases and force the user to be precise about the boundaries between concepts.

# Target: cross-reference — verify user statements against code
cross-reference:
	? When the user states how something works, check whether the code agrees. If you find a contradiction, surface it: "Your code cancels entire Orders, but you just said partial cancellation is possible — which is right?"

# Target: update-context — capture resolved terms in CONTEXT.md immediately
update-context:
	? When a term is resolved, update CONTEXT.md right there. Don't batch these up — capture them as they happen. Use the format in CONTEXT-FORMAT.md.
	? Don't couple CONTEXT.md to implementation details. Only include terms that are meaningful to domain experts.
	? If CONTEXT.md does not exist, create it when the first term is resolved.

# Target: offer-adr — suggest ADRs only when all three criteria are met
offer-adr:
	? Only offer to create an ADR when all three are true:
	? 1. Hard to reverse — the cost of changing your mind later is meaningful
	? 2. Surprising without context — a future reader will wonder "why did they do it this way?"
	? 3. The result of a real trade-off — there were genuine alternatives and you picked one for specific reasons
	? If any of the three is missing, skip the ADR. Use the format in ADR-FORMAT.md.
	@ mkdir -p $(ADR_DIR)
```
