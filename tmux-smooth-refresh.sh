#!/usr/bin/env bash
# Forces extra tmux status-bar redraws so text scrollers (the daily
# affirmation marquee) animate smoothly. status-interval is limited to
# whole seconds, which is too coarse for a per-character scroll.

LOCK_FILE="${TMPDIR:-/tmp}/tmux-smooth-refresh.pid"

if [ -f "$LOCK_FILE" ]; then
  existing_pid=$(cat "$LOCK_FILE" 2>/dev/null)
  if [ -n "$existing_pid" ] && kill -0 "$existing_pid" 2>/dev/null; then
    exit 0
  fi
fi

echo $$ >"$LOCK_FILE"

while true; do
  tmux refresh-client -S >/dev/null 2>&1 || break
  sleep 0.15
done

rm -f "$LOCK_FILE"
