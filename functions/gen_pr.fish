function gen_pr
    argparse 'p/prompt=' -- $argv
    or return 1

    set -l branch $argv[1]
    set -l file_loc "/tmp/pr.md"

    if test -z "$branch"
        set branch "main"
    end

    set -l message "review the changes between this branch and $branch. Come up with a PR title and description."
    if set -q _flag_prompt
        set message "$message\n$_flag_prompt"
    end

    claude -p $message > $file_loc
    nvim $file_loc
end
