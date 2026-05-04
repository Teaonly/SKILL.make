---
name: migrate-to-shoehorn
description: Migrate test files from `as` type assertions to @total-typescript/shoehorn. Use when user mentions shoehorn, wants to replace `as` in tests, or needs partial test data.
target: readme patterns workflow
---

readme:
	shoehorn lets you pass partial data in tests while keeping TypeScript happy. Replaces `as` assertions with type-safe alternatives.
	Test code only. Never use shoehorn in production code.

install: readme
	@npm i @total-typescript/shoehorn

patterns: readme install
	`as Type` → `fromPartial()`:
	{ body: { id: "123" } } as Request → fromPartial({ body: { id: "123" } })

	`as unknown as Type` → `fromAny()`:
	{ body: { id: 123 } } as unknown as Request → fromAny({ body: { id: 123 } })

	fromPartial() - Pass partial data that still type-checks
	fromAny() - Pass intentionally wrong data (keeps autocomplete)
	fromExact() - Force full object (swap with fromPartial later)

workflow: readme install patterns
	?Ask: Which test files have `as` assertions? Large objects or intentionally wrong data?
	@grep -r " as [A-Z]" --include="*.test.ts" --include="*.spec.ts"
	Replace `as Type` → `fromPartial()`, `as unknown as Type` → `fromAny()`
	Add imports from `@total-typescript/shoehorn`
	Run type check to verify
