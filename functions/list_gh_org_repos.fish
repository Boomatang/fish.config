function list_gh_org_repos

    if test (count $argv) -lt 1 
        echo "Usage: $0 <org-name>" >&2
        exit 1
    end

    set -l org $argv[1]

    # Using gh CLI to list all repos and output SSH URLs
    gh repo list $org --limit 1000 --json sshUrl | jq -r '.[].sshUrl'

end
