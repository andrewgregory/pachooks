#!/bin/sh

while read -r file; do
    [ -f "$file" ] && [ -x "$file" ] || continue
    if [ -u "$file" ]; then
        printf "warning: setuid binary found: '%s'\n" "$file"
    elif [ -n "$(getcap "$file" 2>/dev/null)" ]; then
        printf "warning: getcap binary found: '%s'\n" "$file"
    fi
done
