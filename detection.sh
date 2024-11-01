#!/bin/bash

DIRECTORY=".."
total_terms=$(wc -l < search_terms.txt)

# Exclude both detection.sh and search_terms.txt
find "$DIRECTORY" -type f \
    -not -name "detection.sh" \
    -not -name "search_terms.txt" | while read -r file; do
    matches=0
    while read -r term; do
        grep -F -q "$term" "$file" && ((matches++))
    done < search_terms.txt
    [ "$matches" -eq "$total_terms" ] && echo "$file"
done