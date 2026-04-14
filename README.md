# claude-sensai

Personal Claude Code setup — config, skills, and tooling based on the "thin harness, fat skills" architecture.

## What's included

| File | Purpose |
|------|---------|
| `config/CLAUDE.md` | Global instructions — who I am, code style, response style, codify-everything rule |
| `config/settings.json` | Claude Code settings — model, hooks (auto-format, .env protection), permissions, plugins |
| `config/.mcp.json` | MCP servers — gbrain knowledge base |
| `setup.sh` | One-command install for a new machine |

## Skills installed by setup

- **[gstack](https://github.com/garrytan/gstack)** — 29 dev workflow skills: `/ship`, `/qa`, `/review`, `/investigate`, `/canary`, `/retro`, `/cso`, `/office-hours`, and more
- **[gbrain](https://github.com/garrytan/gbrain)** — persistent knowledge base with MCP tools for diarization and search

## New machine setup

```bash
git clone https://github.com/hakuyuyu/claude-sensai.git ~/claude-sensai
cd ~/claude-sensai && chmod +x setup.sh && ./setup.sh
```

Then add to `~/.zshrc`:
```bash
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-proj-..."   # for gbrain embeddings
```

Restart Claude Code.

## Keeping in sync

When you change `~/.claude/CLAUDE.md` or `~/.claude/settings.json`, copy them back here and push:

```bash
cp ~/.claude/CLAUDE.md ~/claude-sensai/config/CLAUDE.md
cp ~/.claude/settings.json ~/claude-sensai/config/settings.json
cd ~/claude-sensai && git add -A && git commit -m "sync config" && git push
```

## Architecture

Follows the [thin harness, fat skills](https://www.garrytan.com/p/thin-harness-fat-skills) pattern:
- **Thin harness**: Claude Code + concise CLAUDE.md (~50 lines)
- **Fat skills**: gstack markdown skill files encode all workflow judgment
- **Resolver**: skill descriptions auto-match intent — no need to memorize commands
- **Memory**: `claude-mem` plugin for cross-session persistence
- **Diarization**: gbrain reads and synthesizes knowledge into structured profiles
