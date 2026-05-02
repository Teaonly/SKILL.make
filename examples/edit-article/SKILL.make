---
name: edit-article
description: Edit and improve articles by restructuring sections, improving clarity, and tightening prose. Use when user wants to edit, revise, or improve an article draft.
---

MAX_PARAGRAPH_CHARS = 240

edit-article: plan-sections rewrite-sections

plan-sections:
	? Divide the article into sections based on its headings. Think about the main points to make in each section.
	? Consider that information is a directed acyclic graph — pieces of information can depend on other pieces. Ensure the order of sections and their contents respects these dependencies.

rewrite-sections: plan-sections
	? For each section, rewrite to improve clarity, coherence, and flow.
