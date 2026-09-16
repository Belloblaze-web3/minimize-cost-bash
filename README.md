# Minimize Cost

Fast GNU Bash submission for the array transfer problem. The cost is `sum |A[i] + T[i]|`; a positive amount can move between positions whose distance is at most `K`, and transferred value cannot be moved again.

## Approach

Moving one unit from a positive source to a negative target reduces the cost by `2`. Thus, maximize the amount matched between positive supplies and reachable negative demands. Process targets from left to right and consume eligible positive sources in FIFO order; the earliest source expires first. The loop is implemented in GNU awk invoked by the Bash wrapper to avoid Bash interpreter overhead on large tests.

## Complexity

| Resource | Complexity |
|---|---:|
| Time | O(N) |
| Extra space | O(N) |

## Run

```bash
printf '3 2\n3 -1 -2\n' | ./solution.sh
```

Expected output: `0`.
