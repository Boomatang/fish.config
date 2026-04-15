function gen_pr
    set -l branch $argv[1]
    set -l file_loc "/tmp/pr.md"

    # If the variable 'name' is not set or is empty
    if test -z "$branch"
        set branch "main"
    end
    set -l message "review the changes between this branch and $branch. Come up with a PR title and description"
    claude -p $message > $file_loc

    nvim $file_loc

end
