---
name: obsidian-vault
description: Search, create, and manage notes in the Obsidian vault with wikilinks and index notes. Use when user wants to find, create, or organize notes in Obsidian.
---

VAULT_DIR = /mnt/d/Obsidian Vault/AI Research/

obsidian-vault: conventions linking search create backlinks index

conventions:
	? Index notes aggregate related topics (e.g., Ralph Wiggum Index.md, Skills Index.md, RAG Index.md).
	? Title Case for all note names.
	? No folders for organization — use links and index notes instead.

linking:
	? Use Obsidian [[wikilinks]] syntax: [[Note Title]].
	? Notes link to dependencies/related notes at the bottom.
	? Index notes are just lists of [[wikilinks]].

search:
	@ find "$(VAULT_DIR)" -name "*.md" | grep -i "keyword"
	@ grep -rl "keyword" "$(VAULT_DIR)" --include="*.md"
	? Or use Grep/Glob tools directly on the vault path.

create: conventions linking
	? Use Title Case for filename.
	? Write content as a unit of learning (per vault rules).
	? Add [[wikilinks]] to related notes at the bottom.
	? If part of a numbered sequence, use the hierarchical numbering scheme.

backlinks:
	@ grep -rl "\\[\\[Note Title\\]\\]" "$(VAULT_DIR)"

index:
	@ find "$(VAULT_DIR)" -name "*Index*"
