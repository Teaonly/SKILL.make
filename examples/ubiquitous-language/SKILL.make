---
name: ubiquitous-language
description: Extract a DDD-style ubiquitous language glossary from the current conversation, flagging ambiguities and proposing canonical terms. Saves to UBIQUITOUS_LANGUAGE.md. Use when user wants to define domain terms, build a glossary, harden terminology, create a ubiquitous language, or mentions "domain model" or "DDD".
disable-model-invocation: true
---

```makefile
# Variables
GLOSSARY_FILE = UBIQUITOUS_LANGUAGE.md

# Target: extract — full ubiquitous language extraction
extract: scan identify propose write summary

# Target: scan — scan conversation for domain terms
scan:
	? Scan the conversation for domain-relevant nouns, verbs, and concepts.

# Target: identify — flag terminology problems
identify: scan
	? Identify problems: same word used for different concepts (ambiguity), different words for the same concept (synonyms), vague or overloaded terms.

# Target: propose — build canonical glossary
propose: identify
	? Propose a canonical glossary with opinionated term choices. When multiple words exist for the same concept, pick the best one and list the others as aliases to avoid.
	? Flag conflicts explicitly — if a term is used ambiguously, call it out with a clear recommendation.
	? Only include terms relevant for domain experts. Skip module/class names and generic programming concepts unless they have domain-specific meaning.
	? Keep definitions tight: one sentence max, define what it IS not what it does.

# Target: write — write glossary file
write: propose
	? Write $(GLOSSARY_FILE) in the working directory. Group terms into tables by subdomain, lifecycle, or actor when natural clusters emerge — each table has columns: Term, Definition, Aliases to avoid. If all terms belong to a single cohesive domain, one table is fine.
	? Add a Relationships section using bold term names and cardinality where obvious.
	? Write an example dialogue (3-5 exchanges between a dev and domain expert) that demonstrates how terms interact naturally and clarifies boundaries between related concepts.
	? Include a Flagged ambiguities section calling out any ambiguous usage with clear recommendations.

# Target: summary — output inline summary
summary: write
	? Output a summary inline in the conversation.

# Target: rerun — update existing glossary on re-invocation
rerun: read-existing merge update re-flag rewrite-dialogue

# Target: read-existing — load current glossary
read-existing:
	@ cat $(GLOSSARY_FILE)

# Target: merge — incorporate new terms
merge: read-existing
	? Incorporate any new terms from subsequent discussion.

# Target: update — evolve definitions
update: merge
	? Update definitions if understanding has evolved.

# Target: re-flag — flag new ambiguities
re-flag: update
	? Re-flag any new ambiguities.

# Target: rewrite-dialogue — update example dialogue
rewrite-dialogue: re-flag
	? Rewrite the example dialogue to incorporate new terms.
```

## Output format

Write `UBIQUITOUS_LANGUAGE.md` with this structure:

```md
# Ubiquitous Language

## Order lifecycle

| Term        | Definition                                              | Aliases to avoid      |
| -- | --- | -- |
| **Order**   | A customer's request to purchase one or more items      | Purchase, transaction |
| **Invoice** | A request for payment sent to a customer after delivery | Bill, payment request |

## People

| Term         | Definition                                  | Aliases to avoid       |
| ---| -- | ---- |
| **Customer** | A person or organization that places orders | Client, buyer, account |
| **User**     | An authentication identity in the system    | Login, account         |

## Relationships

- An **Invoice** belongs to exactly one **Customer**
- An **Order** produces one or more **Invoices**

## Example dialogue

> **Dev:** "When a **Customer** places an **Order**, do we create the **Invoice** immediately?"
> **Domain expert:** "No — an **Invoice** is only generated once a **Fulfillment** is confirmed. A single **Order** can produce multiple **Invoices** if items ship in separate **Shipments**."
> **Dev:** "So if a **Shipment** is cancelled before dispatch, no **Invoice** exists for it?"
> **Domain expert:** "Exactly. The **Invoice** lifecycle is tied to the **Fulfillment**, not the **Order**."

## Flagged ambiguities

- "account" was used to mean both **Customer** and **User** — these are distinct concepts: a **Customer** places orders, while a **User** is an authentication identity that may or may not represent a **Customer**.
```
