#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
run(){ local a; a=$(printf '%s' "$1" | "$root/solution.sh"); [[ "$a" == "$2" ]] || { echo "FAIL: $a != $2"; exit 1; }; }
run $'3 2\n3 -1 -2\n' 0
run $'3 1\n3 -1 -2\n' 4
run $'2 0\n5 -10\n' 15
echo 'All tests passed.'
