---
name: ubiquitous-language
description: Extract a DDD-style ubiquitous language glossary from the current conversation, flagging ambiguities and proposing canonical terms. Saves to UBIQUITOUS_LANGUAGE.md. Use when user wants to define domain terms, build a glossary, harden terminology, create a ubiquitous language, or mentions "domain model" or "DDD".
disable-model-invocation: true
target: readme process output_format rules rerun
---

readme:
	Extract and formalize domain terminology from the current conversation into a consistent glossary, saved to `UBIQUITOUS_LANGUAGE.md`.

process: output_format rules
	1. Scan the conversation for domain-relevant nouns, verbs, and concepts
	2. Identify problems:
	   - Same word used for different concepts (ambiguity)
	   - Different words used for the same concept (synonyms)
	   - Vague or overloaded terms
	3. Propose a canonical glossary with opinionated term choices
	@4. Write to `UBIQUITOUS_LANGUAGE.md` in the working directory using the output format
	@5. Output a summary inline in the conversation

output_format:
	Write a `UBIQUITOUS_LANGUAGE.md` file with this structure:
	# Ubiquitous Language
	## <Group>
	| Term | Definition | Aliases to avoid |
	| ---- | ---------- | ---------------- |
	| **Term** | One-sentence definition | Alias1, Alias2 |
	## Relationships
	- An **X** [cardinality] **Y**
	## Example dialogue
	> **Dev:** ...
	> **Domain expert:** ...
	## Flagged ambiguities
	- "term" was used ambiguously — recommendation.

rules:
	Be opinionated. Pick the best word for each concept; list others as aliases to avoid.
	Flag conflicts explicitly in "Flagged ambiguities" with a clear recommendation.
	Only include domain-relevant terms. Skip module/class names unless they have domain meaning.
	Keep definitions tight. One sentence max. Define what it IS, not what it does.
	Show relationships. Use bold term names and cardinality where obvious.
	Skip generic programming concepts unless they have domain-specific meaning.
	Group into multiple tables when natural clusters emerge (subdomain, lifecycle, actor). Don't force groupings.
	Write an example dialogue (3-5 exchanges) between dev and domain expert clarifying term boundaries.

rerun: process
	When invoked again in the same conversation:
	@1. Read the existing `UBIQUITOUS_LANGUAGE.md`
	2. Incorporate new terms from subsequent discussion
	3. Update definitions if understanding has evolved
	4. Re-flag any new ambiguities
	@5. Rewrite the example dialogue to incorporate new terms
