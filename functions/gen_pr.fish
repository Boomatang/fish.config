function gen_pr
    argparse 'h/help' 'p/prompt=' 'i/issue=' -- $argv
    or return 1

    # SECTION: Help
    if set -q _flag_help
        echo "Usage: gen_pr [OPTIONS] [BRANCH]"
        echo ""
        echo "Generate a PR title and description by analyzing changes between branches."
        echo ""
        echo "Arguments:"
        echo "  BRANCH              Target branch to compare against (default: origin/main)"
        echo ""
        echo "Options:"
        echo "  -h, --help          Show this help message"
        echo "  -p, --prompt TEXT   Additional prompt instructions for PR generation"
        echo "  -i, --issue ISSUE   GitHub issue number this PR addresses"
        echo ""
        echo "Examples:"
        echo "  gen_pr                    # Compare against main branch"
        echo "  gen_pr develop            # Compare against develop branch"
        echo "  gen_pr -i 123             # Include issue #123 context"
        echo "  gen_pr -p 'Focus on API changes' remote/main"
        return 0
    end

    # SECTION: general set up
    set -l process_dir "/tmp/gen_pr"
    rm -rf $process_dir
    mkdir -p $process_dir
    echo "Processing..."
    set -l branch $argv[1]

    set -l tools "Bash(git diff*),Bash(git log*),Write($process_dir/*)"


    # SECTION: Setup PR prompt

    if test -z "$branch"
        set branch "origin/main"
    end

    set -l message "Review the changes between this branch and $branch. Come up with a PR title and description. Only the title and description should be return as output. Format should be `<title>\n\n<description>`. There should be no other output. Correct headers levels should be used. ie h1=#, h2=##... There can not be a level 2 header (##) without first having a level 1 header (#). The title does not count as a header. When doing the description there is no need to reference the files that have being added, or updated. "
    if set -q _flag_prompt
        set message "$message\n\n$_flag_prompt"
    end

    if set -q _flag_issue
        set message "$message\n\nThis set of changes is addressing $_flag_issue, add a closes field to the start of the PR description. Also review the issue. If there is a definition of done or acceptance criteria, give a short explanation of how the criteria is being met."
        set tools "$tools,Bash(gh issue view*)"
    end

    set message "$message\n\nAdd this information to @$process_dir/pr.md."

    # SECTION: setting up the issue processing
    set -l parts (string split '/' $branch)
    set -l target "origin"
    if test (count $parts) -eq 2
        set target $parts[1]
    end

    set -l remote_url (git remote get-url $target)
    or begin
        echo "Error: could not resolve remote '$target'"
        return 1
    end
    set -l remote (echo $remote_url | sed -E 's|.*[:/]([^/]+/[^/]+?)(\.git)?$|\1|')
    set -l org (string split '/' $remote)[1]
    set -l repo (string replace -r '\.git$' '' (string split '/' $remote)[2])

    set message "$message\n\nWith the new changes have a second look at the change, and check to see if there is any follow issue that need to be created. If there are follow-up issues possible create a new file in @$process_dir/ for each issue. Creating zero follow up issues is okay, but when issues are be made only make up to 3 issue files. In each issue add the following data as frontmatter: org: $org, repo: $repo, branch: $branch, tags: [gen_pr], pr_url: TBC\n\nThe issue files should match this naming convention: echo `\$(date +%s)-\$(LC_ALL=C tr -dc 'A-Z' < /dev/urandom | head -c 4).md`"


    set message "$message\n\nAs this is for a new PR, do a deep dive code review of all the changes. Add this review to a review.md file. Use all the subagents you can. Be hard in the review, if something is stupid call it out, if there are security concerns call it."

    # SECTION: run AI process
    set -l start (date +%s%N)
    claude --allowedTools $tools --dangerously-skip-permissions -p $message --output-format json > "$process_dir/claude_output.json"
    or begin
        echo "Error: claude command failed"
        return 1
    end
    set -l end (date +%s%N)
    set -l elapsed (math "$end - $start")
    echo "claude runtime $(human_duration -n $elapsed)" > "$process_dir/runtime"
    set -l result (jq -r '"Cost: $\(.total_cost_usd) | Duration: \(.duration_ms)ms | Output Tokens: \(.usage.output_tokens)"' "$process_dir/claude_output.json")
    echo "$result" >> "$process_dir/runtime"

    # SECTION: reviewing the created resources
    set -l editor $EDITOR
    if not set -q EDITOR
        set editor vi
    end
    $editor $process_dir
end
