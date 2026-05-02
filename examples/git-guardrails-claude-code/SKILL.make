---
name: git-guardrails-claude-code
description: Set up Claude Code hooks to block dangerous git commands (push, reset --hard, clean, branch -D, etc.) before they execute. Use when user wants to prevent destructive git operations, add git safety hooks, or block git push/reset in Claude Code.
---

# Variables
SCRIPT_SRC = scripts/block-dangerous-git.sh
BLOCKED_COMMANDS = git push, git reset --hard, git clean -f, git branch -D, git checkout ., git restore .

# Target: install — full git guardrails setup
install: ask-scope copy-script configure-settings ask-customize verify

ask-scope:
	? Ask the user: install for this project only (.claude/settings.json) or all projects (~/.claude/settings.json)?

copy-script: ask-scope
	ifeq ($(SCOPE),project)
		@ cp $(SCRIPT_SRC) .claude/hooks/block-dangerous-git.sh
		@ chmod +x .claude/hooks/block-dangerous-git.sh
	endif
	ifeq ($(SCOPE),global)
		@ cp $(SCRIPT_SRC) ~/.claude/hooks/block-dangerous-git.sh
		@ chmod +x ~/.claude/hooks/block-dangerous-git.sh
	endif

configure-settings: copy-script
	? Merge the PreToolUse hook into the appropriate settings file based on chosen scope. For project scope add to .claude/settings.json with command "$CLAUDE_PROJECT_DIR"/.claude/hooks/block-dangerous-git.sh. For global scope add to ~/.claude/settings.json with command ~/.claude/hooks/block-dangerous-git.sh. Matcher is "Bash". If the settings file already exists, merge into the existing hooks.PreToolUse array — do not overwrite other settings.

ask-customize: configure-settings
	? Ask the user if they want to add or remove any patterns from the blocked list. Edit the copied script accordingly.

verify: copy-script
	@ echo '{"tool_input":{"command":"git push origin main"}}' | $(HOOK_PATH)
	? Confirm the test exits with code 2 and prints a BLOCKED message to stderr. Report success or failure to the user.
