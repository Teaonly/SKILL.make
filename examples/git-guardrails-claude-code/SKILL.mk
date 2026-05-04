---
name: git-guardrails-claude-code
description: Set up Claude Code hooks to block dangerous git commands (push, reset --hard, clean, branch -D, etc.) before they execute. Use when user wants to prevent destructive git operations, add git safety hooks, or block git push/reset in Claude Code.
target: readme ask_scope install customize verify
---

readme:
	Sets up a PreToolUse hook that intercepts and blocks dangerous git commands before Claude executes them.
	When blocked, Claude sees a message that it does not have authority to access these commands.
	Blocked commands:
	- `git push` (all variants including `--force`)
	- `git reset --hard`
	- `git clean -f` / `git clean -fd`
	- `git branch -D`
	- `git checkout .` / `git restore .`

ask_scope:
	?Install for **this project only** (`.claude/settings.json`) or **all projects** (`~/.claude/settings.json`)?

install: ask_scope
	Copy `scripts/block-dangerous-git.sh` to target based on scope:
	- **Project**: `.claude/hooks/block-dangerous-git.sh`
	- **Global**: `~/.claude/hooks/block-dangerous-git.sh`
	@chmod +x <copied-script-path>
	Add to the appropriate settings file. If it already exists, merge into existing `hooks.PreToolUse` array — don't overwrite other settings.
	**Project** (`.claude/settings.json`):
	```json
	{
	  "hooks": {
	    "PreToolUse": [
	      {
	        "matcher": "Bash",
	        "hooks": [
	          {
	            "type": "command",
	            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-dangerous-git.sh"
	          }
	        ]
	      }
	    ]
	  }
	}
	```
	**Global** (`~/.claude/settings.json`):
	```json
	{
	  "hooks": {
	    "PreToolUse": [
	      {
	        "matcher": "Bash",
	        "hooks": [
	          {
	            "type": "command",
	            "command": "~/.claude/hooks/block-dangerous-git.sh"
	          }
	        ]
	      }
	    ]
	  }
	}
	```

customize: install
	?Does the user want to add or remove any patterns from the blocked list? Edit the copied script accordingly.

verify: customize
	@echo '{"tool_input":{"command":"git push origin main"}}' | <path-to-script>
	Should exit with code 2 and print a BLOCKED message to stderr.
