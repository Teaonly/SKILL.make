---
name: design-an-interface
description: >
  Generate multiple radically different interface designs for a module using parallel sub-agents.
  Use when user wants to design an API, explore interface options, compare module shapes,
  or mentions "design it twice".
---

NUM_DESIGNS = 3

# Based on "Design It Twice" from "A Philosophy of Software Design":
# your first idea is unlikely to be the best. Generate multiple radically different designs, then compare.

design: gather generate present compare synthesize

gather:
	? Understand: what problem does this module solve, who are the callers (other modules, external users, tests), what are the key operations, any constraints (performance, compatibility, existing patterns), what should be hidden inside vs exposed.
	? Ask the user: "What does this module need to do? Who will use it?"

generate: gather
	$ Spawn $(NUM_DESIGNS)+ sub-agents in parallel using the Task tool
	? Each sub-agent must produce a radically different approach. Assign different constraints per agent:
	?   Agent 1: "Minimize method count - aim for 1-3 methods max"
	?   Agent 2: "Maximize flexibility - support many use cases"
	?   Agent 3: "Optimize for the most common case"
	?   Agent 4: "Take inspiration from [specific paradigm/library]"
	? Each sub-agent outputs: interface signature (types/methods), usage example, what this design hides internally, trade-offs.

present: generate
	? Show each design sequentially so the user can absorb each approach before comparison.
	? For each design present: interface signature (types, methods, params), usage examples (how callers actually use it), what it hides (complexity kept internal).

compare: present
	? Compare all designs on these criteria — interface simplicity: fewer methods and simpler params means easier to learn and use correctly. General-purpose vs specialized: can it handle future use cases without changes, but beware over-generalization. Implementation efficiency: does the interface shape allow efficient implementation or force awkward internals. Depth: small interface hiding significant complexity is a deep module (good), large interface with thin implementation is shallow (avoid). Ease of correct use vs ease of misuse.
	? Discuss trade-offs in prose, not tables. Highlight where designs diverge most.

synthesize: compare
	? Ask the user: "Which design best fits your primary use case?" and "Any elements from other designs worth incorporating?"
	? Often the best design combines insights from multiple options.

# Anti-patterns
# - Do not let sub-agents produce similar designs — enforce radical difference
# - Do not skip comparison — the value is in contrast
# - Do not implement — this is purely about interface shape
# - Do not evaluate based on implementation effort
