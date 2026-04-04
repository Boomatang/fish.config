function human_duration --argument ms
    set -l total_seconds (math "$ms / 1000")
    set -l minutes (math "floor($total_seconds / 60)")
    set -l seconds (math "$total_seconds % 60")

    if test $minutes -gt 0
        printf "%dm %.2fs\n" $minutes $seconds
    else
        printf "%.2fs\n" $seconds
    end
end
