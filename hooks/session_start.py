#!/usr/bin/env python3
"""
SessionStart hook — loads recent session context from event log.
Principle 2: State is external. Harness transforms it on demand.
"""
import json, os, sys

LOG_PATH = os.path.expanduser("~/.claude/events.jsonl")
RECENT_N = 3  # how many past sessions to surface

if not os.path.exists(LOG_PATH):
    sys.exit(0)

with open(LOG_PATH) as f:
    lines = [l.strip() for l in f if l.strip()]

if not lines:
    sys.exit(0)

recent = lines[-RECENT_N:]
entries = []
for line in recent:
    try:
        entries.append(json.loads(line))
    except Exception:
        pass

if not entries:
    sys.exit(0)

print("=== Recent sessions ===")
for e in entries:
    date = e.get("date", "?")
    cwd = e.get("cwd", "?")
    turns = e.get("turns", "?")
    summary = e.get("summary", "")
    out = f"[{date}] cwd={cwd} turns={turns}"
    if summary:
        out += f" | {summary}"
    print(out)
print("=======================")
