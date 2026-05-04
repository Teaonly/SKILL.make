---
name: obsidian-vault
description: Search, create, and manage notes in the Obsidian vault with wikilinks and index notes. Use when user wants to find, create, or organize notes in Obsidian.
target: search create find_related find_index
---

vault:
	Vault path: `/mnt/d/Obsidian Vault/AI Research/`
	Mostly flat at root level.

naming: vault
	- Index notes aggregate related topics (e.g., `Ralph Wiggum Index.md`, `Skills Index.md`)
	- Title Case for all note names
	- No folders — use links and index notes instead

linking:
	- Use Obsidian `[[wikilinks]]` syntax: `[[Note Title]]`
	- Notes link to dependencies/related notes at the bottom
	- Index notes are just lists of `[[wikilinks]]`

search: vault
	@find "/mnt/d/Obsidian Vault/AI Research/" -name "*.md" | grep -i "keyword"   # Search by filename
	@grep -rl "keyword" "/mnt/d/Obsidian Vault/AI Research/" --include="*.md"     # Search by content
	Or use Grep/Glob tools directly on the vault path.

create: naming linking
	1. Use Title Case for filename
	2. Write content as a unit of learning
	3. Add `[[wikilinks]]` to related notes at the bottom
	4. If part of a numbered sequence, use the hierarchical numbering scheme

find_related: vault linking
	@grep -rl "\\[\\[Note Title\\]\\]" "/mnt/d/Obsidian Vault/AI Research/"   # Find backlinks to a note

find_index: vault naming
	@find "/mnt/d/Obsidian Vault/AI Research/" -name "*Index*"   # Find index notes
