#!/usr/bin/env bash
# claude-sensai setup — run once on a new machine
set -e

echo "=== Claude Sensai Setup ==="
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# ── 1. Prerequisites ──────────────────────────────────────────
if ! command -v bun >/dev/null 2>&1; then
  echo "Installing bun..."
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi

# ── 2. Copy config files ──────────────────────────────────────
echo "Copying Claude config files..."
mkdir -p ~/.claude
cp "$REPO_DIR/config/CLAUDE.md"     ~/.claude/CLAUDE.md
cp "$REPO_DIR/config/settings.json" ~/.claude/settings.json
cp "$REPO_DIR/config/.mcp.json"     ~/.claude/.mcp.json
echo "  ✓ CLAUDE.md, settings.json, .mcp.json"

# ── 3. Install gstack skills ──────────────────────────────────
echo "Installing gstack..."
if [ ! -d "$HOME/.claude/skills/gstack" ]; then
  git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack
fi
cd ~/.claude/skills/gstack && ./setup --host claude --no-prefix
echo "  ✓ gstack skills installed"

# ── 4. Install gbrain ─────────────────────────────────────────
echo "Installing gbrain..."
if [ ! -d "$HOME/gbrain" ]; then
  git clone https://github.com/garrytan/gbrain.git ~/gbrain
fi
cd ~/gbrain && bun install && bun link
gbrain init
echo "  ✓ gbrain installed"

# ── 5. Install claude-mem plugin ─────────────────────────────
echo "Installing claude-mem plugin..."
claude plugin install claude-mem@thedotmack --scope user
echo "  ✓ claude-mem installed"

# ── 6. API keys reminder ──────────────────────────────────────
echo ""
echo "=== Action required ==="
echo "Add these to ~/.zshrc if not already set:"
echo ""
echo "  export OPENAI_API_KEY=\"sk-proj-...\"   # required for gbrain embeddings"
echo "  export ANTHROPIC_API_KEY=\"sk-ant-...\" # required for Claude Code"
echo ""
echo "Then restart your terminal and Claude Code."
echo ""
echo "=== Optional: populate gbrain with your projects ==="
echo "  gbrain import ~/code/flaw/ --no-embed && gbrain embed --stale"
echo ""
echo "Done."
