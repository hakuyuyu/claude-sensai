#!/usr/bin/env python3
"""
Stop hook — appends session metadata to external event log.
Principle 2: Session is a queryable external object, not just a prompt.
Principle 5: OS-like design — log accumulates value over time across model versions.
"""
import json, os, sys
from datetime import datetime

LOG_PATH = os.path.expanduser("~/.claude/events.jsonl")

try:
    data = json.load(sys.stdin)
except Exception:
    data = {}

transcript = data.get("transcript", [])
turns = len([m for m in transcript if isinstance(m, dict) and m.get("role") == "user"])
session_id = data.get("session_id", "unknown")
cwd = data.get("cwd", os.getcwd())

# Extract a lightweight summary: last user message
summary = ""
for msg in reversed(transcript):
    if isinstance(msg, dict) and msg.get("role") == "user":
        content = msg.get("content", "")
        if isinstance(content, list):
            for block in content:
                if isinstance(block, dict) and block.get("type") == "text":
                    summary = block.get("text", "")[:120].replace("\n", " ")
                    break
        elif isinstance(content, str):
            summary = content[:120].replace("\n", " ")
        break

entry = {
    "date": datetime.now().strftime("%Y-%m-%d %H:%M"),
    "session_id": session_id,
    "cwd": cwd,
    "turns": turns,
    "summary": summary,
}

os.makedirs(os.path.dirname(LOG_PATH), exist_ok=True)
with open(LOG_PATH, "a") as f:
    f.write(json.dumps(entry) + "\n")
