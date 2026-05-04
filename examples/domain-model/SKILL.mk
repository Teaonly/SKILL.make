---
name: domain-model
description: Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when user wants to stress-test a plan against their project's language and documented decisions.
target: readme domain_awareness session
---

readme:
	Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.
	Ask the questions one at a time, waiting for feedback on each question before continuing.
	If a question can be answered by exploring the codebase, explore the codebase instead.

domain_awareness: readme
	?During codebase exploration, look for existing documentation.
	If `CONTEXT-MAP.md` exists at root, repo has multiple contexts — map points to where each one lives. Otherwise single context at root `CONTEXT.md`.
	```
	/
	├── CONTEXT.md
	├── docs/adr/
	│   ├── 0001-event-sourced-orders.md
	│   └── 0002-postgres-for-write-model.md
	└── src/
	```
	Create files lazily — only when you have something to write. No `CONTEXT.md` → create on first resolved term. No `docs/adr/` → create when first ADR needed.

session: readme domain_awareness challenge_glossary sharpen_language concrete_scenarios cross_reference update_context offer_adrs

challenge_glossary: readme
	?When user uses a term conflicting with `CONTEXT.md`, call it out immediately. "Your glossary defines 'cancellation' as X, but you seem to mean Y — which is it?"

sharpen_language: readme
	?When user uses vague or overloaded terms, propose a precise canonical term. "You're saying 'account' — do you mean the Customer or the User? Those are different things."

concrete_scenarios: readme
	?When domain relationships are discussed, stress-test with specific scenarios. Invent scenarios probing edge cases, force user to be precise about boundaries between concepts.

cross_reference: readme
	?When user states how something works, check whether code agrees. Surface contradictions: "Your code cancels entire Orders, but you just said partial cancellation is possible — which is right?"

update_context: readme domain_awareness
	@When a term is resolved, update `CONTEXT.md` immediately — don't batch. Use format in CONTEXT-FORMAT.md.
	Don't couple `CONTEXT.md` to implementation details. Only include terms meaningful to domain experts.

offer_adrs: readme domain_awareness
	?Only offer ADR when all three hold:
	1. Hard to reverse — cost of changing mind later is meaningful
	2. Surprising without context — future reader will wonder "why?"
	3. Result of a real trade-off — genuine alternatives existed
	If any missing, skip the ADR. Use format in ADR-FORMAT.md.
