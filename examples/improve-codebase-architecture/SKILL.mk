---
name: improve-codebase-architecture
description: Find deepening opportunities in a codebase, informed by the domain language in CONTEXT.md and the decisions in docs/adr/. Use when the user wants to improve architecture, find refactoring opportunities, consolidate tightly-coupled modules, or make a codebase more testable and AI-navigable.
target: readme glossary explore present grill
---

readme:
	Surface architectural friction and propose deepening opportunities — refactors that turn shallow modules into deep ones. Aim is testability and AI-navigability.

glossary: readme
	Use these terms exactly in every suggestion. Don't drift into "component," "service," "API," or "boundary." Full definitions in LANGUAGE.md.
	- **Module** — anything with an interface and an implementation (function, class, package, slice).
	- **Interface** — everything a caller must know to use the module: types, invariants, error modes, ordering, config. Not just the type signature.
	- **Implementation** — the code inside.
	- **Depth** — leverage at the interface: a lot of behaviour behind a small interface. Deep = high leverage. Shallow = interface nearly as complex as the implementation.
	- **Seam** — where an interface lives; a place behaviour can be altered without editing in place.
	- **Adapter** — a concrete thing satisfying an interface at a seam.
	- **Leverage** — what callers get from depth.
	- **Locality** — what maintainers get from depth: change, bugs, knowledge concentrated in one place.
	- **Deletion test** — imagine deleting the module. If complexity vanishes, it was a pass-through. If complexity reappears across N callers, it was earning its keep.
	- **The interface is the test surface.**
	- **One adapter = hypothetical seam. Two adapters = real seam.**

explore: glossary
	@Read existing documentation first: `CONTEXT.md` (or `CONTEXT-MAP.md` + each `CONTEXT.md` in a multi-context repo), relevant ADRs in `docs/adr/`. If files don't exist, proceed silently — don't flag absence or suggest creating them.
	@Use Agent tool with `subagent_type=Explore` to walk the codebase. Explore organically and note friction:
	- Where does understanding one concept require bouncing between many small modules?
	- Where are modules shallow — interface nearly as complex as the implementation?
	- Where have pure functions been extracted just for testability, but real bugs hide in how they're called (no locality)?
	- Where do tightly-coupled modules leak across their seams?
	- Which parts are untested or hard to test through their current interface?
	@Apply deletion test to anything suspected shallow: would deleting it concentrate complexity, or just move it? "Yes, concentrates" is the signal.

present: explore
	@Present a numbered list of deepening opportunities. For each:
	- **Files** — which files/modules are involved
	- **Problem** — why the current architecture causes friction
	- **Solution** — plain English description of what would change
	- **Benefits** — explained in terms of locality and leverage, and how tests would improve
	@Use CONTEXT.md vocabulary for the domain, and LANGUAGE.md vocabulary for the architecture.
	?ADR conflicts: only surface when friction warrants revisiting the ADR. Mark clearly (_"contradicts ADR-0007 — but worth reopening because…"_). Don't list every theoretical refactor an ADR forbids.
	@Do NOT propose interfaces yet. Ask the user: "Which of these would you like to explore?"

grill: present
	Walk the design tree with the user — constraints, dependencies, shape of the deepened module, what sits behind the seam, what tests survive.
	?Naming a deepened module after a concept not in CONTEXT.md? Add the term to CONTEXT.md. See CONTEXT-FORMAT.md. Create file lazily if it doesn't exist.
	?Sharpening a fuzzy term during conversation? Update CONTEXT.md right there.
	?User rejects the candidate with a load-bearing reason? Offer an ADR: _"Want me to record this as an ADR so future architecture reviews don't re-suggest it?"_ Only offer when the reason would help a future explorer. Skip ephemeral or self-evident reasons. See ADR-FORMAT.md.
	?Want to explore alternative interfaces for the deepened module? See INTERFACE-DESIGN.md.
