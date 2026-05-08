function human_duration
    argparse 'n/ns' -- $argv
    or return

    set -l value $argv[1]
    set -l total_seconds

    if set -q _flag_ns
        # Convert nanoseconds to seconds
        set total_seconds (math "$value / 1000000000")
    else
        # Convert milliseconds to seconds (default behavior)
        set total_seconds (math "$value / 1000")
    end

    set -l minutes (math "floor($total_seconds / 60)")
    set -l seconds (math "$total_seconds % 60")

    if test $minutes -gt 0
        printf "%dm %.4fs\n" $minutes $seconds
    else
        printf "%.4fs\n" $seconds
    end
end
