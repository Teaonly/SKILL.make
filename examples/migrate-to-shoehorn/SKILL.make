---
name: migrate-to-shoehorn
description: Migrate test files from `as` type assertions to @total-typescript/shoehorn. Use when user mentions shoehorn, wants to replace `as` in tests, or needs partial test data.
---

PACKAGE = @total-typescript/shoehorn

# shoehorn replaces `as` assertions with type-safe alternatives in test code only.
# Never use in production code.
#
# Migration patterns:
#   `as Type`            -> fromPartial({ ... })
#   `as unknown as Type` -> fromAny({ ... })
#   Large objects        -> fromPartial() with only needed properties
#
# When to use each:
#   fromPartial() — Pass partial data that still type-checks
#   fromAny()     — Pass intentionally wrong data (keeps autocomplete)
#   fromExact()   — Force full object (swap with fromPartial later)

migrate: gather install find replace verify

gather:
	? Ask user: what test files have `as` assertions causing problems?
	? Are they dealing with large objects where only some properties matter?
	? Do they need to pass intentionally wrong data for error testing?

install:
	@ npm i $(PACKAGE)

find:
	@ grep -r " as [A-Z]" --include="*.test.ts" --include="*.spec.ts"

replace: find
	? Replace `as Type` with `fromPartial()`
	? Replace `as unknown as Type` with `fromAny()`
	? Add imports from $(PACKAGE)

verify: replace
	@ npx tsc --noEmit
