---
name: write-a-skill
description: Create new agent skills with proper structure, progressive disclosure, and bundled resources. Use when user wants to create, write, or build a new skill.
---

```makefile
# ── write-a-skill: Skill authoring workflow 

# Variables
MAX_SKILL_LINES = 100
MAX_DESC_CHARS = 1024

# Main entry: full skill creation workflow
write-skill: gather-requirements draft-skill review-skill validate

# ── 1. Gather requirements 
gather-requirements:
	? Ask the user about:
	?   - What task/domain does the skill cover?
	?   - What specific use cases should it handle?
	?   - Does it need executable scripts or just instructions?
	?   - Any reference materials to include?

# ── 2. Draft the skill 
draft-skill: gather-requirements
	? Create the skill directory using this structure:
	?   skill-name/
	?   ├── SKILL.md           # Main instructions (required)
	?   ├── REFERENCE.md       # Detailed docs (if needed)
	?   ├── EXAMPLES.md        # Usage examples (if needed)
	?   └── scripts/           # Utility scripts (if needed)
	?       └── helper.js
	? Write SKILL.md with progressive disclosure:
	?   1. Frontmatter: name and description
	?   2. Quick start: minimal working example
	?   3. Workflows: step-by-step processes with checklists for complex tasks
	?   4. Advanced features: link to separate files like REFERENCE.md
	? Write the frontmatter description following these rules:
	?   - Max $(MAX_DESC_CHARS) chars, written in third person
	?   - First sentence: what it does
	?   - Second sentence: "Use when [specific triggers]"
	? Good example: "Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when user mentions PDFs, forms, or document extraction."
	? Bad example: "Helps with documents." — too vague for the agent to distinguish from other skills.
	? Add utility scripts when the operation is deterministic (validation, formatting), the same code would be generated repeatedly, or errors need explicit handling. Scripts save tokens and improve reliability vs generated code.
	? Split into separate files when SKILL.md exceeds $(MAX_SKILL_LINES) lines, content has distinct domains (finance vs sales schemas), or advanced features are rarely needed.

# ── 3. Review with user 
review-skill: draft-skill
	? Present the draft to the user and ask:
	?   - Does this cover your use cases?
	?   - Anything missing or unclear?
	?   - Should any section be more or less detailed?

# ── 4. Validate against checklist 
validate: review-skill
	? Verify all of the following:
	?   - Description includes triggers ("Use when...")
	?   - SKILL.md is under $(MAX_SKILL_LINES) lines
	?   - No time-sensitive information
	?   - Consistent terminology throughout
	?   - Concrete examples are included
	?   - References are at most one level deep
```
