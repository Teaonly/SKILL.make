---
name: tdd
description: Test-driven development with red-green-refactor loop. Use when user wants to build features or fix bugs using TDD, mentions "red-green-refactor", wants integration tests, or asks for test-first development.
---

```makefile
# ── TDD: Test-Driven Development ──────────────────────────
# Core principle: Tests verify behavior through public interfaces,
# not implementation details. Code can change entirely; tests shouldn't.
#
# Good tests are integration-style — they exercise real code paths through
# public APIs, read like specifications, and survive refactors.
# Bad tests are coupled to implementation — they mock internals, test private
# methods, or verify through external means. Warning sign: test breaks on
# refactor but behavior hasn't changed.
#
# ANTI-PATTERN: Do NOT write all tests first then all implementation
# (horizontal slicing). Use vertical slices only:
#   WRONG:  RED: test1..test5  then  GREEN: impl1..impl5
#   RIGHT:  RED→GREEN: test1→impl1, then test2→impl2, ...
# Each test responds to what you learned from the previous cycle.

# Main entry: full TDD cycle
tdd: plan tracer loop refactor

# ── 1. Planning ───────────────────────────────────────────
plan:
	? Confirm with user what interface changes are needed
	? Confirm with user which behaviors to test — prioritize critical paths
	? Identify opportunities for deep modules (small interface, deep implementation)
	? Design interfaces for testability
	? List the behaviors to test (not implementation steps)
	? Get user approval on the plan
	? Ask: "What should the public interface look like? Which behaviors are most important to test?"
	? Remember: you can't test everything — confirm which behaviors matter most

# ── 2. Tracer Bullet — first RED-GREEN cycle ──────────────
tracer: plan
	? Write ONE test that confirms ONE thing about the system through the public interface
	@ Run the test — it must fail (RED)
	? Write minimal code to make the test pass
	@ Run the test — it must pass (GREEN)

# ── 3. Incremental Loop — remaining behaviors ─────────────
loop: tracer
	? Write next test for ONE remaining behavior — test must fail (RED)
	@ Run the test — confirm it fails
	? Write minimal code to pass — only enough for current test, don't anticipate future tests
	@ Run the test — confirm it passes (GREEN)
	? Verify checklist:
	    - Test describes behavior, not implementation
	    - Test uses public interface only
	    - Test would survive internal refactor
	    - Code is minimal for this test
	    - No speculative features added
	? If behaviors remain, repeat this target

# ── 4. Refactor — clean up after all tests pass ───────────
refactor: loop
	? Extract duplication
	? Deepen modules (move complexity behind simple interfaces)
	? Apply SOLID principles where natural
	? Consider what new code reveals about existing code
	@ Run tests after each refactor step
	? Never refactor while RED — get to GREEN first
```
