#!/bin/bash

# Input markdown file
input_file="in.md"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file $input_file does not exist."
    exit 1
fi

# Read the input markdown file and store its content
quicknote=$(<"$input_file")

# Split the quicknote by ---- and create files
blocks=$(echo "$quicknote" | awk '/----/ {p=1;next} p')
while read -r block; do
    if [[ ! -z "$block" ]]; then
        timestamp=$(date '+%y%m%d%H%M')
        content=$(echo "$block" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
        title=$(echo "$content" | head -n1 | awk '{print $1" "$2" "$3}' | sed 's/[^a-zA-Z0-9_ ]//g' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr '[:upper:]' '[:lower:]' | cut -c1-20)
        full_title="$timestamp-$title"
        echo -e "# $full_title\n\n$content" > "$full_title.md"
    fi
done <<< "$blocks"
