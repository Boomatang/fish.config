function gen_pr
    argparse 'p/prompt=' 'i/issue=' -- $argv
    or return 1

    set -l branch $argv[1]
    set -l file_loc "/tmp/pr.md"

    echo "Processing..."

    if test -z "$branch"
        set branch "main"
    end

    set -l message "Review the changes between this branch and $branch. Come up with a PR title and description. Only the title and description should be return as output. Format should be `<titile>\n\n<descrition`. There should be other output. Correct headers levels should be used. ie h1=#, h2=##... There can not be a level 2 header (##) without first having a level 1 header (#). The title does not count as a header."
    if set -q _flag_prompt
        set message "$message\n\n$_flag_prompt"
    end

    if set -q _flag_issue
        set message "$message\n\nThis set of changes is address $_flag_issue, add a closes field to the start of the PR description."
    end

    claude -p $message > $file_loc
    nvim $file_loc
end
