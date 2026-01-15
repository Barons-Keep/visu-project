#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$SCRIPT_DIR" || exit 1

EXE_FILE=$(find . -maxdepth 1 -type f -name "*.exe" -printf "%f\n" 2>/dev/null)
EXE_COUNT=$(printf "%s\n" "$EXE_FILE" | grep -c .)
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
TESTS=$(find . -type f -name "*test.json" -print0 | xargs -0 echo | sed 's/ /, /g')
OUTPUT_FILE="${TIMESTAMP}_${EXE_FILE%.exe}_run-test.log"
COMMAND="./$EXE_FILE -output \"$OUTPUT_FILE\" --tests \"$TESTS\""

if [ "$EXE_COUNT" -eq 0 ]; then
  echo "ERROR 1: binary was not found"
  exit 1
elif [ "$EXE_COUNT" -gt 1 ]; then
  echo "ERROR 2: found more executables: $EXE_FILE"
  exit 2
fi

eval $COMMAND
