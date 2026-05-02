---
name: improve-codebase-architecture
description: Find deepening opportunities in a codebase, informed by the domain language in CONTEXT.md and the decisions in docs/adr/. Use when the user wants to improve architecture, find refactoring opportunities, consolidate tightly-coupled modules, or make a codebase more testable and AI-navigable.
---

```makefile
# Variables
CONTEXT_FILE = CONTEXT.md
CONTEXT_MAP  = CONTEXT-MAP.md
ADR_DIR      = docs/adr/

# Glossary (LANGUAGE.md) — use these terms exactly in every suggestion.
# Module     — anything with an interface and an implementation.
# Interface  — everything a caller must know: types, invariants, error modes, ordering, config.
# Implementation — the code inside.
# Depth      — leverage at the interface: lots of behaviour behind a small interface.
# Seam       — where an interface lives; a place behaviour can be altered without editing in place.
# Adapter    — a concrete thing satisfying an interface at a seam.
# Leverage   — what callers get from depth.
# Locality   — what maintainers get from depth: change, bugs, knowledge concentrated in one place.
# Deletion test — imagine deleting the module. If complexity vanishes, it was a pass-through.
#                  If complexity reappears across N callers, it was earning its keep.
# Key principles:
#   - The interface is the test surface.
#   - One adapter = hypothetical seam. Two adapters = real seam.

# Target: improve — full architecture improvement workflow
improve: load-context explore present grill

# Target: load-context — read existing domain documentation
load-context:
	? Read CONTEXT.md (or CONTEXT-MAP.md + each CONTEXT.md in a multi-context repo) and relevant ADRs in docs/adr/. If any of these files don't exist, proceed silently — don't flag their absence or suggest creating them upfront.

# Target: explore — walk the codebase for architectural friction
explore: load-context
	$ Use the Agent tool with subagent_type=Explore to walk the codebase organically — don't follow rigid heuristics
	? Note where you experience friction: where does understanding one concept require bouncing between many small modules? Where are modules shallow — interface nearly as complex as the implementation? Where have pure functions been extracted just for testability, but the real bugs hide in how they're called (no locality)? Where do tightly-coupled modules leak across their seams? Which parts are untested or hard to test through their current interface?
	? Apply the deletion test to anything you suspect is shallow: would deleting it concentrate complexity, or just move it? A "yes, concentrates" is the signal you want.

# Target: present — show numbered deepening opportunities
present: explore
	? Present a numbered list of deepening opportunities. For each candidate: Files (which files/modules are involved), Problem (why the current architecture causes friction), Solution (plain English description of what would change), Benefits (explained in terms of locality and leverage, and how tests would improve).
	? Use CONTEXT.md vocabulary for the domain and LANGUAGE.md vocabulary for the architecture. If CONTEXT.md defines "Order," talk about "the Order intake module" — not "the FooBarHandler," and not "the Order service."
	? ADR conflicts: if a candidate contradicts an existing ADR, only surface it when the friction is real enough to warrant revisiting the ADR. Mark it clearly (e.g. "contradicts ADR-0007 — but worth reopening because…"). Don't list every theoretical refactor an ADR forbids.
	? Do NOT propose interfaces yet. Ask the user: "Which of these would you like to explore?"

# Target: grill — grilling conversation for the chosen candidate
grill: present
	? Drop into a grilling conversation. Walk the design tree with the user — constraints, dependencies, the shape of the deepened module, what sits behind the seam, what tests survive.
	? Ask the questions one at a time, waiting for feedback on each before continuing.

# Target: update-context — capture new domain terms inline as decisions crystallize
update-context:
	? Naming a deepened module after a concept not in CONTEXT.md? Add the term to CONTEXT.md — same discipline as /domain-model (see CONTEXT-FORMAT.md). Create the file lazily if it doesn't exist.
	? Sharpening a fuzzy term during the conversation? Update CONTEXT.md right there.

# Target: offer-adr — suggest ADR when rejection carries a load-bearing reason
offer-adr:
	? User rejects a candidate with a load-bearing reason? Offer an ADR, framed as: "Want me to record this as an ADR so future architecture reviews don't re-suggest it?" Only offer when the reason would actually be needed by a future explorer to avoid re-suggesting the same thing — skip ephemeral reasons ("not worth it right now") and self-evident ones. Use the format in ADR-FORMAT.md.
	@ mkdir -p $(ADR_DIR)
```
