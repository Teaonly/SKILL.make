---
name: tdd
description: Test-driven development with red-green-refactor loop. Use when user wants to build features or fix bugs using TDD, mentions "red-green-refactor", wants integration tests, or asks for test-first development.
target: philosophy planning tracer_bullet loop refactor checklist
---

philosophy:
	Tests should verify behavior through public interfaces, not implementation details.
	Good tests are integration-style: they exercise real code paths through public APIs and describe _what_ the system does, not _how_.
	Bad tests mock internal collaborators, test private methods, or verify through external means. Warning sign: test breaks on refactor when behavior hasn't changed.
	?See [tests.md](tests.md) for examples and [mocking.md](mocking.md) for mocking guidelines.

antipattern: philosophy
	DO NOT write all tests first, then all implementation. This "horizontal slicing" produces crap tests:
	- Tests written in bulk test imagined behavior, not actual behavior
	- You test the shape of things rather than user-facing behavior
	- Tests pass when behavior breaks, fail when behavior is fine
	Correct approach: vertical slices. One test → one implementation → repeat.
	@WRONG (horizontal): RED: test1,test2,test3 → GREEN: impl1,impl2,impl3
	@RIGHT (vertical): RED→GREEN: test1→impl1, RED→GREEN: test2→impl2, ...

planning:
	Before writing any code:
	- Confirm with user what interface changes are needed
	- Confirm which behaviors to test (prioritize)
	- Identify opportunities for deep modules (small interface, deep implementation)
	- Design interfaces for testability
	- List behaviors to test (not implementation steps)
	- Get user approval on the plan
	Ask: "What should the public interface look like? Which behaviors are most important to test?"
	You can't test everything. Focus on critical paths and complex logic, not every edge case.

tracer_bullet: philosophy antipattern
	Write ONE test that confirms ONE thing about the system:
	@RED:   Write test for first behavior → test fails
	@GREEN: Write minimal code to pass → test passes
	This is your tracer bullet — proves the path works end-to-end.

loop: tracer_bullet
	For each remaining behavior:
	@RED:   Write next test → fails
	@GREEN: Minimal code to pass → passes
	Rules:
	- One test at a time
	- Only enough code to pass current test
	- Don't anticipate future tests
	- Keep tests focused on observable behavior

refactor: loop
	After all tests pass, look for refactor candidates:
	- Extract duplication
	- Deepen modules (move complexity behind simple interfaces)
	- Apply SOLID principles where natural
	- Consider what new code reveals about existing code
	- Run tests after each refactor step
	Never refactor while RED. Get to GREEN first.

checklist:
	Per cycle, verify:
	@- [ ] Test describes behavior, not implementation
	@- [ ] Test uses public interface only
	@- [ ] Test would survive internal refactor
	@- [ ] Code is minimal for this test
	@- [ ] No speculative features added
