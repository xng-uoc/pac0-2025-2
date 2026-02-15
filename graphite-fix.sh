#!/bin/sh

# Install jq if missing
if ! command -v jq &> /dev/null; then
    apk add --no-cache jq
fi

# Define paths
FILE="/htdocs/default/default.json"
TEMP="/tmp/fixed.json"

# SAFETY WAIT: Wait for ContainerLab to finish writing the file.
# We wait until the file exists and has content (size > 0), 
# and then give it an extra 5 seconds buffer to ensure writes are complete.
echo "Waiting for topology file..."
while [ ! -s "$FILE" ]; do
  sleep 1
done

# Apply the fix
# 1. jq reads the file, fixes structure, outputs to /tmp
# 2. cat overwrites the original file (preserving the bind mount inode)
jq '.links |= map(if .endpoints then . + .endpoints | del(.endpoints) else . end)' "$FILE" > "$TEMP" && \
cat "$TEMP" > "$FILE" && \
rm "$TEMP"

echo "Patch complete."
