#!/bin/bash
# Double-click to open the ArtPlacer templates at a local web address (needed for the ArtPlacer Sample Room).
# Keep this window open while you browse. Close it (or press Ctrl+C) to stop.
cd "$(dirname "$0")"
PORT=8000
while lsof -iTCP:$PORT -sTCP:LISTEN >/dev/null 2>&1; do PORT=$((PORT+1)); done
echo "ArtPlacer templates running at http://localhost:$PORT/"
echo "Keep this window open while you browse. Close it to stop."
(sleep 1; open "http://localhost:$PORT/index.html") &
if command -v python3 >/dev/null 2>&1 && python3 -c "" >/dev/null 2>&1; then
  python3 -m http.server $PORT --bind 127.0.0.1
elif command -v ruby >/dev/null 2>&1; then
  ruby -run -e httpd . -p $PORT -b 127.0.0.1
else
  echo "Python 3 is needed. macOS will offer to install it (Command Line Developer Tools) - accept, then double-click this file again."
  read -n 1
fi
