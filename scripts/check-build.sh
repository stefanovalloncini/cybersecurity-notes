#!/bin/sh
set -u

base=${1:-out/main}
log=$base.log
blg=$base.blg

if [ ! -f "$log" ]; then
    echo "No log at $log; build first with 'make all'."
    exit 1
fi

problems=0

report() {
    [ -z "$2" ] && return 0
    count=$(printf '%s\n' "$2" | wc -l | tr -d ' ')
    problems=$((problems + count))
    printf '%s (%s):\n' "$1" "$count"
    printf '%s\n' "$2" | sed 's/^/  /'
}

bad_boxes_with_file() {
    awk '
        {
            rest = $0
            while (match(rest, /\(\.\.?\/[^() ]+\.tex/)) {
                file = substr(rest, RSTART + 1, RLENGTH - 1)
                rest = substr(rest, RSTART + RLENGTH)
            }
        }
        /^(Over|Under)full \\[hv]box/ { print file ": " $0 }
    ' "$log"
}

report "Errors" "$(grep -E '^(! |[^ :]+:[0-9]+: )' "$log")"
report "Warnings" "$(grep -E 'Warning: |pdfTeX warning|^Missing character' "$log" | sort -u)"
report "Bad boxes" "$(bad_boxes_with_file)"
if [ -f "$blg" ]; then
    report "Biber warnings and errors" "$(grep -E '(WARN|ERROR) - ' "$blg")"
fi

if [ "$problems" -gt 0 ]; then
    echo "Build check failed: $problems problem(s)."
    exit 1
fi
echo "Build check passed: no errors, warnings, bad boxes or biber warnings."
