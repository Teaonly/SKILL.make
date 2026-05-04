---
name: write-a-skill
description: Create new agent skills with proper structure, progressive disclosure, and bundled resources. Use when user wants to create, write, or build a new skill.
target: gather draft review structure template description scripts split checklist
---

gather:
	$Ask user about:
	- What task/domain does the skill cover?
	- What specific use cases should it handle?
	- Does it need executable scripts or just instructions?
	- Any reference materials to include?

draft: structure template scripts split
	@Create SKILL.md with concise instructions
	@Add reference files if content exceeds 500 lines
	@Add utility scripts if deterministic operations needed

review: checklist
	$Present draft and ask:
	- Does this cover your use cases?
	- Anything missing or unclear?
	- Should any section be more/less detailed?

structure:
	skill-name/
	├── SKILL.md           # Main instructions (required)
	├── REFERENCE.md       # Detailed docs (if needed)
	├── EXAMPLES.md        # Usage examples (if needed)
	└── scripts/           # Utility scripts (if needed)
	    └── helper.js

template: description
	---
	name: skill-name
	description: Brief description of capability. Use when [specific triggers].
	---
	# Skill Name
	## Quick start
	[Minimal working example]
	## Workflows
	[Step-by-step processes with checklists for complex tasks]
	## Advanced features
	[Link to separate files: See [REFERENCE.md](REFERENCE.md)]

description:
	The description is the only thing your agent sees when deciding which skill to load.
	Goal: Give your agent just enough info to know:
	1. What capability this skill provides
	2. When/why to trigger it (specific keywords, contexts, file types)
	Format:
	- Max 1024 chars
	- Write in third person
	- First sentence: what it does
	- Second sentence: "Use when [specific triggers]"
	Good:
	@Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when user mentions PDFs, forms, or document extraction.
	Bad:
	@Helps with documents.
	The bad example gives no way to distinguish from other document skills.

scripts:
	Add utility scripts when:
	- Operation is deterministic (validation, formatting)
	- Same code would be generated repeatedly
	- Errors need explicit handling
	Scripts save tokens and improve reliability vs generated code.

split:
	Split into separate files when:
	- SKILL.md exceeds 100 lines
	- Content has distinct domains
	- Advanced features are rarely needed

checklist:
	After drafting, verify:
	@- [ ] Description includes triggers ("Use when...")
	@- [ ] SKILL.md under 100 lines
	@- [ ] No time-sensitive info
	@- [ ] Consistent terminology
	@- [ ] Concrete examples included
	@- [ ] References one level deep
