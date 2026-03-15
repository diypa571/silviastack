#!/bin/bash
# systemwatcher.sh - Monitor /var/www for file changes and send SMS notifications
# Uses a 20-second batch window: collects all changes, then sends ONE summary SMS

WATCH_DIR="/var/www"
API_URL="http://ip:portnummer/send"
PHONE="+46000000000"
BATCH_SECONDS=20  # collect changes for this many seconds, then send one SMS
BATCH_FILE="/tmp/systemwatcher_batch.txt"
LOCK_FILE="/tmp/systemwatcher.lock"

# Check if inotifywait is installed
if ! command -v inotifywait &> /dev/null; then
    echo "inotify-tools not installed. Install with: sudo apt install inotify-tools"
    exit 1
fi

# Check if watch directory exists
if [ ! -d "$WATCH_DIR" ]; then
    echo "Directory $WATCH_DIR does not exist."
    exit 1
fi

# Clean up on exit
cleanup() {
    rm -f "$BATCH_FILE" "$LOCK_FILE"
    kill $(jobs -p) 2>/dev/null
    exit 0
}
trap cleanup SIGINT SIGTERM EXIT

# Initialize batch file
> "$BATCH_FILE"
rm -f "$LOCK_FILE"

# Function to send batched SMS
send_batch() {
    sleep "$BATCH_SECONDS"

    if [ -s "$BATCH_FILE" ]; then
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        CHANGES=$(sort -u "$BATCH_FILE")
        FILE_COUNT=$(echo "$CHANGES" | wc -l)

        MESSAGE="FILE ALERT [$TIMESTAMP]
${FILE_COUNT} file(s) changed in last ${BATCH_SECONDS}s:
$CHANGES"

        echo ""
        echo "=== SENDING SMS ==="
        echo "$MESSAGE"
        echo "==================="

        curl -s -X POST "$API_URL" \
            --data-urlencode "phoneno=$PHONE" \
            --data-urlencode "message=$MESSAGE"

        echo ""
        echo "SMS sent."

        # Clear the batch file
        > "$BATCH_FILE"
    fi

    rm -f "$LOCK_FILE"
}

echo "Watching $WATCH_DIR for .php/.html/.htm changes (batched every ${BATCH_SECONDS}s)..."
echo "Press Ctrl+C to stop."

# Use process substitution to avoid subshell issue with pipes
while read FILEPATH EVENT; do
    # Skip directory events
    if [ -d "$FILEPATH" ] 2>/dev/null; then
        continue
    fi

    # Skip temporary files
    FILENAME=$(basename "$FILEPATH")
    if [[ "$FILENAME" == *.tmp.* ]]; then
        continue
    fi

    # Only process PHP, HTML, and HTM files
    EXT="${FILENAME##*.}"
    if [[ "$EXT" != "php" && "$EXT" != "html" && "$EXT" != "htm" ]]; then
        continue
    fi

    # Wait briefly for file to settle
    sleep 0.2
    if [ ! -f "$FILEPATH" ]; then
        continue
    fi

    ENTRY="[$EVENT] $FILEPATH"
    echo "$ENTRY" >> "$BATCH_FILE"
    echo "Queued: $ENTRY"

    # Start a background sender if one isn't already running
    if [ ! -f "$LOCK_FILE" ]; then
        touch "$LOCK_FILE"
        send_batch &
    fi

done < <(inotifywait -m -r -e create -e modify -e moved_to --format '%w%f %e' "$WATCH_DIR")
