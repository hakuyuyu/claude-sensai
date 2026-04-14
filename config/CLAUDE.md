# Global Claude Instructions

## Who I am
- Software engineer at Amazon, working primarily on financial tooling and data pipelines
- Primary languages: Python, TypeScript/JavaScript
- Primary environments: macOS local + Amazon dev-dsk (dev-dsk-amandli-2c-a464629e.us-west-2.amazon.com)

## Response style
- Be concise. No filler, no trailing summaries of what you just did.
- Lead with the answer or action, not the reasoning.
- Short sentences. Skip preamble.
- Use markdown only when it genuinely helps (tables, code blocks).

## Code style
- Prefer simple solutions. Don't add abstraction layers, generics, or design patterns unless explicitly asked.
- Don't add docstrings, comments, or type annotations to code you didn't change.
- Don't handle hypothetical edge cases — only validate at real system boundaries.
- No feature flags or backwards-compat shims. Just change the code.
- Don't create new files unless strictly necessary. Edit existing ones.

## What NOT to do without being asked
- Don't refactor surrounding code when fixing a bug.
- Don't add error handling for things that can't happen.
- Don't summarize your changes at the end of a response.
- Don't push to remote repos — commit only, I'll push.
- Don't run `git reset --hard`, `git push --force`, or `rm -rf` without explicit confirmation.
- Don't edit `.env` files.

## Codify everything
- Never do one-off work. If a task will recur, do it manually on 3–10 examples first, show output, then codify it as a skill file if approved.
- If it should run automatically, put it on a cron.
- If I have to ask for the same thing twice, that's a failure — it should have become a skill the first time.

## Verification standard
When fixing bugs or adding features, always include how to verify: which test to run, what output to expect.

## Context compression — always preserve
- Current task goal and which files are in scope
- Any architectural decisions made this session
- Test commands and their current pass/fail state

## Projects
- `~/code/flaw` — personal financial assistant (Python, uses Gmail, Google Calendar, various financial APIs)
- MCP servers in use: discord-cli, twitter-cli, yfinance — keep these, disable others to save context
