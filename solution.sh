#!/usr/bin/env bash

# Fast GNU Bash submission for HackerEarth.
# The actual O(N) loop runs in GNU awk because Bash loops over 100,000
# elements can exceed a one-second time limit.

exec awk '
{
    for (i = 1; i <= NF; i++) {
        input[++count] = $i
    }
}
END {
    n = input[1]
    k = input[2]

    initial = 0
    for (i = 1; i <= n; i++) {
        a[i] = input[i + 2]
        if (a[i] < 0) {
            initial -= a[i]
        } else {
            initial += a[i]
        }
    }

    # FIFO of positive source positions and their unused amounts.
    head = 1
    tail = 0
    next_source = 1
    matched = 0

    for (target = 1; target <= n; target++) {
        # A source at position i can reach target if i <= target + k.
        right_limit = target + k
        while (next_source <= n && next_source <= right_limit) {
            if (a[next_source] > 0) {
                source_pos[++tail] = next_source
                source_amount[tail] = a[next_source]
            }
            next_source++
        }

        if (a[target] >= 0) {
            continue
        }

        need = -a[target]
        left_limit = target - k

        # Discard sources whose reachable interval has expired.
        while (head <= tail && source_pos[head] < left_limit) {
            head++
        }

        # Earliest source expires first, so consume FIFO.
        while (need > 0 && head <= tail) {
            available = source_amount[head]
            if (available <= need) {
                matched += available
                need -= available
                head++
            } else {
                matched += need
                source_amount[head] = available - need
                need = 0
            }
        }
    }

    # Each matched unit changes |positive| + |negative| by -2.
    answer = initial - 2 * matched
    printf "%.0f\n", answer
}
' 
