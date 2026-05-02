#!/bin/bash

SKILL_SPEC='https://github.com/Teaonly/SKILL.make/blob/main/README.md'

for src in examples/*/SKILL.md; do
    dir=$(dirname "$src")
    out="$dir/SKILL.make"
    [ -f "$out" ] && continue
    echo "Converting $src -> $out"
    claude -p "Read '$SKILL_SPEC' for the SKILL.make format specification. Convert '$src' to SKILL.make format and write the result to '$out'. Keep the frontmatter (name, description). Rewrite all prose rules into Makefile-styled targets with @/\$/? prefixed recipes. Preserve the original intent and behavior. Keeping Makefile simple and small size." \
        --allowedTools "Read,Write,Edit,Bash(find:*)" \
        2>/dev/null
done


# Size comparison report
printf "\n%-40s %10s %10s %8s\n" "File" "SKILL.md" "SKILL.make" "Change"
printf "%-40s %10s %10s %8s\n" "$(printf '%0.s-' {1..40})" "$(printf '%0.s-' {1..10})" "$(printf '%0.s-' {1..10})" "$(printf '%0.s-' {1..8})"

total_old=0
total_new=0
count=0

for src in examples/*/SKILL.md; do
    dir=$(dirname "$src")
    name=$(basename "$dir")
    out="$dir/SKILL.make"

    old=$(wc -c < "$src")
    total_old=$((total_old + old))

    if [ -f "$out" ]; then
        new=$(wc -c < "$out")
        pct=$(( (new - old) * 100 / (old > 0 ? old : 1) ))
        printf "%-40s %10d %10d %+7d%%\n" "$name" "$old" "$new" "$pct"
        total_new=$((total_new + new))
        count=$((count + 1))
    else
        printf "%-40s %10d %10s %8s\n" "$name" "$old" "-" "MISSING"
    fi
done

if [ $count -gt 0 ]; then
    total_pct=$(( (total_new - total_old) * 100 / (total_old > 0 ? total_old : 1) ))
    printf "\n%-40s %10d %10d %+7d%%\n" "TOTAL" "$total_old" "$total_new" "$total_pct"
fi
