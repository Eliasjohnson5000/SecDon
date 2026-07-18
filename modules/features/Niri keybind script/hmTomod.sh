#!/usr/bin/env bash

# Define input and output files
INPUT_FILE="./input.txt"
OUTPUT_FILE="./output.txt"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

# sed explanation:
# 1. ^([[:space:]]*)           -> Capture leading indentation
# 2. ([^[:space:]]+)           -> Capture the keybind (e.g., Mod+Home)
# 3. [[:space:]]+\{[[:space:]]* -> Match the space and opening brace
# 4. ([^;[:space:]]+)          -> Capture the function name (e.g., focus-column-first)
# 5. ;[[:space:]]*\};?         -> Match the semicolon and closing brace (plus optional trailing ;)
# Replacement: \1"\2".\3 = _:{};

sed -E 's/^([[:space:]]*)([^[:space:]]+)[[:space:]]+\{[[:space:]]*([^;[:space:]]+);[[:space:]]*\};?/\1"\2".\3 = _:{};/' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Transformation complete. Check $OUTPUT_FILE"
