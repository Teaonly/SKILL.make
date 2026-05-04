---
name: design-an-interface
description: Generate multiple radically different interface designs for a module using parallel sub-agents. Use when user wants to design an API, explore interface options, compare module shapes, or mentions "design it twice".
target: readme requirements generate present compare synthesize
---

readme:
	Based on "Design It Twice" from "A Philosophy of Software Design": your first idea is unlikely to be the best. Generate multiple radically different designs, then compare.

requirements: readme
	?What problem does this module solve?
	?Who are the callers? (other modules, external users, tests)
	?What are the key operations?
	?Any constraints? (performance, compatibility, existing patterns)
	?What should be hidden inside vs exposed?

generate: requirements
	@Spawn 3+ sub-agents simultaneously using Task tool. Each must produce a radically different approach.
	Assign different constraint to each agent:
	- Agent 1: "Minimize method count - aim for 1-3 methods max"
	- Agent 2: "Maximize flexibility - support many use cases"
	- Agent 3: "Optimize for the most common case"
	- Agent 4: "Take inspiration from [specific paradigm/library]"
	Each sub-agent outputs:
	1. Interface signature (types/methods)
	2. Usage example (how caller uses it)
	3. What this design hides internally
	4. Trade-offs of this approach

present: generate
	Show each design with:
	1. Interface signature - types, methods, params
	2. Usage examples - how callers actually use it
	3. What it hides - complexity kept internal
	Present sequentially so user can absorb each before comparison.

compare: present criteria
	Compare on: interface simplicity, general-purpose vs specialized, implementation efficiency, depth, ease of correct use vs misuse.
	Discuss trade-offs in prose not tables. Highlight where designs diverge most.

synthesize: compare
	?Which design best fits your primary use case?
	?Any elements from other designs worth incorporating?
	Often the best design combines insights from multiple options.

criteria:
	Interface simplicity: fewer methods, simpler params = easier to learn and use correctly.
	General-purpose: handles future use cases without changes. Beware over-generalization.
	Implementation efficiency: does interface shape allow efficient implementation?
	Depth: small interface hiding significant complexity = deep module (good). Large interface with thin implementation = shallow module (avoid).

antipatterns:
	$Sub-agents must produce radically different designs - reject similar ones
	$Never skip comparison - the value is in contrast
	$Don't implement - purely about interface shape
	$Don't evaluate based on implementation effort
